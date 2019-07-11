using Test: @testset, @test, @test_throws, @test_broken
using CBindingGen
using CBindingGen.Clang
using CBinding


@testset "CBindingGen" begin
	@testset "parsing C" begin
		ctx = ConverterContext(decl -> false, nothing)
		parse_headers!(ctx, ["test.h"], args = ["-I."])
		@test isempty(ctx.converted)
		
		ctx = ConverterContext(decl -> true, nothing)
		parse_headers!(ctx, ["test.h"], args = ["-I."])
		@test !isempty(ctx.converted)
	end
	
	
	ctx = ConverterContext(decl -> true, nothing)
	parse_headers!(ctx, ["test.h"], args = ["-I."])
	generate(ctx, pwd(), ".")
	
	mod = @eval module $(gensym())
		import ..CBinding
		
		CBinding.@cstruct _S24
		CBinding.@cstruct _S31
		
		include(joinpath(pwd(), ".-atdevelop.jl"))
		include(joinpath(pwd(), ".-atcompile.jl"))
		include(joinpath(pwd(), ".-atcompile_typedefs.jl"))
		include(joinpath(pwd(), ".-atcompile_bindings.jl"))
	end
	
	
	@testset "exports" begin
		@test mod isa Module
		
		expected = (
			(Symbol("T", i) for i in 1:26)...,       # typedefs
			(Symbol("S", i) for i in 1:32)...,       # structs
			(Symbol("E", i) for i in 1:5)...,        # enums
			(Symbol("E", i, "_1") for i in 1:5)...,  # enum values
			(Symbol("g", i) for i in 1:7)...,        # globals
			(Symbol("f", i) for i in 1:10)...,       # functions
			:E1_2, :E1_3, :E2_2, :E2_3, :E2_4, :E2_5, :E2_6, :E4_,
			:S27_, :S29_, :S29_ptr,
			:F1,
		)
		present = names(mod)
		for p in present
			@test p in expected
		end
		for e in expected
			@test e in present
		end
	end
	
	
	@testset "typedefs" begin
		@test mod.T1 === Cvoid
		@test mod.T2 === mod.T1
		@test mod.T3 === Cchar
		@test mod.T4 === Cshort
		@test mod.T5 === Cint
		@test mod.T6 === Clong
		@test mod.T7 === Clonglong
		@test mod.T8 === Cchar
		@test mod.T9 === Cshort
		@test mod.T10 === Cint
		@test mod.T11 === Clong
		@test mod.T12 === Clonglong
		@test mod.T13 === Cuchar
		@test mod.T14 === Cushort
		@test mod.T15 === Cuint
		@test mod.T16 === Culong
		@test mod.T17 === Culonglong
		@test mod.T18 === Cfloat
		@test mod.T19 === Cdouble
		@test mod.T20 === Clongdouble
		@test mod.T21 === Complex{Cfloat}
		@test mod.T22 === Complex{Cdouble}
		@test mod.T23 === Complex{Clongdouble}
		@test mod.T24 === @carray Cint[2]
		@test mod.T25 === @carray (@carray Cint[2])[5]
	end
	
	
	@testset "structs" begin
		@test mod.S1 <: Cstruct
		@test () == propertynames(mod.S1)
		
		@test mod.S2 <: Cstruct
		@test (:i,) == propertynames(mod.S2)
		@test (Cint,) == propertytypes(mod.S2)
		
		@test mod.S3 <: Cstruct
		@test (:s,) == propertynames(mod.S3)
		@test (mod.S1,) == propertytypes(mod.S3)
		
		@test mod.S4 <: Cstruct
		@test (:i, :s) == propertynames(mod.S4)
		@test (Cint, mod.S3) == propertytypes(mod.S4)
		
		@test mod.S5 <: Cstruct
		@test (:s,) == propertynames(mod.S5)
		
		@test mod.S6 <: Cstruct
		@test (:s, :s1, :i, :s2) == propertynames(mod.S6)
		
		@test mod.S7 <: Cstruct
		@test (:i, :s) == propertynames(mod.S7)
		
		@test mod.S8 <: Cstruct
		@test (:s,) == propertynames(mod.S8)
		
		@test mod.S9 <: Cstruct
		@test (:s1, :s2) == propertynames(mod.S9)
		
		@test mod.S10 <: Cstruct
		@test () == propertynames(mod.S10)
		
		@test mod.S11 <: Cstruct
		@test (:i,) == propertynames(mod.S11)
		@test (Cint,) == propertytypes(mod.S2)
		
		@test mod.S12 <: Cstruct
		@test (:s1, :s2, :s3, :s4) == propertynames(mod.S12)
		typ = propertytypes(mod.S12)[1]
		@test (typ, Ptr{typ}, Ptr{Ptr{typ}}, Ptr{Ptr{Ptr{typ}}}) == propertytypes(mod.S12)
		
		@test mod.S13 <: Cstruct
		@test (:s,) == propertynames(mod.S13)
		@test propertytypes(mod.S13)[1] <: Ptr
		
		@test mod.S14 <: Cstruct
		@test (:s1, :s2, :s3, :s4, :s5, :s6) == propertynames(mod.S14)
		typ = propertytypes(mod.S14)[1]
		@test (typ, Ptr{typ}, (@carray typ[2]), (@carray (@carray typ[2])[5]), (@carray (@carray Ptr{typ}[2])[5]), Ptr{(@carray Ptr{typ}[2])}) == propertytypes(mod.S14)
		
		@test mod.S15 <: Cstruct
		@test (:s,) == propertynames(mod.S15)
		@test eltype(propertytypes(mod.S15)[1]) <: Cstruct
		
		@test mod.S16 <: Cstruct
		@test (:i, :u) == propertynames(mod.S16)
		@test (Cint, Cuint) == propertytypes(mod.S16)
		
		@test mod.S17 <: Cstruct
		@test (:c, :i) == propertynames(mod.S17)
		@test (Cchar, Cint) == propertytypes(mod.S17)
		@test CBinding._strategy(mod.S17) === CBinding.ALIGN_NATIVE
		
		@test mod.S18 <: Cstruct
		@test (:c, :i) == propertynames(mod.S18)
		@test (Cchar, Cint) == propertytypes(mod.S18)
		@test CBinding._strategy(mod.S18) === CBinding.ALIGN_PACKED
		
		@test mod.S19 <: Cstruct
		@test (:c, :i) == propertynames(mod.S19)
		@test (Cchar, Cint) == propertytypes(mod.S19)
		@test CBinding._strategy(mod.S19) === CBinding.ALIGN_NATIVE
		
		@test mod.S20 <: Cstruct
		@test (:c, :i) == propertynames(mod.S20)
		@test (Cchar, Cint) == propertytypes(mod.S20)
		@test CBinding._strategy(mod.S20) === CBinding.ALIGN_PACKED
		
		@test mod.S21 <: Cstruct
		@test (:f,) == propertynames(mod.S21)
		@test (Ptr{Cfunction{Cvoid, Tuple{}}},) == propertytypes(mod.S21)
		
		@test mod.S22 <: Cstruct
		@test (:f,) == propertynames(mod.S22)
		@test (Ptr{Cfunction{Ptr{Cfunction{Cint, Tuple{Cint, Cfloat}}}, Tuple{Ptr{mod.S21}, Cint}}},) == propertytypes(mod.S22)
		
		@test mod.S23 <: Cstruct
		@test (:f,) == propertynames(mod.S23)
		@test (Ptr{Cfunction{Cint, Tuple{Ptr{Cchar}, Vararg}}},) == propertytypes(mod.S23)
		
		@test mod.S25 <: Cstruct
		@test (:s1, :s2, :s3) == propertynames(mod.S25)
		@test (Ptr{mod.S24}, Ptr{mod._S24}, Ptr{mod.S25}) == propertytypes(mod.S25)
		
		@test mod.S24 <: Cstruct
		@test (:s1, :s2, :s3) == propertynames(mod.S24)
		@test (Ptr{mod.S24}, Ptr{mod._S24}, mod.S25) == propertytypes(mod.S24)
		
		@test mod.S26 <: Cstruct
		@test (:e1, :e2, :e3, :e4, :e5) == propertynames(mod.S26)
		@test (mod.E3, Ptr{mod.E3}, mod.E3, mod.E1, Ptr{mod.E1}) == propertytypes(mod.S26)
		
		@test mod.S27 <: Cstruct
		@test (:i,) == propertynames(mod.S27)
		@test (Cint,) == propertytypes(mod.S27)
		
		@test mod.S28 <: Cstruct
		@test (:i,) == propertynames(mod.S28)
		@test (Cint,) == propertytypes(mod.S28)
		
		@test mod.S29 <: Cstruct
		@test (:s1, :s2) == propertynames(mod.S29)
		@test (Ptr{mod.S29}, mod.S29_ptr) == propertytypes(mod.S29)
		
		@test mod.S30 <: Cstruct
		@test (:f,) == propertynames(mod.S30)
		@test (Ptr{Cfunction{Cvoid, Tuple{mod.S30}}},) == propertytypes(mod.S30)
		
		@test mod.S32 <: Cstruct
		@test (:s,) == propertynames(mod.S32)
		@test (Ptr{mod.S31},) == propertytypes(mod.S32)
	end
	
	
	@testset "enums" begin
		@test mod.E1 <: Cenum
		@test mod.E1_1 == 0
		@test mod.E1_2 == 1
		@test mod.E1_3 == 2
		
		@test mod.E2 <: Cenum
		@test mod.E2_1 == 1
		@test mod.E2_2 == mod.E2_1
		@test mod.E2_3 == mod.E2_1+10
		@test mod.E2_4 == 0
		@test mod.E2_5 == 0xffffffff
		@test mod.E2_6 == 0xffffffffffff
		
		@test mod.E3 <: Cenum
		@test mod.E3_1 == 0
		
		@test mod.E4 <: Cenum
		@test mod.E4_1 == 0
		
		@test mod.E5 <: Cenum
		@test mod.E5_1 == 0
	end
	
	
	@testset "globals" begin
		@test mod.g1 isa Cglobalconst{Cint}
		@test mod.g2 isa Cglobalconst{mod.S24}
		@test mod.g3 isa Cglobalconst{Ptr{mod.S24}}
		
		@test mod.g4 isa Cglobal{Cint}
		@test mod.g5 isa Cglobal{mod.S24}
		@test mod.g6 isa Cglobal{Ptr{mod.S24}}
		
		@test mod.g7 isa Cglobalconst{Cint}
	end
	
	
	@testset "functions" begin
	end
end

