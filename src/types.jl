

function convert_typedef(cursor::LibClang.CXCursor, indent::Int)
	name = convert_name(cursor)
	
	((pre, typ, post), comments) = convert_type(cursor, LibClang.clang_getTypedefDeclUnderlyingType(cursor), indent)
	
	cvt = convert_nested_type(typ, cursor, indent)
	merge_comments!(comments, cvt.comments)
	merge_comment!(comments, convert_comment(cursor, name))
	
	expr = "𝐣𝐥.@ctypedef $(name) $(pre)$(cvt.expr)$(post)"
	
	return Converted(
		expr,
		comments,
	)
end



function convert_enum(cursor::LibClang.CXCursor, indent::Int)
	name     = convert_name(cursor)
	comments = Dict{String, Comment}(convert_comment(cursor, name))
	
	if !Bool(LibClang.clang_isCursorDefinition(cursor))
		expr = "𝐣𝐥.@cenum $(name)"
	else
		typ = LibClang.clang_getEnumDeclIntegerType(cursor)
		isunsigned = typ.kind in (
			LibClang.CXType_Char_U,
			LibClang.CXType_UChar,
			LibClang.CXType_UShort,
			LibClang.CXType_UInt,
			LibClang.CXType_ULong,
			LibClang.CXType_ULongLong,
		)
		isunsigned || typ.kind in (
			LibClang.CXType_Char_S,
			LibClang.CXType_SChar,
			LibClang.CXType_Short,
			LibClang.CXType_Int,
			LibClang.CXType_Long,
			LibClang.CXType_LongLong,
		) || error("Failed to convert enum due to an unexpected integer type")
		typ = convert_name(typ)
		
		pack = nothing
		vals = String[]
		for child in children(cursor)
			if child.kind == LibClang.CXCursor_EnumConstantDecl
				valName  = convert_name(child)
				valValue = isunsigned ? LibClang.clang_getEnumConstantDeclUnsignedValue(child) : LibClang.clang_getEnumConstantDeclValue(child)
				merge_comment!(comments, convert_comment(child, valName))
				push!(vals, "$(valName) = $(typ)($(valValue))")
			elseif child.kind == LibClang.CXCursor_PackedAttr && isnothing(pack)
				pack = convert_name(child)
			else
				error("Unexpected enum child encountered")
			end
		end
		
		tabs = repeat('\t', indent)
		vals = join(vals, "\n$(tabs)\t")
		vals = isempty(vals) ? " " : "\n$(tabs)\t$(vals)\n$(tabs)"
		expr = isempty(name) ? "" : "$(name) "
		expr = "𝐣𝐥.@cenum $(expr){$(vals)}"
		expr = isnothing(pack) ? expr : "$(expr) __$(pack)__"
	end
	
	return Converted(
		expr,
		comments,
	)
end


convert_struct(cursor::LibClang.CXCursor, indent::Int) = convert_aggregate(cursor, :struct, indent)
convert_union(cursor::LibClang.CXCursor, indent::Int) = convert_aggregate(cursor, :union, indent)

function convert_aggregate(cursor::LibClang.CXCursor, kind::Symbol, indent::Int)
	kind in (:struct, :union) || error("Unknown aggregate type $(kind)")
	name     = convert_name(cursor)
	comments = Dict{String, Comment}(convert_comment(cursor, name))
	
	if !Bool(LibClang.clang_isCursorDefinition(cursor))
		expr = "𝐣𝐥.@c$(kind) $(name)"
	else
		pack = nothing
		exprs = String[]
		for coal in coalesce(children(cursor))
			if length(coal) == 1 && coal[1].kind == LibClang.CXCursor_PackedAttr
				isnothing(pack) || error("Multiple packing attributes encountered")
				pack = convert_name(coal[1])
			else
				cvt = convert_fields(coal, indent+1)
				if !isnothing(cvt)
					push!(exprs, cvt.expr)
					merge_comments!(comments, cvt.comments)
				end
			end
		end
		
		tabs = repeat('\t', indent)
		exprs = join(exprs, "\n$(tabs)\t")
		exprs = isempty(exprs) ? " " : "\n$(tabs)\t$(exprs)\n$(tabs)"
		expr = isempty(name) ? "" : "$(name) "
		expr = "𝐣𝐥.@c$(kind) $(expr){$(exprs)}"
		expr = isnothing(pack) ? expr : "$(expr) __$(pack)__"
	end
	
	return Converted(
		expr,
		comments,
	)
end



function convert_nested_type(typ::LibClang.CXType, cursor::LibClang.CXCursor, indent::Int)
	decl = LibClang.clang_getTypeDeclaration(typ)
	if decl.kind == LibClang.CXCursor_EnumDecl && decl in cursor && !(cursor in decl)
		convert_decl = convert_enum
	elseif decl.kind == LibClang.CXCursor_StructDecl && decl in cursor && !(cursor in decl)
		convert_decl = convert_struct
	elseif decl.kind == LibClang.CXCursor_UnionDecl && decl in cursor && !(cursor in decl)
		convert_decl = convert_union
	else
		return Converted(convert_name(typ), Dict{String, Comment}())
	end
	return convert_decl(decl, indent)
end



function convert_type(cursor::LibClang.CXCursor, typ::LibClang.CXType, indent::Int)
	(pre, post) = ("", "")
	comments = Dict{String, Comment}()
	
	if typ.kind in (
		LibClang.CXType_Bool,
		LibClang.CXType_Void,
		LibClang.CXType_Char_S,
		LibClang.CXType_Char_U,
		LibClang.CXType_SChar,
		LibClang.CXType_UChar,
		LibClang.CXType_Short,
		LibClang.CXType_Int,
		LibClang.CXType_Long,
		LibClang.CXType_LongLong,
		LibClang.CXType_UShort,
		LibClang.CXType_UInt,
		LibClang.CXType_ULong,
		LibClang.CXType_ULongLong,
		LibClang.CXType_Float,
		LibClang.CXType_Double,
		LibClang.CXType_LongDouble,
		LibClang.CXType_Typedef,
		LibClang.CXType_Elaborated,
		LibClang.CXType_Enum,
		LibClang.CXType_Record,
	)
		t = typ
	elseif typ.kind in (
		LibClang.CXType_ConstantArray,
		LibClang.CXType_IncompleteArray,
	)
		num = typ.kind == LibClang.CXType_ConstantArray ? LibClang.clang_getNumElements(typ) : ""
		((pre, t, post), comments) = convert_type(cursor, LibClang.clang_getElementType(typ), indent)
		if endswith(post, ']')
			(pre, post) = ("("*pre, post*")")
		end
		(pre, post) = (pre, post*"[$(num)]")
	elseif typ.kind == LibClang.CXType_Complex
		((pre, t, post), comments) = convert_type(cursor, LibClang.clang_getElementType(typ), indent)
		(pre, post) = ("𝐣𝐥.Complex{"*pre, post*"}")
	elseif typ.kind == LibClang.CXType_Pointer
		((pre, t, post), comments) = convert_type(cursor, LibClang.clang_getPointeeType(typ), indent)
		(pre, post) = ("𝐣𝐥.Ptr{"*pre, post*"}")
	elseif typ.kind in (LibClang.CXType_Unexposed, LibClang.CXType_FunctionProto)
		((pre, t, post), comments) = convert_type(cursor, LibClang.clang_getResultType(typ), indent)
		
		num = LibClang.clang_getNumArgTypes(typ)
		args = map(1:num) do i
			argType = LibClang.clang_getArgType(typ, i-1)
			
			((argPre, argT, argPost), argComments) = convert_type(cursor, argType, indent)
			merge_comments!(comments, argComments)
			
			decl = LibClang.clang_getTypeDeclaration(argT)
			if decl.kind == LibClang.CXCursor_EnumDecl && decl in cursor
				convert_decl = convert_enum
			elseif decl.kind == LibClang.CXCursor_StructDecl && decl in cursor
				convert_decl = convert_struct
			elseif decl.kind == LibClang.CXCursor_UnionDecl && decl in cursor
				convert_decl = convert_union
			else
				convert_decl = (_, _) -> Converted(convert_name(argT), Dict{String, Comment}())
			end
			
			cvt = convert_decl(decl, indent)
			merge_comments!(comments, cvt.comments)
			
			return "$(argPre)$(cvt.expr)$(argPost)"
		end
		Bool(LibClang.clang_isFunctionTypeVariadic(typ)) && push!(args, "𝐣𝐥.Vararg")
		args = join(args, ", ")
		
		conv = convert_convention(typ)
		
		(pre, post) = ("𝐣𝐥.Cfunction{"*pre, post*", 𝐣𝐥.Tuple{$(args)}, 𝐣𝐥.$(conv)}")
	else
		error("Unable to convert type $(typ.kind), not yet implemented")
	end
	
	if Bool(LibClang.clang_isConstQualifiedType(typ))
		(pre, post) = ("𝐣𝐥.Cconst("*pre, post*")")
	end
	
	if Bool(LibClang.clang_isRestrictQualifiedType(typ))
		(pre, post) = ("𝐣𝐥.Crestrict("*pre, post*")")
	end
	
	if Bool(LibClang.clang_isVolatileQualifiedType(typ))
		(pre, post) = ("𝐣𝐥.Cvolatile("*pre, post*")")
	end
	
	return ((pre, t, post), comments)
end


function convert_convention(typ::LibClang.CXType)
	conv = LibClang.clang_getFunctionTypeCallingConv(typ)
	if conv == LibClang.CXCallingConv_C
		return "CDECL"
	end
	
	error("Support for function calling convention `$(conv)` is not yet implemented")
end

