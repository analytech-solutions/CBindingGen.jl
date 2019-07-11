

function _parseString(str)
	if length(str) > 1 && str[1] == '"' && str[end] == '"'
		try
			temp::String = Meta.parse(replace(str, '$' => "\$"))
			return temp
		catch
		end
	end
	return nothing
end

function _parseChar(str)
	if length(str) > 1 && str[1] == '\'' && str[end] == '\''
		try
			temp::Char = Meta.parse(str)
			return temp
		catch
		end
	end
	return nothing
end

function _parseInteger(str)
	m = match(r"^([-])?(0|0x|0b)?([0-9A-Fa-f]+)([ulUL]*)$", lowercase(str))
	if m !== nothing
		us = count(isequal('u'), m.captures[4])
		ls = count(isequal('l'), m.captures[4])
		if us in (0, 1) && ls in (0, 1 ,2)
			typ = ls == 0 ? Cint : (ls == 1 ? Clong : Clonglong)
			typ = us == 1 || m.captures[2] !== nothing ? unsigned(typ) : typ
			
			prefix = m.captures[2] === nothing ? "" : (m.captures[2] == "0" ? "0o" : m.captures[2])
			try
				literal = parse(typ, prefix*m.captures[3])
				if m.captures[1] == "-"
					literal = -literal
				end
				return literal
			catch
			end
		end
	end
	return nothing
end

function _parseFloat(str)
	if !isempty(str)
		typ = str[end] in ('l', 'L') ? nothing #= TODO: use 128-bit float when available =# : str[end] in ('f', 'F') ? Cfloat : Cdouble
		value = str[end] in ('l', 'L', 'f', 'F') ? str[1:end-1] : str
		value = value[1] == '.' ? "0"*value : value
		try
			return parse(typ, value)
		catch
		end
	end
	return nothing
end

function _parseSymbol(str)
	m = match(r"^[A-Za-z0-9_]+$", str)
	if m !== nothing
		return str
	end
	return nothing
end

function _parseExpr(str)
	try
		temp = Meta.parse(str)
		Base.is_expr(temp, :incomplete) || return temp
	catch
	end
	return nothing
end



function _convertLiteral(ctx, decl::Clang.CLIntegerLiteral)
	tokens = Clang.tokenize(decl)
	length(tokens) == 1 || error("Unable to handle more than 1 token for an integer literal")
	result = _parseInteger(tokens[1])
	isnothing(result) && error("Failed to parse integer literal")
	return result
end



#=
	function _prejuliaize(ctx, decl)
		if haskey(ctx.macroUses, _extent(decl))
			name = ctx.macroUses[_extent(decl)]
			tokens = map(t -> t.text, tokenize(decl))
			args = []
			for i in 3:length(tokens)-1
				push!(args, tokens[i] == "," ? ", " : tokens[i])
			end
			return Expr(:macrocall, Symbol('@', name), LineNumberNode(@__LINE__, Symbol(@__FILE__)), (isempty(args) ? () : (:(error($(join(args)))),))...)
		else
			return _juliaize(ctx, decl)
		end
	end
	
	function _juliaize(ctx, decl)
		error(_where(decl)*"   "*string(string(decl) => map(string, Clang.children(decl))))
	end
	
	function _juliaize(ctx, decl::Clang.CLUnaryExpr)
		c = Clang.children(decl)
		length(c) == 1 || error("Expected exactly 1 children of a unary expression.")
		tokens = Clang.tokenize(decl)
		length(tokens) > 1 || error("Not enough tokens in unary expression.")
		
		return :($(Symbol(first(tokens).text))($(_prejuliaize(ctx, first(c)))))
	end
	
	function _juliaize(ctx, decl::Clang.CLUnaryOperator)
		c = Clang.children(decl)
		length(c) == 1 || error("Expected exactly 1 children of a unary operator.")
		tokens = Clang.tokenize(decl)
		length(tokens) == (length(Clang.tokenize(first(c))) + 1) || error("Tokens don't map correctly in unary operator.")
		
		op = Symbol(strip(first(tokens).text))
		if op === :!
			op = :cnot
		elseif op === :*
			op = :unsafe_load
		elseif op === :&
			op = :addr_of
		elseif !(op in (:-, :~))
			error("Unhandled unary operator '$(op)'.")
		end
		
		return :($(op)($(_prejuliaize(ctx, first(c)))))
	end
	
	function _juliaize(ctx, decl::Clang.CLBinaryOperator)
		c = Clang.children(decl)
		length(c) == 2 || error("Expected exactly 2 children of a binary operator.")
		
		tokens = Clang.tokenize(decl)
		length(tokens) == (length(Clang.tokenize(first(c))) + length(Clang.tokenize(last(c))) + 1) || error("Tokens don't map correctly in binary operator.  $(map(t -> strip(t.text), Clang.tokenize(decl)))  $(map(string, Clang.children(decl)))")
		
		op = Symbol(strip(tokens[length(Clang.tokenize(first(c)))+1].text))
		return Expr(:call, op, _prejuliaize(ctx, first(c)), _prejuliaize(ctx, last(c)))
	end
	
	function _juliaize(ctx, decl::Clang.CLCStyleCastExpr)
		c = Clang.children(decl)
		length(c) == 2 || error("Expected exactly 2 children of a cast expression.")
		return :(reinterpret($(_prejuliaize(ctx, first(c))), $(_prejuliaize(ctx, last(c)))))
	end
	
	function _juliaize(ctx, decl::Clang.CLStmtExpr)
		c = Clang.children(decl)
		length(c) == 1 || error("Expected exactly 1 child of a statement expression.")
		return _prejuliaize(ctx, first(c))
	end
	
	function _juliaize(ctx, decl::Clang.CLCallExpr)
		c = Clang.children(decl)
		length(c) >= 1 || error("Expected a function name to be used in a call expression.")
		return :($(_prejuliaize(ctx, first(c)))($(map(x -> _prejuliaize(ctx, x), c[2:end])...)))
	end
	
	_juliaize(ctx, decl::Clang.CLVarDecl) = nothing #:($(_c2julia(ctx, decl)) = $(_c2julia(ctx, Clang.type(decl))))  # TODO: need better way of constructing the variable
	_juliaize(ctx, decl::Clang.CLTypeRef) = _c2julia(ctx, Clang.type(decl))
	
	function _juliaize(ctx, decl::Clang.CLDeclStmt)
		c = Clang.children(decl)
		length(c) == 1 || error("Unable to handle declaration statements with more than 1 child.")
		return _prejuliaize(ctx, first(c))
	end
	
	function _juliaize(ctx, decl::Clang.CLGotoStmt)
		c = Clang.children(decl)
		length(c) == 1 || error("Unable to handle goto statements without 1 child.")
		return :(@goto $(_prejuliaize(ctx, first(c))))
	end
	
	function _juliaize(ctx, decl::Clang.CLLabelStmt)
		c = Clang.children(decl)
		length(c) == 1 || error("Unable to handle label statements without 1 child.")
		return :(@label $(_c2julia(ctx, decl)) ; $(_prejuliaize(ctx, first(c))))
	end
	
	_juliaize(ctx, decl::Clang.CLLabelRef) = _c2julia(ctx, decl)
	_juliaize(ctx, decl::Clang.CLDeclRefExpr) = _c2julia(ctx, decl)
	
	function _juliaize(ctx, decl::Clang.CLReturnStmt)
		length(Clang.children(decl)) == 1 || error("Wrong number of children in return statement.")
		return :(return $(_prejuliaize(ctx, first(Clang.children(decl)))))
	end
	
	function _juliaize(ctx, decl::Clang.CLMemberRefExpr)
		c = Clang.children(decl)
		length(c) == 1 || error("Unable to handle member reference expressions with anything other than 1 child.")
		return :($(_prejuliaize(ctx, first(c))).$(_c2julia(ctx, decl)))
	end
	
	function _juliaize(ctx, decl::Clang.CLUnexposedExpr)
		c = Clang.children(decl)
		length(c) == 1 || error("Unable to handle unexposed expressions with anything other than 1 child.")
		return _prejuliaize(ctx, first(c))
	end
	
	function _juliaize(ctx, decl::Clang.CLCompoundStmt)
		return :(let ; $(filter(!isnothing, map(x -> _prejuliaize(ctx, x), Clang.children(decl)))...) end)
	end
	
	function _juliaize(ctx, decl::Clang.CLIfStmt)
		c = Clang.children(decl)
		length(c) == 2 || error("Expected a function name to be used in an if statement.")
		return :(if ($(_prejuliaize(ctx, first(c)))) ; $(_prejuliaize(ctx, last(c))) end)
	end
	
	function _juliaize(ctx, decl::Clang.CLIntegerLiteral)
		tokens = Clang.tokenize(decl)
		length(tokens) == 1 || error("Unable to handle more than 1 token for an integer literal.  $(map(t -> strip(t.text), tokens))")
		result = _parseInteger(tokens[1])
		return result === nothing ? Symbol(tokens[1]) : result
	end
	
	function _juliaize(ctx, decl::Clang.CLConditionalOperator)
		c = Clang.children(decl)
		length(c) == 3 || error("Expected exactly 3 children of a ternary operator.")
		return :(($(_prejuliaize(ctx, first(c)))) ? ($(_prejuliaize(ctx, c[2]))) : ($(_prejuliaize(ctx, last(c)))))
	end
	
	function _juliaize(ctx, decl::Clang.CLParenExpr)
		c = Clang.children(decl)
		length(c) == 1 || error("Expected 1 child in a paren expression.")
		return :(($(_prejuliaize(ctx, first(c)))))
	end
	
	function _juliaize(ctx, decl::Clang.CLFunctionDecl)
		c = Clang.children(decl)
		length(c) > 1 || error("Unable to handle inline function declarations without more than 1 child.")  # NOTE:  the last child is the contents of the function
		last(c) isa Clang.CLCompoundStmt || error("Expected inline function declaration to have a compount statement for its body.")
		return filter(!isnothing, map(x -> _prejuliaize(ctx, x), Clang.children(last(c))))
	end
=#
