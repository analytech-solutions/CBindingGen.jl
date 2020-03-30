
function convert_name(x::Union{LibClang.CXCursor, LibClang.CXType})
	str = string(x)
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


function convert_name(typ::LibClang.CXType)
	if typ.kind == LibClang.CXType_Bool
		return "@Cbool"
	elseif typ.kind == LibClang.CXType_Void
		return "@Cvoid"
	elseif typ.kind == LibClang.CXType_Char_S
		return "@Cchar"
	elseif typ.kind == LibClang.CXType_Char_U
		return "@Cuchar"
	elseif typ.kind == LibClang.CXType_SChar
		return "@Cchar"
	elseif typ.kind == LibClang.CXType_UChar
		return "@Cuchar"
	elseif typ.kind == LibClang.CXType_Short
		return "@Cshort"
	elseif typ.kind == LibClang.CXType_Int
		return "@Cint"
	elseif typ.kind == LibClang.CXType_Long
		return "@Clong"
	elseif typ.kind == LibClang.CXType_LongLong
		return "@Clonglong"
	elseif typ.kind == LibClang.CXType_UShort
		return "@Cushort"
	elseif typ.kind == LibClang.CXType_UInt
		return "@Cuint"
	elseif typ.kind == LibClang.CXType_ULong
		return "@Culong"
	elseif typ.kind == LibClang.CXType_ULongLong
		return "@Culonglong"
	elseif typ.kind == LibClang.CXType_Float
		return "@Cfloat"
	elseif typ.kind == LibClang.CXType_Double
		return "@Cdouble"
	elseif typ.kind == LibClang.CXType_LongDouble
		return "@Clongdouble"
	elseif typ.kind in (
		LibClang.CXType_Typedef,
		LibClang.CXType_Elaborated,
		LibClang.CXType_Enum,
		LibClang.CXType_Record,
	)
		return convert_name(LibClang.clang_getTypeDeclaration(typ))
	end
	
	error("Unable to convert type name $(typ.kind), not yet implemented")
end

