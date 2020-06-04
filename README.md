# CBindingGen.jl

[![Linux](https://travis-ci.com/analytech-solutions/CBindingGen.jl.svg?branch=master)](https://travis-ci.com/analytech-solutions/CBindingGen.jl) [![Windows](https://ci.appveyor.com/api/projects/status/lsudopndgam8cra7/branch/master?svg=true)](https://ci.appveyor.com/project/krrutkow/cbindinggen-jl/branch/master)

Automatically generate Julia bindings to C API's!
We are developing CBindingGen.jl and CBinding.jl to support the use of arbitrary local C libraries, such as those provided by your Linux distribution, from Julia.


# Usage

CBindingGen.jl seeks to be a comprehensive and automatic C bindings generation framework.
The bindings utilize the CBinding.jl capabilities to precisely interface Julia with C.

This package should only be used at package build time when you wish to generate bindings to a particular C library on the system or one built and installed at build time.
The generated bindings file can then be included from your package code.
Bindings files created by this package should _not_ be committed with your package and they are _not_ meant for editing by lowly humans once generated.
Se let's get started with an example!


## Generating

To start, you must add `CBinding = "^0.9"` as a dependency to your package, and `CBindingGen = "^0.3"` as a build dependency.
CBindingGen.jl relies on the artifacts distributed with `LLVM_jll` for providing a `libclang.so` library and header files for your system, so we will use those to demonstrate.
The following code shows what is necessary to generate bindings to `libclang.so`, and something like it would normally be placed in your package's `deps/build.jl` file.

```julia
using CBindingGen
import LLVM_jll

incdir = joinpath(dirname(dirname(LLVM_jll.libclang_path)), "include")
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

open("bindings.jl", "w+") do io
	generate(io, LLVM_jll.libclang_path => cvts)
end

```

The `convert_headers` function takes an array of header files and the command line arguments, `args`.
Any include directories, compiler options, or preprocessor definitions would be provided in `args` in the same way they would be used in your `clang` command line.
An important detail of `convert_headers` is the filter function provided, here provided with the `do` syntax.
The filter function allows you fine-grained control over what is converted to Julia as the C AST is traversed.
In our example, we filter out any C constructs not defined within the header files we are interested in.

We use `CodeLocation(cursor)` to get the `file`, `line`, and `col` for the start of the C expression, while `CodeRange(cursor)` can be used to get the `start` and `stop` locations of the expression.
Additionally, `string(cursor)` will get the "spelling" of the expression if you wish to filter particular C symbols.

The result of `convert_headers` is an array of `Converted` objects.
`Converted` objects contain the Julia expression strings, as `expr`, and `comments` for storing exportable symbols an their comments ported from C.

Finally, the `generate` function is used to write the converted expressions for one or more libraries into a bindings file.


## Loading

In order to load the bindings file within your package, it is best to define a `baremodule` within your package module to encapsulate the bindings.
The namespace within the `baremodule` will have only a very few symbols that could conflict with those from C.
CBinding provides `𝐣𝐥` (`\bfj<tab>\bfl<tab>`) to provide access to the CBinding types and macros without increasing the chance of nameing conflicts.

```julia
module MyModule
	baremodule LibClang
		using CBinding: 𝐣𝐥
		
		const size_t = 𝐣𝐥.Csize_t
		𝐣𝐥.Base.include((𝐣𝐥.@__MODULE__), "bindings-deps.jl"))
		
		𝐣𝐥.Base.include((𝐣𝐥.@__MODULE__), 𝐣𝐥.joinpath(𝐣𝐥.dirname(𝐣𝐥.@__DIR__), "deps", "libclang.jl"))
	end
	
	# other module code, such as high-level Julian code wrapping the bindings...
end
```

Next is a section defining dependencies of the bindings and should be composed of hand-written code or imported packages that export the required symbols.
Finishing the bindings module is the inclusion of the bindings file generated at build-time.


## Help/Comments

CBindingGen.jl automatically imports comments from the C header files, but it does not yet transform the syntax to Julia's `@doc` strings though.
If you find that C header comments are not imported, you should try adding `-fparse-all-comments` to the list of `args` in your call to `convert_headers`.

```julia
julia> import MyModule

help?> MyModule.LibClang.clang_getClangVersion
  𝐣𝐥.@cextern clang_getClangVersion()::CXString

  Return a version string, suitable for showing to a user, but not intended to be parsed (the format is not guaranteed to be stable).

  Reference
  ===========

  Index.h:5482 (./include/clang-c/Index.h:5482:25)
```


## Using

Use the generated bindings as you would any hand-written or generated `ccall` and `cglobal` wrappers.
Remember, this is _very_ low-level interfacing, and segmentation faults can result from misuse.

```julia
julia> cxstr = MyModule.LibClang.clang_getClangVersion();

julia> unsafe_string(MyModule.LibClang.clang_getCString(cxstr))
"clang version 8.0.1 "

julia> MyModule.LibClang.clang_disposeString(cxstr)

```

