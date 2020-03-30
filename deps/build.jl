import LLVM_jll


lib = LLVM_jll.libclang_path
vers = let
	v = nothing
	for x in readdir(joinpath(dirname(dirname(lib)), "lib", "clang"))
		if !isnothing(match(r"^\d+\.\d+\.\d+$", x)) && isdir(joinpath(dirname(dirname(lib)), "lib", "clang", x))
			v = x
			break
		end
	end
	v
end
isnothing(vers) && error("Failed to determine the version of libclang")


open(joinpath(@__DIR__, "deps.jl"), "w+") do o
	println(o, "const LIBCLANG_PATH = $(repr(lib))")
	println(o, "const LIBCLANG_VERSION = $(repr(vers))")
end

open(joinpath(@__DIR__, "libclang.jl"), "w+") do o
	open(joinpath(@__DIR__, "libclang-$(vers).jl")) do i
		for l in eachline(i)
			println(o, replace(l, "@cbindings \"{{ LIBCLANG_PATH }}\" begin" => "@cbindings $(repr(lib)) begin"))
		end
	end
end
