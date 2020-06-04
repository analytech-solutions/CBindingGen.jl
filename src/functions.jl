

function convert_function(cursor::LibClang.CXCursor, indent::Int)
	typ = LibClang.clang_getCursorType(cursor)
	
	((pre, t, post), comments) = convert_type(cursor, LibClang.clang_getResultType(typ), indent)
	
	num = LibClang.clang_Cursor_getNumArguments(cursor)
	args = map(1:num) do i
		arg = LibClang.clang_Cursor_getArgument(cursor, i-1)
		
		argName = convert_name(arg)
		argName = isempty(argName) ? "var\"?$(i)?\"" : argName
		
		((argPre, argT, argPost), argComments) = convert_type(arg, LibClang.clang_getCursorType(arg), indent)
		merge_comments!(comments, argComments)
		
		decl = LibClang.clang_getTypeDeclaration(argT)
		if decl.kind == LibClang.CXCursor_EnumDecl && decl in arg
			convert_decl = convert_enum
		elseif decl.kind == LibClang.CXCursor_StructDecl && decl in arg
			convert_decl = convert_struct
		elseif decl.kind == LibClang.CXCursor_UnionDecl && decl in arg
			convert_decl = convert_union
		else
			convert_decl = (_, _) -> Converted(convert_name(argT), Dict{String, Comment}())
		end
		
		cvt = convert_decl(decl, indent)
		merge_comments!(comments, cvt.comments)
		
		expr = "$(argPre)$(cvt.expr)$(argPost)"
		if startswith(expr, "𝐣𝐥.@") && num > 1
			expr = "($(expr))"
		end
		return "$(argName)::$(expr)"
	end
	Bool(LibClang.clang_Cursor_isVariadic(cursor)) && push!(args, "var\"?vararg?\"...")
	args = join(args, ", ")
	
	conv = convert_convention(typ)
	conv = "__$(lowercase(conv))__"
	
	# TODO: use calling convention
	(pre, post) = ("($(args))::"*pre, post)
	
	return ((pre, t, post), comments)
end


