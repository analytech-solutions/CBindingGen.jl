module CBindingGen
	using Clang
	using Clang: LibClang
	# using Intervals
	
	
	export ConverterContext, generate
	
	
	struct CodeLocation
		file::String
		line::Int
		col::Int
	end
	CodeLocation(decl::CLCursor) = CodeLocation(decl.cursor)
	CodeLocation(decl::Clang.LibClang.CXCursor) = CodeLocation(location(decl))
	function CodeLocation(loc::Clang.LibClang.CXSourceLocation)
		cxfile = Ref{Clang.LibClang.CXFile}(C_NULL)
		line = Ref{Cuint}(0)
		col = Ref{Cuint}(0)
		offset = Ref{Cuint}(0)
		GC.@preserve loc begin
			Clang.LibClang.clang_getSpellingLocation(loc, cxfile, line, col, offset)
			file = "<unknown>"
			if cxfile[] != C_NULL
				cxstr = Clang.LibClang.clang_getFileName(cxfile[])
				try
					ptr = Clang.LibClang.clang_getCString(cxstr)
					if ptr != C_NULL
						file = unsafe_string(ptr)
					end
				finally
					Clang.LibClang.clang_disposeString(cxstr)
				end
			end
		end
		return CodeLocation(file, line[], col[])
	end
	
	Base.isless(a::CodeLocation, b::CodeLocation) = a.file == b.file && (a.line < b.line || (a.line == b.line && a.col < b.col))
	Base.show(io::IO, cl::CodeLocation) = print(io, "$(cl.file):$(cl.line):$(cl.col)")
	
	
	# Intervals.Interval(decl::CLCursor) = Interval(decl.cursor)
	# Intervals.Interval(decl::Clang.LibClang.CXCursor) = Interval(extent(decl))
	# Intervals.Interval(ext::Clang.LibClang.CXSourceRange) = Interval(CodeLocation(Clang.LibClang.clang_getRangeStart(ext)), CodeLocation(Clang.LibClang.clang_getRangeEnd(ext)))
	
	
	struct JuliaizedC
		decl::Union{CLCursor, Nothing}
		expr::String
		kind::Symbol  # :atcompile, :atload
		
		JuliaizedC(decl::CLCursor, expr::String, kind::Symbol) = new(decl, expr, kind)
	end
	
	# struct MacroUse
	# 	c::String
	# 	loc::Interval{CodeLocation}
	# end
	
	
	_gensym(ctx, str) = join(("", string(str), string(hash(str), base = 16, pad = 16)), '_')
	_export(ctx, str) = !isempty(str) && !startswith(str, '_') && push!(ctx.exports, str)
	
	struct ConverterContext <: AbstractContext
		ctx::DefaultContext
		quiet::Bool
		filt::Function
		libs::Union{Vector, Nothing}   # the library name (or library path) to dlopen, an array of library paths or names, or `nothing` for dlopening the running Julia process itself
		includes::Vector{String}
		args::Vector{String}
		exports::Vector{String}
		oneofs::Set{String}
		converted::Vector{JuliaizedC}
		# macroUses::Vector{MacroUse}
		
		function ConverterContext(filter::Function, libs::Union{Vector, Nothing} = [], includes::Vector{String} = String[], args::Vector{String} = String[]; quiet::Bool = false)
			return new(
				DefaultContext(),
				
				quiet,
				
				filter,
				libs,
				includes,
				args,
				
				String[],
				Set{String}(),
				JuliaizedC[],
				# MacroUse[],
			)
		end
	end
	
	
	
	Clang.parse_header!(ctx::ConverterContext, header::String; kwargs...) = Clang.parse_headers!(ctx, [header]; kwargs...)
	function Clang.parse_headers!(ctx::ConverterContext, headers::Vector{String}; args::Vector{String} = String[], includes::Vector{String} = String[], builtin::Bool = false)
		(o, c)  = builtin ? ('<', '>') : ('"', '"')
		
		mktempdir() do dir
			hdr = joinpath(dir, "parse_headers.h")
			open(hdr, "w+") do file
				for header in headers
					print(file,
						"""
						#include $(o)$(header)$(c)
						"""
					)
				end
			end
			
			tu = parse_header(hdr; args = vcat(ctx.args, args), includes = vcat(Clang.CLANG_INCLUDE, ctx.includes, includes), flags = Clang.LibClang.CXTranslationUnit_DetailedPreprocessingRecord)
			num = LibClang.clang_getNumDiagnostics(tu.ptr)
			for i in 1:num
				diag = LibClang.clang_getDiagnostic(tu.ptr, i-1)
				sev = LibClang.clang_getDiagnosticSeverity(diag)
				sev in (LibClang.CXDiagnostic_Error, LibClang.CXDiagnostic_Fatal) && error("Errors encountered parsing headers, unable to proceed with conversion")
			end
			
			_convert(ctx, tu)
		end
		
		return
	end
	
	
	
	function generate(ctx::ConverterContext, where::Union{AbstractString, Nothing} = nothing, prefix::Union{AbstractString, Nothing} = nothing)
		if isnothing(where)
			result = quote end
		else
			prefix = prefix === nothing ? "" : prefix*"-"
			
			try
				mkpath(where)
			catch
			end
		end
		
		for kind in (:atcompile, :atload)
			f = function (io)
				if kind === :atcompile
					for i in 1:10:length(ctx.exports)
						expr = "export $(join(ctx.exports[i:min(length(ctx.exports), i+9)], ", "))"
						if isnothing(where)
							push!(result.args, Meta.parse(expr))
						else
							println(io, expr)
						end
					end
				elseif kind === :atload
					libs = isnothing(ctx.libs) ? ("@CBinding().Clibrary()",) : map(lib -> "@CBinding().Clibrary($(lib isa AbstractString ? repr(lib) : lib))", ctx.libs)
					if isnothing(where)
						libs = map(Meta.parse, libs)
					else
						expr = "@cbindings $(join(libs, ' ')) begin"
						isempty(libs) || println(io, expr)
					end
				end
				
				for c in ctx.converted
					if c.kind === kind
						if isnothing(where)
							push!(result.args, Meta.parse(c.expr))
						else
							if !isnothing(c.decl)
								println(io, (kind === :atload ? '\t' : ""), "# ", CodeLocation(c.decl))
							end
							println(io, (kind === :atload ? '\t' : ""), c.expr)
						end
					end
				end
				
				if kind === :atload
					if isnothing(where)
						expr = "end"
						result = quote
							@cbindings $(libs...) begin
								$(result)
							end
						end
					else
						expr = "end"
						isempty(libs) || println(io, expr)
					end
				end
			end
			
			if isnothing(where)
				f(nothing)
			else
				open(f, joinpath(where, "$(prefix)$(kind).jl"), "w+")
			end
		end
		
		return isnothing(where) ? result : nothing
	end
	
	
	function _convert(ctx::ConverterContext, tu::TranslationUnit)
		root = getcursor(tu)
		for decl in children(root)
			if decl isa CLMacroInstantiation
				# macroUse = MacroUse(spelling(decl), Interval(decl))
				# push!(ctx.macroUses, macroUse)
			else
				# isbuiltin(decl) && continue
				# HACK:  builtin check doesnt seem to work on all builtins, but code locations with unknown file seems to do the trick
				CodeLocation(decl).file == "<unknown>" && continue
				
				x = ctx.filt(decl)
				x === false && continue
				
				if decl isa CLVarDecl || decl isa CLFunctionDecl
					_convert(ctx, decl, x isa Symbol ? x : nothing)
				else
					_convert(ctx, decl)
				end
			end
		end
	end
	
	
	_convert(ctx::ConverterContext, decl) = @warn "Not wrapping $(decl)"
	_convert(ctx::ConverterContext, decl::CLLastPreprocessing) = nothing
	
	
	include("types.jl")
	include("functions.jl")
	include("variables.jl")
	include("macros.jl")
	include("code.jl")
end
