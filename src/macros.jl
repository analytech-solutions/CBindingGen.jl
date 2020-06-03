function tokenize(tu::LibClang.CXTranslationUnit, cursor::LibClang.CXCursor)
	tokens = Ref{Ptr{LibClang.CXToken}}(C_NULL)
	count = Ref{Cuint}(0)
	try
		cxrange = LibClang.clang_getCursorExtent(cursor)
		LibClang.clang_tokenize(tu, cxrange, tokens, count)
		
		return map(1:count[]) do i
			token = unsafe_load(tokens[], i)
			kind = LibClang.clang_getTokenKind(token)
			text = string(tu, token)
			return kind => text
		end
	finally
		tokens[] == C_NULL || LibClang.clang_disposeTokens(tu, tokens[], count[])
	end
end


function convert_macro(tu::LibClang.CXTranslationUnit, cursor::LibClang.CXCursor, exports::Vector{String})
	name = convert_name(cursor)
	expr = nothing
	deps = Set{String}()
	tokens = []
	try
		Bool(LibClang.clang_Cursor_isMacroFunctionLike(cursor)) && error("Function-like macros are not yet supported")
		
		tokens = tokenize(tu, cursor)
		e = convert_macro_def(deps, tokens, 2:length(tokens))  # NOTE: first token is the macro identifier itself, so skip it
		if !isnothing(e)
			Meta.parse(e)
			expr = e
		end
	catch
		tokens = isempty(tokens) ? "" : "\n"*join(map(last, tokens), ' ')
		@warn "Unable to convert macro `$(name)` near $(string(CodeLocation(cursor)))$(tokens)"
	end
	isnothing(expr) && return nothing
	
	expr = "macro $(name)() return 𝐣𝐥.esc(quote $(expr) end) end"
	comments = Dict{String, Comment}(convert_comment(cursor, "@"*name))
	
	if isempty(deps) && !(name in exports)  # if macro has no deps and not yet exported, declare a const
		expr = "$(expr)\nconst $(name) = (@$(name))"
		push!(comments, convert_comment(cursor, name))
	end
	
	return name => Converted(expr, comments)
end


function convert_macro_def(deps::Set{String}, tokens::Vector{<:Pair}, range::UnitRange)
	if length(range) <= 0
		return nothing
	elseif length(range) == 1 && tokens[range.start].first == LibClang.CXToken_Identifier
		sym = tokens[range.start].second
		push!(deps, sym)
		return "(@$(sym))"
	elseif length(range) == 1 && tokens[range.start].first == LibClang.CXToken_Literal
		return convert_literal(tokens[range.start].second)
	elseif length(range) >= 1 && all(i -> tokens[i].first == LibClang.CXToken_Keyword, range)
		return convert_keyword(join(map(i -> tokens[i].second, range), ' '))
	elseif length(range) >= 2 && tokens[range.start].first == LibClang.CXToken_Punctuation && tokens[range.start].second in ("+", "-", "~")
		return convert_operator(tokens[range.start].second)*convert_macro_def(deps, tokens, (range.start+1):range.stop)
	elseif tokens[range.start] in (
			(LibClang.CXToken_Punctuation => "("),
			(LibClang.CXToken_Punctuation => "{"),
			(LibClang.CXToken_Punctuation => "["),
	)
		(pre, post) = if tokens[range.start] == (LibClang.CXToken_Punctuation => "(")
			("(", ")")
		elseif tokens[range.start] == (LibClang.CXToken_Punctuation => "{")
			("begin", "end")
		elseif tokens[range.start] == (LibClang.CXToken_Punctuation => "[")
			("[(", ") + 1]")
		end
		
		sub = find_subrange(tokens, range)
		cvt = pre*convert_macro_def(deps, tokens, (sub.start+1):(sub.stop-1))*post
		
		return sub.stop == range.stop ? cvt : cvt*" "*convert_macro_def(deps, tokens, (sub.stop+1):range.stop)
	end
	
	error("Unhandled macro conversion:  $(join(map(last, tokens[range]), ' '))")
end


function find_subrange(tokens::Vector{<:Pair}, range::UnitRange)
	inc = tokens[range.start]
	dec = if inc == (LibClang.CXToken_Punctuation => "(")
		LibClang.CXToken_Punctuation => ")"
	elseif inc == (LibClang.CXToken_Punctuation => "{")
		LibClang.CXToken_Punctuation => "}"
	elseif inc == (LibClang.CXToken_Punctuation => "[")
		LibClang.CXToken_Punctuation => "]"
	end
	
	depth = 0
	stop = 0
	for ind in range.start:range.stop
		stop = ind
		tokens[stop] == inc && (depth += 1)
		tokens[stop] == dec && (depth -= 1)
		depth == 0 && break
	end
	depth == 0 || error("Failed to find subrange $(join(map(last, tokens[range]), ' '))")
	return range.start:stop
end


function convert_keyword(keywords::String)
	if keywords in ("char", "signed char")
		return "\$(𝐣𝐥.Cchar)"
	elseif keywords in ("int",)
		return "\$(𝐣𝐥.Cint)"
	elseif keywords in ("short", "short int")
		return "\$(𝐣𝐥.Cshort)"
	elseif keywords in ("long", "long int",)
		return "\$(𝐣𝐥.Clong)"
	elseif keywords in ("long long", "long long int")
		return "\$(𝐣𝐥.Clonglong)"
	elseif keywords in ("unsigned char",)
		return "\$(𝐣𝐥.Cuchar)"
	elseif keywords in ("unsigned int",)
		return "\$(𝐣𝐥.Cuint)"
	elseif keywords in ("unsigned short", "unsigned short int")
		return "\$(𝐣𝐥.Cushort)"
	elseif keywords in ("unsigned long", "unsigned long int")
		return "\$(𝐣𝐥.Culong)"
	elseif keywords in ("unsigned long long", "unsigned long long int")
		return "\$(𝐣𝐥.Culonglong)"
	elseif keywords in ("extern",)
		return nothing
	end
	
	error("Unhandled keywords:  $(keywords)")
end


function convert_literal(literal::String)
	m = match(r"^'(.*)'$", literal)
	!isnothing(m) && return repr(Meta.parse(m.match))
	
	m = match(r"^\"(.*)\"$", literal)
	!isnothing(m) && return repr(Meta.parse(m.match))
	
	m = match(r"^(0|0x|0b)?([\da-f]+)([ul]*)$", lowercase(literal))
	if !isnothing(m)
		(pre, val, suf) = m.captures
		isUnsigned = occursin('u', suf)
		howLong = count(isequal('l'), suf)
		
		typ = howLong == 0 ? Cint : (howLong == 1 ? Clong : Clonglong)
		typ = isUnsigned || !isnothing(pre) ? unsigned(typ) : typ
		pre = isnothing(pre) ? "" : (pre == "0" ? "0o" : pre)
		
		return repr(parse(typ, pre*val))
	end
	
	m = match(r"^(\d*\.)?(\d*)(e[-+]?\d+)?([fl])?$", lowercase(literal))
	if !isnothing(m)
		(val1, val2, exp, suf) = m.captures
		val = val1*val2
		val = val[end] == '.' ? val*"0" : val
		val = val[1] == '.' ? "0"*val : val
		
		suf == "l" && error("Unable to convert `long double` literal:  $(literal)")
		typ = suf == "f" ? Cfloat : Cdouble
		exp = isnothing(exp) ? "" : exp
		
		return repr(parse(typ, val*exp))
	end
	
	error("Failed to convert literal:  $(literal)")
end


function convert_operator(op::String)
	return op == "^" ? "⊻" : op
end


