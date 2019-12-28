
function _convert(ctx::ConverterContext, decl::CLMacroDefinition)
	loc = string(CodeLocation(decl))
	name = _convertName(ctx, decl)
	func = _gensym(ctx, name)*"_"
	tokens = map(t -> t.text, tokenize(decl))
	
	args = []
	if isfunctionlike(decl) != 0
		tokens[2] == "(" || error("Macro was expected to be function-like.")
		
		i = 3
		while i <= length(tokens) && tokens[i] != ")"
			tokens[i] != "," && push!(args, _convertName(ctx, tokens[i]))
			i += 1
		end
		i += 1  # skip the closing paren ')'
		
		if !isempty(args) && args[end] == :(...)
			args[end] = "$(_gensym(ctx, "args"))..."
		end
		
		tokens = tokens[i:end]
	else
		tokens = tokens[2:end]
	end
	
	literal = nothing
	if !isempty(tokens) && tokens[1] == "(" && tokens[end] == ")"
		tokens = tokens[2:end-1]
	end
	
	# parse C string literal
	if isnothing(literal) && length(tokens) == 1
		literal = _parseString(tokens[1])
	end
	
	# parse C character literal
	if isnothing(literal) && length(tokens) == 1
		literal = _parseChar(tokens[1])
	end
	
	# parse C integer literal
	if isnothing(literal) && length(tokens) in (1, 2)
		literal = _parseInteger(join(tokens))
	end
	
	# parse C floating point literal
	if isnothing(literal) && length(tokens) == 1
		literal = _parseFloat(tokens[1])
	end
	
	# parse C symbol/token literal
	if isnothing(literal) && length(tokens) == 1
		literal = _parseSymbol(tokens[1])
		literal = isnothing(literal) ? literal : Symbol(_convertName(ctx, literal))
	end
	
	# parse C expressions
	if isnothing(literal)
		literal = _parseExpr(join(tokens, ' '))
	end
	
	# parse C expressions
	if isnothing(literal)
		literal = _parseExpr(join(tokens))
	end
	
	
	if isempty(tokens)
		body = "nothing"
	elseif !isnothing(literal)
		body = literal isa Symbol || literal isa Expr ? replace(repr(literal), r"#=.*=# " => "") : ":($(repr(literal)))"
	else
		body = """:(@CBinding().error("Macro not converted:  "*$(repr(join(tokens, ' ')))))"""
	end
	body = """function($(join(args, ", ")))
		$(body)
	end"""
	
	
	if !("@$(name)" in ctx.oneofs)
		push!(ctx.oneofs, "@$(name)")
		
		_export(ctx, "@$(name)")
		binding = "const $(func) = @CBinding().Ref{@CBinding().Function}($(body))"
		expr = "macro $(name)($(join(args, ", "))) ; $(func)[]($(join(args, ", "))) ; end"
		push!(ctx.converted, JuliaizedC(
			decl,
			binding,
			:atcompile,
		))
		push!(ctx.converted, JuliaizedC(
			decl,
			expr,
			:atcompile,
		))
	else
		expr = "$(func)[] = $(body)"
		push!(ctx.converted, JuliaizedC(
			decl,
			expr,
			:atcompile,
		))
	end
end
