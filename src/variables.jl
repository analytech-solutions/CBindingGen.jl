

function _convert(ctx::ConverterContext, decl::CLVarDecl)
	kind = isconst(type(decl))
	typ  = _convertType(ctx, type(decl))
	name = _convertName(ctx, decl)
	csym = repr(Symbol(spelling(decl)))
	
	if !(name in ctx.oneofs)
		push!(ctx.oneofs, name)
		
		_export(ctx, name)
		def = "CBinding.@cextern $(name)::$(typ)"
		push!(ctx.converted, JuliaizedC(
			decl,
			def,
			:atload,
		))
	end
end

