

function _convert(ctx::ConverterContext, decl::CLVarDecl)
	kind = isconst(type(decl)) ? "CBinding.Cglobalconst" : "CBinding.Cglobal"
	typ  = _convertType(ctx, type(decl))
	name = _convertName(ctx, decl)
	csym = repr(Symbol(spelling(decl)))
	
	if !(name in ctx.oneofs)
		push!(ctx.oneofs, name)
		
		_export(ctx, name)
		def = "const $(name) = $(kind){$(typ)}()"
		push!(ctx.converted, JuliaizedC(
			decl,
			def,
			:atcompile_bindings,
		))
		
		load = "CBinding.bind($(name), $(csym), $(_gensym(ctx, "libraries"))...)"
		push!(ctx.converted, JuliaizedC(
			decl,
			load,
			:atload,
		))
	end
end

