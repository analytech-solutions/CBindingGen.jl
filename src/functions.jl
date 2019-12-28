

function _convert(ctx::ConverterContext, decl::CLFunctionDecl, name::Union{Symbol, Nothing})
	sym  = _convertName(ctx, decl)
	name = isnothing(name) ? sym : name
	csym = repr(Symbol(spelling(decl)))
	
	if Clang.calling_conv(type(decl)) == LibClang.CXCallingConv_C
		convention = "@CBinding().CDECL"
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
		push!(types, "")
	end
	
	body = ""
	if isinlined(decl)
		# NOTE: need inlined functions to be saved/stored differently so the closure lasts forever
		@warn "Unable to convert inline function:  $(name)"
	elseif !(name in ctx.oneofs)
		push!(ctx.oneofs, name)
		
		_export(ctx, name)
		def = "@cextern "*(sym === name ? "" : "const $(name) = ")*"$(sym)($(join(map((n, t) -> (isempty(t) ? n : join((n, t), "::")), names, types), ", ")))::$(ret)"
		push!(ctx.converted, JuliaizedC(
			decl,
			def,
			:atload,
		))
	end
end



