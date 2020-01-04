

function generate(io::IO, libCvts::Union{Pair{<:AbstractString, Vector{Converted}}, Pair{Nothing, Vector{Converted}}}...)
	println(io, "using CBinding: @macros")
	println(io, "@macros")
	foreach(libCvts) do (lib, cvts)
		println(io)
		println(io, "@cbindings", isnothing(lib) ? " " : " $(repr(String(lib))) ", "begin")
		generate(io, cvts, 1)
		println(io, "end")
	end
end


generate(io::IO, cvts::Vector{Converted}, indent::Int) = foreach(enumerate(cvts)) do (ind, cvt)
	ind > 1 && println(io, repeat('\t', indent))
	generate(io, cvt, indent)
end

function generate(io::IO, cvt::Converted, indent::Int)
	tabs = repeat('\t', indent)
	
	for (name, comment) in cvt.comments
		comment = """
		@doc raw\"\"\"
		$(comment)
		\"\"\" $(name)
		"""
		
		println(io, tabs, rstrip(replace(comment, '\n' => "\n$(tabs)")))
	end
	
	exports = sort(collect(filter(str -> !startswith(str, '_'), keys(cvt.comments))))
	isempty(exports) || println(io, tabs, "export $(join(exports, ", "))")
	
	println(io, tabs, replace(cvt.expr, '\n' => "\n$(tabs)"))
end

