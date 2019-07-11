

function _convert(ctx::ConverterContext, decl::CLFunctionDecl)
	name = _convertName(ctx, decl)
	csym = repr(Symbol(spelling(decl)))
	
	if Clang.calling_conv(type(decl)) == LibClang.CXCallingConv_C
		convention = "CBinding.CDECL"
	else
		error("Support for function calling convention `$(Clang.calling_conv(type(decl)))` is not yet implemented")
	end
	
	ret = _convertType(ctx, result_type(decl))
	args = [CLCursor(LibClang.clang_Cursor_getArgument(decl.cursor, UInt(i-1))) for i in 1:argnum(decl)]
	names = map(arg -> _convertName(ctx, arg), args)
	types = map(arg -> _convertType(ctx, type(arg)), args)
	names = map(enumerate(names)) do (i, aname)
		if isempty(aname)
			aname = _gensym(ctx, string(i))
		end
		return aname
	end
	if isvariadic(decl)
		push!(names, "$(_gensym(ctx, string(length(names)+1)))...")
		push!(types, "Base.Vararg")
	end
	sig  = "CBinding.Cfunction{$(ret), Base.Tuple{$(join(types, ", "))}}"
	
	body = ""
	if isinlined(decl)
		todo"need inlined functions to be saved/stored differently so the closure lasts forever"
		@warn "Unable to convert inline function:  $(name)"
	elseif !(name in ctx.oneofs)
		push!(ctx.oneofs, name)
		
		_export(ctx, name)
		def = "$(name)($(join(names, ", "))) = $(_gensym(ctx, name))[]($(join([names..., "convention = $(convention)"], ", ")))"
		push!(ctx.converted, JuliaizedC(
			decl,
			def,
			:atcompile,
		))
		
		ptr = "const $(_gensym(ctx, name)) = Base.Ref(Base.Ptr{$(sig)}(Base.C_NULL))"
		push!(ctx.converted, JuliaizedC(
			decl,
			ptr,
			:atcompile_bindings,
		))
		
		load = "CBinding.bind($(_gensym(ctx, name)), $(csym), $(_gensym(ctx, "libraries"))...)"
		push!(ctx.converted, JuliaizedC(
			decl,
			load,
			:atload,
		))
	end
end



