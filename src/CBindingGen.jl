module CBindingGen
	import Clang_jll
	
	
	const LIBCLANG_PATH = Clang_jll.libclang_path
	const LIBCLANG_VERSION = let
		dir = joinpath(dirname(dirname(LIBCLANG_PATH)), "lib", "clang")
		entries = readdir(dir)
		ind = findfirst(x -> !isnothing(match(r"^\d+\.\d+\.\d+$", x)) && isdir(joinpath(dir, x)), entries)
		isnothing(ind) && error("Failed to determine the version of libclang")
		entries[ind]
	end
	
	
	baremodule LibClang
		using CBinding: 𝐣𝐥
		using ..CBindingGen: LIBCLANG_PATH, LIBCLANG_VERSION
		
		const size_t = 𝐣𝐥.Csize_t
		
		𝐣𝐥.Base.include((𝐣𝐥.@__MODULE__), 𝐣𝐥.joinpath(𝐣𝐥.dirname(𝐣𝐥.@__DIR__), "deps", "libclang-$(LIBCLANG_VERSION).jl"))
	end
	
	
	using CBinding
	import Markdown
	
	
	export LibClang
	export Converted, CodeLocation, CodeRange
	export convert_header, convert_headers, generate
	
	
	function _string(func::Function, args...)
		cxstr = nothing
		try
			cxstr = func(args...)
			ptr = LibClang.clang_getCString(cxstr)
			return ptr == C_NULL ? nothing : unsafe_string(ptr)
		finally
			isnothing(cxstr) || LibClang.clang_disposeString(cxstr)
		end
	end
	
	Base.string(cursor::LibClang.CXCursor) = _string(LibClang.clang_getCursorSpelling, cursor)
	Base.string(tu::LibClang.CXTranslationUnit, token::LibClang.CXToken) = _string(LibClang.clang_getTokenSpelling, tu, token)
	
	function children(cursor::LibClang.CXCursor)
		Cvisitor = @ccallback function visitor(c::LibClang.CXCursor, p::LibClang.CXCursor, cs::LibClang.CXClientData)::LibClang.CXChildVisitResult
			push!(unsafe_pointer_to_objref(cs)::Vector{LibClang.CXCursor}, c)
			return LibClang.CXChildVisit_Continue
		end
		
		cursors = LibClang.CXCursor[]
		Bool(LibClang.clang_visitChildren(cursor, Cvisitor, pointer_from_objref(cursors))) && error("Failed to visit cursor children")
		return cursors
	end
	
	
	struct CodeLocation
		file::String
		line::Int
		col::Int
		
		function CodeLocation(loc::LibClang.CXSourceLocation)
			cxfile = Ref{LibClang.CXFile}(C_NULL)
			line = Ref{Cuint}(0)
			col = Ref{Cuint}(0)
			offset = Ref{Cuint}(0)
			LibClang.clang_getSpellingLocation(loc, cxfile, line, col, offset)
			
			str = cxfile[] == C_NULL ? nothing : _string(LibClang.clang_getFileName, cxfile[])
			file = isnothing(str) ? "<unknown>" : str
			
			return new(file, line[], col[])
		end
	end
	CodeLocation(cursor::LibClang.CXCursor) = CodeLocation(LibClang.clang_getCursorLocation(cursor))
	
	Base.isless(a::CodeLocation, b::CodeLocation) = a.file == b.file && (a.line < b.line || (a.line == b.line && a.col < b.col))
	
	function Base.string(cl::CodeLocation; relto::String = ".")
		file = !startswith(relpath(cl.file, relto), "../") ? "./$(relpath(cl.file, relto))" : !startswith(relpath(cl.file, homedir()), "../") ? "~/$(relpath(cl.file, homedir()))" : cl.file
		return "$(file):$(cl.line):$(cl.col)"
	end
	
	
	struct CodeRange <: AbstractRange{CodeLocation}
		start::CodeLocation
		stop::CodeLocation
		
		function CodeRange(range::LibClang.CXSourceRange)
			start = CodeLocation(LibClang.clang_getRangeStart(range))
			stop  = CodeLocation(LibClang.clang_getRangeEnd(range))
			return new(start, stop)
		end
	end
	function CodeRange(cursor::LibClang.CXCursor)
		cursor.kind == LibClang.CXCursor_NoDeclFound && error("Cannot create a CodeRange for a $(cursor.kind) cursor")
		return CodeRange(LibClang.clang_getCursorExtent(cursor))
	end
	
	
	function Base.coalesce(cursors::Vector{LibClang.CXCursor})
		# TODO: switch to OrderedDict and use in last part of this function so its not O(N^2)
		coalesced = Vector{Pair{CodeRange, LibClang.CXCursor}}[]
		startInds = Dict{CodeLocation, Int}()
		for cursor in cursors
			range = CodeRange(cursor)
			
			if !haskey(startInds, range.start)
				push!(coalesced, [range => cursor])
				startInds[range.start] = length(coalesced)
			else
				# NOTE: insertion sorting the coalesced group so we know where the largest range in the group is
				coal = coalesced[startInds[range.start]]
				ind = findfirst(c -> range in c.first, coal)
				ind = isnothing(ind) ? length(coal) : ind
				insert!(coal, ind+1, range => cursor)
			end
		end
		
		# once the cursors are coalesced, we need to remove groups that are nested within other groups
		coalesced = filter(inners -> !any(outers -> last(inners) !== last(outers) && last(inners).first in last(outers).first, coalesced), coalesced)
		return map(cs -> map(c -> c.second, cs), coalesced)
	end
	
	Base.in(inner::LibClang.CXCursor, outer::LibClang.CXCursor) = in(CodeRange(inner), CodeRange(outer))
	function Base.in(inner::CodeRange, outer::CodeRange)
		inner.start.file == outer.start.file || return false
		inner.stop.file == outer.stop.file || return false
		
		!(inner.start < outer.start) && !(outer.stop < inner.stop)
	end
	
	
	struct Comment
		md::Union{Markdown.MD, Nothing}
		locs::Vector{CodeLocation}
	end
	
	
	function Base.string(comment::Comment; expr::String = "", relto::String = ".")
		contents = []
		isempty(expr) || push!(contents, Markdown.Code(expr))
		isnothing(comment.md) || append!(contents, comment.md.content)
		push!(contents, Markdown.Header(length(comment.locs) > 1 ? "References" : "Reference", 2))
		for loc in comment.locs
			push!(contents, Markdown.Paragraph(Markdown.Link("$(basename(loc.file)):$(loc.line)", string(loc, relto = relto))))
		end
		return string(Markdown.MD(contents))
	end
	
	
	struct Converted
		expr::String
		comments::Dict{String, Comment}
	end
	
	
	# NOTE: func returns:  false = don't convert, true = convert as `string(cursor)`, "jlname" = convert as "jlname"
	convert_header(func::Function, header::String; kwargs...) = convert_headers(func, [header]; kwargs...)
	function convert_headers(func::Function, headers::Vector{String}; args::Vector{String} = String[])
		args = vcat(args, [
			"-isystem", joinpath(dirname(dirname(LIBCLANG_PATH)), "lib", "clang", LIBCLANG_VERSION, "include"),
		])
		
		return mktempdir() do dir
			hdr = joinpath(dir, "parse_headers.h")
			open(hdr, "w+") do file
				for header in headers
					println(file, "#include <$(header)>")
				end
			end
			
			ind = nothing
			try
				ind = LibClang.clang_createIndex(0, 1)
				ind == C_NULL && error("Failed to create index")
				
				tu = Ref(LibClang.CXTranslationUnit(C_NULL))
				try
					argsPtrs = map(i -> pointer(args[i]), eachindex(args))
					err = LibClang.clang_parseTranslationUnit2(ind, hdr, argsPtrs, length(args), C_NULL, 0, LibClang.CXTranslationUnit_DetailedPreprocessingRecord, tu)
					err == LibClang.CXError_Success || error("Failed to parse translation unit $(err)")
					
					for i in 1:LibClang.clang_getNumDiagnostics(tu[])
						diag = nothing
						try
							diag = LibClang.clang_getDiagnostic(tu[], i-1)
							sev = LibClang.clang_getDiagnosticSeverity(diag)
							sev in (LibClang.CXDiagnostic_Error, LibClang.CXDiagnostic_Fatal) && error("Errors encountered parsing headers, unable to proceed with conversion")
						finally
							LibClang.clang_disposeDiagnostic(diag)
						end
					end
					
					return convert_parsed(func, tu[])
				finally
					tu[] == C_NULL || LibClang.clang_disposeTranslationUnit(tu[])
				end
			finally
				isnothing(ind) || LibClang.clang_disposeIndex(ind)
			end
		end
	end
	
	
	function convert_parsed(func::Function, tu::LibClang.CXTranslationUnit)
		root = LibClang.clang_getTranslationUnitCursor(tu)
		
		# remove compiler-internal cursors and pre-processor cursors
		cursors = filter(c -> CodeLocation(c).file != "<unknown>" && !(c.kind in (
			LibClang.CXCursor_InclusionDirective,
			LibClang.CXCursor_MacroDefinition,
			LibClang.CXCursor_MacroInstantiation,
		)), children(root))
		
		cvts = Converted[]
		for coal in coalesce(cursors)
			try
				coal[1].kind in (
					LibClang.CXCursor_TypedefDecl,
					LibClang.CXCursor_EnumDecl,
					LibClang.CXCursor_StructDecl,
					LibClang.CXCursor_UnionDecl,
				) && func(coal[1]) === false && continue
				
				cvt = convert_fields(coal, 0, func)
				isnothing(cvt) || push!(cvts, cvt)
			catch
				@warn "The following exception occurred when converting near $(string(CodeLocation(coal[1])))"
				rethrow()
			end
		end
		
		exports = mapreduce(cvt -> collect(keys(cvt.comments)), vcat, cvts, init = String[])
		cursors = filter(c -> CodeLocation(c).file != "<unknown>" && c.kind == LibClang.CXCursor_MacroDefinition, children(root))
		
		macros = Converted[]
		names = Dict{String, Int}()
		for cursor in cursors
			try
				func(cursor) || continue
				
				cvt = convert_macro(tu, cursor, exports)
				if !isnothing(cvt)
					(name, m) = cvt
					if haskey(names, name)
						macros[names[name]] = m
					else
						push!(macros, m)
						names[name] = length(macros)
					end
				end
			catch
				@warn "The following exception occurred when converting macro near $(string(CodeLocation(cursor)))"
				rethrow()
			end
		end
		append!(cvts, macros)
		
		return cvts
	end
	
	
	include("names.jl")
	include("macros.jl")
	include("types.jl")
	include("fields.jl")
	include("functions.jl")
	include("comments.jl")
	include("generate.jl")
end
