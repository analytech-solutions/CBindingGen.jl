

function _convert(ctx::ConverterContext, decl::CLVarDecl, name::Union{Symbol, Nothing})
	kind = isconst(type(decl))
	typ  = _convertType(ctx, type(decl))
	sym  = _convertName(ctx, decl)
	name = isnothing(name) ? sym : name
	csym = repr(Symbol(spelling(decl)))
	
	if !(name in ctx.oneofs)
		push!(ctx.oneofs, name)
		
		_export(ctx, name)
		def = "@cextern "*(sym === name ? "" : "const $(name) = ")*"$(sym)::$(typ)"
		push!(ctx.converted, JuliaizedC(
			decl,
			def,
			:atload,
		))
	end
end

