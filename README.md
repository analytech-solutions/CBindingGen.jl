# CBindingGen.jl

Automatically generate Julia bindings to C API's!

# Usage

CBindingGen.jl builds upon some of the processing capabilities of Clang.jl.
Our approach also utilizes the components provided by the CBinding.jl package to more precisely and more completely interface with C API's.

This package is primarily used at package build time when you wish to generate bindings to a C library on the system or one installed at build time.
There are several important details about the process to point out.

First, a filtering function must be defined to provide a means to limit the amount of material interfaced with the bindings.
Remember that C `#include` statements insert files into the AST (and then every file they include gets inserted as well), so it is important to have an effective and accurate filter function.

Second, the proper compile flags must be specified.
If you expect a C user's code to rely on `pkg-config` to get what flags are needed to include and link against your library, then those flags must also be provided to the `ConverterContext`.

The last detail required is to accurately and completely specify the library (or libraries) you want the bindings to link to as well as the list of header files to use to start the wrapping process (NOTICE: bindings are generated according to the filter function, so this list of header files only ensures that they are seen by the parser).
An example of the process for generating bindings is shown below.

```jl
using CBindingGen
using CBindingGen.Clang

const hdrs = [
	"hdr1.h",
	"hdr2.h",
	"hdr3.h",
]

ctx = ConverterContext(["libexample"]) do decl
	header = filename(decl)
	name   = spelling(decl)
	
	# ignore anything not in the library's headers, e.g. "LibExample/hdr1.h"
	any(hdr -> endswith(header, joinpath("LibExample", hdr)), hdrs) || return false
	
	# ignore the particular functions listed below (usually because they are in a header but not exposed with the library)
	decl isa CLFunctionDecl && name in (
		"missing1",
		"missing2",
	) && return false
	
	# ignore functions, variables, and macros starting with double-underscore
	startswith(name, "__") && (decl isa CLFunctionDecl || decl isa CLVarDecl || decl isa CLMacroDefinition) && return false
	
	return true
end

parse_headers!(ctx, hdrs, args = ["-std=gnu99", "-DUSE_DEF=1])
generate(ctx, joinpath(dirname(@__DIR__), "gen"), "example")
```

The call to `generate(...)` in the example above will create several files in the package's "gen" directory which are prefixed with "example".
Suffixes on the files help to indicate when each file can be included into a package.
In a use case where the bindings are generated at build-time and the package is precompiled, the following example represents a template for providing the bindings as a Julia package.

```jl
module ExampleBindings
	# bring in dependencies
	using DepPkg1, DepPkg2
	
	# CBinding is required by the CBindingGen-generated files
	import CBinding
	
	# define opaque types (currently needs to be explicitly done)
	CBinding.@cstruct MyOpaqueType
	
	# use of fully qualified names is a must if the bindings define a symbol from Base!
	Base.include(Base.@__MODULE__, Base.joinpath(Base.dirname(Base.@__DIR__), "gen", "example-atdevelopop.jl"))
	Base.include(Base.@__MODULE__, Base.joinpath(Base.dirname(Base.@__DIR__), "gen", "example-atcompile.jl"))
	Base.include(Base.@__MODULE__, Base.joinpath(Base.dirname(Base.@__DIR__), "gen", "example-atcompile_typedefs.jl"))
	Base.include(Base.@__MODULE__, Base.joinpath(Base.dirname(Base.@__DIR__), "gen", "example-atcompile_bindings.jl"))
	
	function __init__()
		Base.include(Base.@__MODULE__, Base.joinpath(Base.dirname(Base.@__DIR__), "gen", "example-atload.jl"))
	end
end
```

It is also possible, completely at package load-time, to generate bindings and load them dynamically.

```jl
module ExampleBindings
	# bring in dependencies
	using DepPkg1, DepPkg2
	
	# CBinding is required by the CBindingGen-generated files
	import CBinding, CBindingGen
	
	# define opaque types (currently needs to be explicitly done)
	CBinding.@cstruct MyOpaqueType
	
	function __init__()
		hdrs = [
			"hdr1.h",
			"hdr2.h",
			"hdr3.h",
		]
		
		ctx = CBindingGen.ConverterContext(["libexample"]) do decl
			header = CBindingGen.Clang.filename(decl)
			name   = CBindingGen.Clang.spelling(decl)
			
			# ignore anything not in the library's headers, e.g. "LibExample/hdr1.h"
			Base.any(hdr -> Base.endswith(header, Base.joinpath("LibExample", hdr)), hdrs) || return false
			
			# ignore the particular functions listed below (usually because they are in a header but not exposed with the library)
			decl isa CBindingGen.Clang.CLFunctionDecl && name in (
				"missing1",
				"missing2",
			) && return false
			
			# ignore functions, variables, and macros starting with double-underscore
			Base.startswith(name, "__") && (decl isa CBindingGen.Clang.CLFunctionDecl || decl isa CBindingGen.Clang.CLVarDecl || decl isa CBindingGen.Clang.CLMacroDefinition) && return false
			
			return true
		end
		
		CBindingGen.Clang.parse_headers!(ctx, hdrs, args = ["-std=gnu99", "-DUSE_DEF=1])
		@eval $(CBindingGen.generate(ctx))
	end
end
```

Once the bindings are generated, your next step would be to provide some higher-level Julia constructs to wrap the bindings with.
