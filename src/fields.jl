
function convert_fields(coalesced::Vector{<:LibClang.CXCursor}, indent::Int, func::Union{Function, Nothing} = nothing)
	comments = Dict{String, Comment}()
	common = nothing
	expr = nothing
	flds = map(coalesced) do fld
		fldName = jlname = convert_name(fld)
		if isnothing(func)
			fld.kind in (
				LibClang.CXCursor_FieldDecl,
			) || return nothing
		else
			fld.kind in (
				LibClang.CXCursor_VarDecl,
				LibClang.CXCursor_FunctionDecl,
			) || return nothing
			
			LibClang.clang_Cursor_getStorageClass(fld) in (
				LibClang.CX_SC_None,
				LibClang.CX_SC_Extern,
			) || return nothing
			
			jlname = func(fld)
			jlname === false && return nothing
			jlname = jlname isa AbstractString ? jlname : fldName
		end
		
		((pre, typ, post), fldComments) = fld.kind == LibClang.CXCursor_FunctionDecl ? convert_function(fld, indent) : convert_type(fld, LibClang.clang_getCursorType(fld), indent)
		
		isnothing(common) || Bool(LibClang.clang_equalTypes(common, typ)) || error("Unexpected nested type")
		if isnothing(common)
			common = typ
			cvt = convert_nested_type(typ, fld, indent)
			expr = cvt.expr
			merge_comments!(comments, cvt.comments)
		end
		merge_comments!(comments, fldComments)
		
		if !isnothing(func)
			merge_comment!(comments, convert_comment(fld, jlname))
			jlname = jlname == fldName ? jlname : "($(fldName) => $(jlname))"
		elseif Bool(LibClang.clang_Cursor_isBitField(fld))
			jlname = "$(jlname):$(LibClang.clang_getFieldDeclBitWidth(fld))"
		end
		
		return (fld, jlname, pre, post)
	end
	flds = filter(!isnothing, flds)
	
	if isnothing(expr)
		if coalesced[1].kind == LibClang.CXCursor_TypedefDecl
			convert_decl = convert_typedef
		elseif coalesced[1].kind == LibClang.CXCursor_EnumDecl
			convert_decl = convert_enum
		elseif coalesced[1].kind == LibClang.CXCursor_StructDecl
			convert_decl = convert_struct
		elseif coalesced[1].kind == LibClang.CXCursor_UnionDecl
			convert_decl = convert_union
		else
			return nothing
		end
		
		return convert_decl(coalesced[1], indent)
	end
	
	if length(flds) == 1
		(fld, jlname, pre, post) = flds[1]
		if startswith(expr, "𝐣𝐥.@") && (
			startswith(post, '[') ||                       # @cstruct {...}[N]
			(endswith(pre, '{') && startswith(post, ','))  # Cfunction{@cstruct {...}, ...}
		)
			expr = "($(expr))"
		end
		if occursin(':', jlname)
			jlname = "($(jlname))"
		end
		colons = fld.kind == LibClang.CXCursor_FunctionDecl ? "" : "::"
		expr = "$(jlname)$(colons)$(pre)$(expr)$(post)"
	else
		flds = map(flds) do (fld, jlname, pre, post)
			if !isempty(pre*post) && (
				startswith(post, '[') ||                          # _[N]
				(endswith(pre, "::") && isempty(post)) ||         # f()::_
				(endswith(pre, '(') && startswith(post, ')')) ||  # Cconst(_)
				(endswith(pre, '{') && startswith(post, '}')) ||  # Ptr{_}
				(endswith(pre, '{') && startswith(post, ','))     # Cfunction{_, ...}
			)
				pre = pre*"_"
			end
			colons = fld.kind == LibClang.CXCursor_FunctionDecl ? "" : "::"
			return isempty(pre*post) ? jlname : "$(jlname)$(colons)$(pre)$(post)"
		end
		expr = "($(join(flds, ", ")))::$(expr)"
	end
	
	if !isnothing(func)
		expr = "𝐣𝐥.@cextern $(expr)"
	end
	
	return Converted(
		expr,
		comments,
	)
end

