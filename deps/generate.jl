using CBindingGen


const LIBCLANG_PATH = ARGS[1]  # LLVM_jll.libclang_path
const LIBCLANG_VERSION = let
	dir = joinpath(dirname(dirname(LIBCLANG_PATH)), "lib", "clang")
	entries = readdir(dir)
	ind = findfirst(x -> !isnothing(match(r"^\d+\.\d+\.\d+$", x)) && isdir(joinpath(dir, x)), entries)
	isnothing(ind) && error("Failed to determine the version of libclang")
	entries[ind]
end


incdir = joinpath(dirname(dirname(LIBCLANG_PATH)), "include")
hdrs = map(hdr -> joinpath("clang-c", hdr), readdir(joinpath(incdir, "clang-c")))

cvts = convert_headers(hdrs, args = ["-I", incdir]) do cursor
	header = CodeLocation(cursor).file
	name   = string(cursor)
	
	# only wrap the libclang headers
	startswith(header, "$(incdir)/") || return false
	
	# ignore function that uses time_t since we don't know what time_t is yet
	name == "clang_getFileTime" && return false
	
	return true
end


open(joinpath(@__DIR__, "libclang-$(LIBCLANG_VERSION).jl"), "w+") do io
	generate(io, :LIBCLANG_PATH => cvts, relto = dirname(dirname(LIBCLANG_PATH)))
end
