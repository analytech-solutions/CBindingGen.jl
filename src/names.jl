
convert_name(x::Union{LibClang.CXCursor, LibClang.CXType}) = convert_name(string(x))

function convert_name(str::String)
	# TODO: some of these are actually safe to use
	issafe = !(str in (
		"begin", "let", "quote", "do", "end",
		"macro", "function", "return",
		"while", "for", "continue", "break",
		"if", "elseif", "else",
		"try", "catch", "finally",
		"local", "global", "const",
		"struct", "mutable", "abstract", "primitive", "type",
		"module", "baremodule",
		"using", "import", "export",
		"true", "false",
	))
	return issafe ? str : "var\"$(str)\""
end


function convert_name(typ::LibClang.CXType; nolongs::Bool = false)
	if typ.kind == LibClang.CXType_Bool
		return "𝐣𝐥.Cbool"
	elseif typ.kind == LibClang.CXType_Void
		return "𝐣𝐥.Cvoid"
	elseif typ.kind == LibClang.CXType_Char_S
		return "𝐣𝐥.Cchar"
	elseif typ.kind == LibClang.CXType_Char_U
		return "𝐣𝐥.Cuchar"
	elseif typ.kind == LibClang.CXType_SChar
		return "𝐣𝐥.Cchar"
	elseif typ.kind == LibClang.CXType_UChar
		return "𝐣𝐥.Cuchar"
	elseif typ.kind == LibClang.CXType_Short
		return "𝐣𝐥.Cshort"
	elseif typ.kind == LibClang.CXType_Int
		return "𝐣𝐥.Cint"
	elseif typ.kind == LibClang.CXType_Long
		return nolongs ? (sizeof(Clong) == sizeof(Cint) ? "𝐣𝐥.Cint" : "𝐣𝐥.Clonglong") : "𝐣𝐥.Clong"
	elseif typ.kind == LibClang.CXType_LongLong
		return "𝐣𝐥.Clonglong"
	elseif typ.kind == LibClang.CXType_UShort
		return "𝐣𝐥.Cushort"
	elseif typ.kind == LibClang.CXType_UInt
		return "𝐣𝐥.Cuint"
	elseif typ.kind == LibClang.CXType_ULong
		return nolongs ? (sizeof(Culong) == sizeof(Cuint) ? "𝐣𝐥.Cuint" : "𝐣𝐥.Culonglong") : "𝐣𝐥.Culong"
	elseif typ.kind == LibClang.CXType_ULongLong
		return "𝐣𝐥.Culonglong"
	elseif typ.kind == LibClang.CXType_Float
		return "𝐣𝐥.Cfloat"
	elseif typ.kind == LibClang.CXType_Double
		return "𝐣𝐥.Cdouble"
	elseif typ.kind == LibClang.CXType_LongDouble
		return "𝐣𝐥.Clongdouble"
	elseif typ.kind in (
		LibClang.CXType_Elaborated,
		LibClang.CXType_Enum,
	)
		decl = LibClang.clang_getTypeDeclaration(typ)
		if decl.kind == LibClang.CXCursor_EnumDecl
			kind = "𝐣𝐥.@cenum"
		elseif decl.kind == LibClang.CXCursor_StructDecl
			kind = "𝐣𝐥.@cstruct"
		elseif decl.kind == LibClang.CXCursor_UnionDecl
			kind = "𝐣𝐥.@cunion"
		else
			error("Unable to handle kind of type $(decl.kind)")
		end
		return "$(kind) $(convert_name(decl))"
	elseif typ.kind in (
		LibClang.CXType_Typedef,
		LibClang.CXType_Enum,
		LibClang.CXType_Record,
	)
		return convert_name(LibClang.clang_getTypeDeclaration(typ))
	end
	
	error("Unable to convert type name $(typ.kind), not yet implemented")
end

