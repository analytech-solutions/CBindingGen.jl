using CBindingGen


lib = ARGS[1]  # LLVM_jll.libclang_path
vers = let
	v = nothing
	for x in readdir(joinpath(dirname(lib), "clang"))
		if !isnothing(match(r"^\d+\.\d+\.\d+$", x)) && isdir(joinpath(dirname(lib), "clang", x))
			v = x
			break
		end
	end
	v
end
isnothing(vers) && error("Failed to determine the version of libclang")


incdir = joinpath(dirname(dirname(lib)), "include")
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


open(joinpath(@__DIR__, "libclang-$(vers).jl"), "w+") do io
	generate(io, "{{ LIBCLANG_PATH }}" => cvts)
end
