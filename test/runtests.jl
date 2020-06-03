using Test: @testset, @test, @test_throws, @test_broken
using CBindingGen


@testset "CBindingGen" begin
	@testset "convert headers" begin
		cvts = convert_header(_ -> false, "test.h", args = ["-I."])
		@test isempty(cvts)
		
		cvts = convert_header(_ -> true, "test.h", args = ["-I."])
		@test !isempty(cvts)
	end
	
	
	cvts = convert_header(_ -> true, "test.h", args = ["-I."])
	
	i = 1
	check(expr::String, exports::String...) = check(false, expr, exports...)
	function check(broken::Bool, expr::String, exports::String...)
		cvt = cvts[i]
		i += 1
		
		broken ? (@test_broken cvt.expr == expr) : (@test cvt.expr == expr)
		@test length(cvt.comments) == length(exports)
		for e in exports
			@test e in keys(cvt.comments)
		end
	end
	
	
	@testset "converted" begin
		@testset "simple typedefs" begin
			check("𝐣𝐥.@ctypedef T1 𝐣𝐥.Cvoid", "T1")
			check("𝐣𝐥.@ctypedef T2 T1", "T2")
			
			check("𝐣𝐥.@ctypedef T3 𝐣𝐥.Cchar", "T3")
			check("𝐣𝐥.@ctypedef T4 𝐣𝐥.Cshort", "T4")
			check("𝐣𝐥.@ctypedef T5 𝐣𝐥.Cint", "T5")
			check("𝐣𝐥.@ctypedef T6 𝐣𝐥.Clong", "T6")
			check("𝐣𝐥.@ctypedef T7 𝐣𝐥.Clonglong", "T7")
			
			check("𝐣𝐥.@ctypedef T8 𝐣𝐥.Cchar", "T8")
			check("𝐣𝐥.@ctypedef T9 𝐣𝐥.Cshort", "T9")
			check("𝐣𝐥.@ctypedef T10 𝐣𝐥.Cint", "T10")
			check("𝐣𝐥.@ctypedef T11 𝐣𝐥.Clong", "T11")
			check("𝐣𝐥.@ctypedef T12 𝐣𝐥.Clonglong", "T12")
			
			check("𝐣𝐥.@ctypedef T13 𝐣𝐥.Cuchar", "T13")
			check("𝐣𝐥.@ctypedef T14 𝐣𝐥.Cushort", "T14")
			check("𝐣𝐥.@ctypedef T15 𝐣𝐥.Cuint", "T15")
			check("𝐣𝐥.@ctypedef T16 𝐣𝐥.Culong", "T16")
			check("𝐣𝐥.@ctypedef T17 𝐣𝐥.Culonglong", "T17")
			
			check("𝐣𝐥.@ctypedef T18 𝐣𝐥.Cfloat", "T18")
			check("𝐣𝐥.@ctypedef T19 𝐣𝐥.Cdouble", "T19")
			check("𝐣𝐥.@ctypedef T20 𝐣𝐥.Clongdouble", "T20")
			
			check("𝐣𝐥.@ctypedef T21 𝐣𝐥.Complex{𝐣𝐥.Cfloat}", "T21")
			check("𝐣𝐥.@ctypedef T22 𝐣𝐥.Complex{𝐣𝐥.Cdouble}", "T22")
			check("𝐣𝐥.@ctypedef T23 𝐣𝐥.Complex{𝐣𝐥.Clongdouble}", "T23")
		end
		
		@testset "enums" begin
			check("""
				𝐣𝐥.@cenum E1 {
					E1_1 = 𝐣𝐥.Cuint(0)
					E1_2 = 𝐣𝐥.Cuint(1)
					E1_3 = 𝐣𝐥.Cuint(2)
				}""", "E1", "E1_1", "E1_2", "E1_3")
			
			culong = Sys.iswindows() ? "𝐣𝐥.Culonglong" : "𝐣𝐥.Culong"
			check("""
				𝐣𝐥.@cenum E2 {
					E2_1 = $(culong)(1)
					E2_2 = $(culong)(1)
					E2_3 = $(culong)(11)
					E2_4 = $(culong)(0)
					E2_5 = $(culong)(4294967295)
					E2_6 = $(culong)(281474976710655)
				}""", "E2", "E2_1", "E2_2", "E2_3", "E2_4", "E2_5", "E2_6")
		end
		
		@testset "structs" begin
			check("""
				𝐣𝐥.@cstruct S1 { }""", "S1")
			
			check("""
				𝐣𝐥.@cstruct S2 {
					i::𝐣𝐥.Cint
				}""", "S2")
			
			check("""
				𝐣𝐥.@cstruct S3 {
					s::S1
				}""", "S3")
			
			check("""
				𝐣𝐥.@cstruct S4 {
					𝐣𝐥.@cstruct {
						i::𝐣𝐥.Cint
						s::S3
					}
				}""", "S4")
			
			check("""
				𝐣𝐥.@cstruct S5 {
					s::𝐣𝐥.@cstruct {
						i::𝐣𝐥.Cint
						s::S3
					}
				}""", "S5")
			
			check("""
				𝐣𝐥.@cstruct S6 {
					(s, s1)::𝐣𝐥.@cstruct S7 {
						i::𝐣𝐥.Cint
						s::S3
					}
					i::𝐣𝐥.Cint
					s2::S7
				}""", "S6", "S7")
			
			check("""
				𝐣𝐥.@cstruct S8 {
					s::S7
				}""", "S8")
			
			check("""
				𝐣𝐥.@cstruct S9 {
					(s1, s2)::𝐣𝐥.@cstruct {
						i::𝐣𝐥.Cint
					}
				}""", "S9")
			
			check("""
				𝐣𝐥.@cstruct S10 {
					𝐣𝐥.@cstruct S11 {
						i::𝐣𝐥.Cint
					}
				}""", "S10", "S11")
			
			check("""
				𝐣𝐥.@cstruct S12 {
					(s1, s2::𝐣𝐥.Ptr{_}, s3::𝐣𝐥.Ptr{𝐣𝐥.Ptr{_}}, s4::𝐣𝐥.Ptr{𝐣𝐥.Ptr{𝐣𝐥.Ptr{_}}})::𝐣𝐥.@cstruct {
						i::𝐣𝐥.Cint
					}
				}""", "S12")
			
			check("""
				𝐣𝐥.@cstruct S13 {
					s::𝐣𝐥.Ptr{𝐣𝐥.@cstruct {
						i::𝐣𝐥.Cint
					}}
				}""", "S13")
			
			check("""
			𝐣𝐥.@cstruct S14 {
				(s1, s2::𝐣𝐥.Ptr{_}, s3::_[2], s4::(_[2])[5], s5::(𝐣𝐥.Ptr{_}[2])[5], s6::(𝐣𝐥.Ptr{_}[2])[])::𝐣𝐥.@cstruct {
					i::𝐣𝐥.Cint
				}
			}""", "S14")
			
			check("""
				𝐣𝐥.@cstruct S15 {
					s::(𝐣𝐥.@cstruct {
						i::𝐣𝐥.Cint
					})[2]
				}""", "S15")
			
			check("""
				𝐣𝐥.@cstruct S16 {
					i::𝐣𝐥.Cint
					u::𝐣𝐥.Cuint
				}""", "S16")
			
			check("""
				𝐣𝐥.@cstruct S17 {
					c::𝐣𝐥.Cchar
					i::𝐣𝐥.Cint
				}""", "S17")
			
			check("""
				𝐣𝐥.@cstruct S18 {
					c::𝐣𝐥.Cchar
					i::𝐣𝐥.Cint
				} __packed__""", "S18")
			
			check("""
				𝐣𝐥.@cstruct S19 {
					𝐣𝐥.@cstruct {
						c::𝐣𝐥.Cchar
					} __packed__
					𝐣𝐥.@cstruct {
						i::𝐣𝐥.Cint
					} __packed__
				}""", "S19")
			
			check("""
				𝐣𝐥.@cstruct S20 {
					𝐣𝐥.@cstruct {
						c::𝐣𝐥.Cchar
					}
					𝐣𝐥.@cstruct {
						i::𝐣𝐥.Cint
					}
				} __packed__""", "S20")
			
			check("""
				𝐣𝐥.@cstruct S21 {
					f::𝐣𝐥.Ptr{𝐣𝐥.Cfunction{𝐣𝐥.Cvoid, 𝐣𝐥.Tuple{}, 𝐣𝐥.CDECL}}
				}""", "S21")
			
			check("""
				𝐣𝐥.@cstruct S22 {
					f::𝐣𝐥.Ptr{𝐣𝐥.Cfunction{𝐣𝐥.Ptr{𝐣𝐥.Cfunction{(𝐣𝐥.@cunion {
						i::𝐣𝐥.Cint
						f::𝐣𝐥.Cfloat
						𝐣𝐥.@cstruct {
							j::𝐣𝐥.Cint
						}
					}), 𝐣𝐥.Tuple{𝐣𝐥.Cint, 𝐣𝐥.Cfloat}, 𝐣𝐥.CDECL}}, 𝐣𝐥.Tuple{S22, 𝐣𝐥.Cint}, 𝐣𝐥.CDECL}}
				}""", "S22")
			
			check("""
				𝐣𝐥.@cstruct S23 {
					f::𝐣𝐥.Ptr{𝐣𝐥.Cfunction{𝐣𝐥.Cint, 𝐣𝐥.Tuple{𝐣𝐥.Ptr{𝐣𝐥.Cconst(𝐣𝐥.Cchar)}, 𝐣𝐥.Vararg}, 𝐣𝐥.CDECL}}
				}""", "S23")
			
			check("""
				𝐣𝐥.@cstruct S24""", "S24")
			
			check("""
				𝐣𝐥.@cstruct _S24""", "_S24")
			
			check("""
				𝐣𝐥.@cstruct S25 {
					s1::𝐣𝐥.Ptr{S24}
					s2::𝐣𝐥.Ptr{_S24}
					s3::𝐣𝐥.Ptr{S25}
				}""", "S25")
			
			check("""
				𝐣𝐥.@cstruct S24 {
					s1::𝐣𝐥.Ptr{S24}
					s2::𝐣𝐥.Ptr{_S24}
					s3::S25
				}""", "S24")
			
			check("""
				𝐣𝐥.@cstruct S26 {
					(e1, e2::𝐣𝐥.Ptr{_})::𝐣𝐥.@cenum E3 {
						E3_1 = 𝐣𝐥.Cuint(0)
					}
					e3::E3
					(e4, e5::𝐣𝐥.Ptr{_})::E1
				}""", "S26", "E3", "E3_1")
		end
		
		@testset "typedefs" begin
			check("""
				𝐣𝐥.@ctypedef S27 𝐣𝐥.@cstruct S27_ {
					i::𝐣𝐥.Cint
				}""", "S27", "S27_")
			
			check("""
				𝐣𝐥.@ctypedef S28 𝐣𝐥.@cstruct {
					i::𝐣𝐥.Cint
				}""", "S28")
			
			check("""
				𝐣𝐥.@cstruct S29""", "S29")
			
			check("""
				𝐣𝐥.@ctypedef S29_ S29""", "S29_")
			
			check("""
				𝐣𝐥.@ctypedef S29_ptr 𝐣𝐥.Ptr{S29}""", "S29_ptr")
			
			check("""
				𝐣𝐥.@cstruct S29 {
					s1::𝐣𝐥.Ptr{S29_}
					s2::S29_ptr
				}""", "S29")
			
			check("""
				𝐣𝐥.@cstruct S30""", "S30")
			
			check("""
				𝐣𝐥.@ctypedef F1 𝐣𝐥.Ptr{𝐣𝐥.Cfunction{𝐣𝐥.Cvoid, 𝐣𝐥.Tuple{S30}, 𝐣𝐥.CDECL}}""", "F1")
			
			check("""
				𝐣𝐥.@cstruct S30 {
					(i, j, k)::𝐣𝐥.Cint
					f::F1
				}""", "S30")
			
			check("""
				𝐣𝐥.@ctypedef F2 𝐣𝐥.Ptr{𝐣𝐥.Cfunction{(𝐣𝐥.@cstruct F2ret {
					i::𝐣𝐥.Cint
					f::𝐣𝐥.Cfloat
				}), 𝐣𝐥.Tuple{𝐣𝐥.@cunion {
					i::𝐣𝐥.Cint
					f::𝐣𝐥.Cfloat
				}}, 𝐣𝐥.CDECL}}""", "F2", "F2ret")
			
			check(true, """
				𝐣𝐥.@ctypedef F3 𝐣𝐥.Ptr{𝐣𝐥.Cfunction{(𝐣𝐥.@cstruct F3ret {
					i::𝐣𝐥.Cint
					f::𝐣𝐥.Cfloat
				}), 𝐣𝐥.Tuple{(𝐣𝐥.@cunion {
					i::𝐣𝐥.Cint
					f::𝐣𝐥.Cfloat
				}[1]), 𝐣𝐥.Ptr{F3ret}}, 𝐣𝐥.CDECL}}[3]""", "F3", "F3ret")
			
			check("""
				𝐣𝐥.@cstruct _S31""", "_S31")
			
			check("""
				𝐣𝐥.@ctypedef S31 _S31""", "S31")
			
			check("""
				𝐣𝐥.@cstruct S32 {
					s::𝐣𝐥.Ptr{S31}
				}""", "S32")
			
			check("""
				𝐣𝐥.@ctypedef S33 𝐣𝐥.@cstruct S33 {
					i::𝐣𝐥.Cint
				}""", "S33")
			
			check("""
				𝐣𝐥.@ctypedef S34 𝐣𝐥.@cstruct {
					i::𝐣𝐥.Cconst(𝐣𝐥.Cint)
					p::𝐣𝐥.Ptr{𝐣𝐥.Cconst(𝐣𝐥.Cint)}
					cp::𝐣𝐥.Cconst(𝐣𝐥.Ptr{𝐣𝐥.Cconst(𝐣𝐥.Cint)})
					s::𝐣𝐥.Ptr{𝐣𝐥.Cconst(S33)}
					cs::𝐣𝐥.Cconst(𝐣𝐥.Ptr{𝐣𝐥.Cconst(S33)})
				}""", "S34")
			
			check("""
				𝐣𝐥.@ctypedef S35 𝐣𝐥.@cstruct {
					(cp::𝐣𝐥.Ptr{𝐣𝐥.Cconst(_)}, p::𝐣𝐥.Ptr{𝐣𝐥.Cconst(_)}, s::𝐣𝐥.Cconst(_))::𝐣𝐥.@cstruct {
						i::𝐣𝐥.Cint
					}
				}""", "S35")
			
			check("""
				𝐣𝐥.@ctypedef S36 𝐣𝐥.@cstruct {
					length::𝐣𝐥.Cint
					data::𝐣𝐥.Cchar[]
				}""", "S36")
			
			check("""
				𝐣𝐥.@cstruct S37 {
					(x, y::𝐣𝐥.Ptr{𝐣𝐥.Cfunction{_, 𝐣𝐥.Tuple{}, 𝐣𝐥.CDECL}}, z::𝐣𝐥.Ptr{𝐣𝐥.Cfunction{_, 𝐣𝐥.Tuple{𝐣𝐥.Cint}, 𝐣𝐥.CDECL}})::𝐣𝐥.Cint
				}""", "S37")
			
			check("""
				𝐣𝐥.@ctypedef E4 𝐣𝐥.@cenum E4_ {
					E4_1 = 𝐣𝐥.Cuint(0)
				}""", "E4", "E4_", "E4_1")
			
			check("""
				𝐣𝐥.@ctypedef E5 𝐣𝐥.@cenum {
					E5_1 = 𝐣𝐥.Cuint(0)
				}""", "E5", "E5_1")
			
			check("""
				𝐣𝐥.@ctypedef E6 𝐣𝐥.@cenum {
					E6_0 = 𝐣𝐥.Cuchar(0)
					E6_1 = 𝐣𝐥.Cuchar(1)
				} __packed__""", "E6", "E6_0", "E6_1")
			
			check("""
				𝐣𝐥.@ctypedef T24 𝐣𝐥.Cint[2]""", "T24")
			
			check("""
				𝐣𝐥.@ctypedef T25 (𝐣𝐥.Cint[2])[5]""", "T25")
			
			check("""
				𝐣𝐥.@ctypedef T26 𝐣𝐥.Ptr{𝐣𝐥.Cconst(𝐣𝐥.Cint)}[2]""", "T26")
			
			check("""
				𝐣𝐥.@ctypedef T27 𝐣𝐥.@cstruct {
					i::𝐣𝐥.Cint
				}[3]""", "T27")
		end
		
		@testset "variables" begin
			check("""
				𝐣𝐥.@cextern g1::𝐣𝐥.Cconst(𝐣𝐥.Cint)""", "g1")
			
			check("""
				𝐣𝐥.@cextern g2::𝐣𝐥.Cconst(S24)""", "g2")
			
			check("""
				𝐣𝐥.@cextern g3::𝐣𝐥.Cconst(𝐣𝐥.Ptr{S24})""", "g3")
			
			check("""
				𝐣𝐥.@cextern g4::𝐣𝐥.Cint""", "g4")
			
			check("""
				𝐣𝐥.@cextern g5::S24""", "g5")
			
			check("""
				𝐣𝐥.@cextern g6::𝐣𝐥.Ptr{S24}""", "g6")
		end
		
		@testset "functions" begin
			check("""
				𝐣𝐥.@cextern f1()::𝐣𝐥.Cvoid""", "f1")
			
			check("""
				𝐣𝐥.@cextern f2()::𝐣𝐥.Cvoid""", "f2")
			
			check("""
				𝐣𝐥.@cextern f3()::𝐣𝐥.Cint""", "f3")
			
			check("""
				𝐣𝐥.@cextern f4(i::𝐣𝐥.Cint)::𝐣𝐥.Cvoid""", "f4")
			
			check("""
				𝐣𝐥.@cextern f5(i::𝐣𝐥.Cint, var"?vararg?"...)::𝐣𝐥.Cint""", "f5")
			
			check("""
				𝐣𝐥.@cextern f6(p::𝐣𝐥.Ptr{𝐣𝐥.Cconst(𝐣𝐥.Cchar)})::𝐣𝐥.Cvoid""", "f6")
			
			check("""
				𝐣𝐥.@cextern f7(i1::𝐣𝐥.Cint, i2::𝐣𝐥.Cint, var"?3?"::𝐣𝐥.Cint, var"?4?"::𝐣𝐥.Cint, i5::𝐣𝐥.Cint)::𝐣𝐥.Cvoid""", "f7")
			
			check("""
				𝐣𝐥.@cextern f8(i1::𝐣𝐥.Cint, var"?2?"::𝐣𝐥.Cint, _2::𝐣𝐥.Cint)::𝐣𝐥.Cvoid""", "f8")
			
			check("""
				𝐣𝐥.@cextern f9(arg::𝐣𝐥.Ptr{𝐣𝐥.Cfunction{𝐣𝐥.Cint, 𝐣𝐥.Tuple{𝐣𝐥.Cint, 𝐣𝐥.Cint}, 𝐣𝐥.CDECL}})::𝐣𝐥.Cvoid""", "f9")
			
			check("""
				𝐣𝐥.@cextern f10()::𝐣𝐥.Ptr{𝐣𝐥.Cfunction{𝐣𝐥.Cint, 𝐣𝐥.Tuple{𝐣𝐥.Cint, 𝐣𝐥.Cint}, 𝐣𝐥.CDECL}}""", "f10")
			
			check("""
				𝐣𝐥.@cextern f11::𝐣𝐥.Ptr{𝐣𝐥.Cfunction{(𝐣𝐥.@cstruct {
					i::𝐣𝐥.Cint
					f::𝐣𝐥.Cfloat
				}), 𝐣𝐥.Tuple{𝐣𝐥.@cunion {
					i::𝐣𝐥.Cint
					f::𝐣𝐥.Cfloat
				}}, 𝐣𝐥.CDECL}}""", "f11")
			
			check(true, """
				𝐣𝐥.@cextern (g8, f12::𝐣𝐥.Ptr{𝐣𝐥.Cfunction{_, 𝐣𝐥.Tuple{(𝐣𝐥.@cunion {
					i::𝐣𝐥.Cint
					j::𝐣𝐥.Cfloat
				}[2]), (𝐣𝐥.@cunion N1 {
					i::𝐣𝐥.Cint
					j::𝐣𝐥.Cfloat
				}), 𝐣𝐥.Ptr{SG1}}, 𝐣𝐥.CDECL}}, f13(u::(𝐣𝐥.@cunion {
					i::𝐣𝐥.Cint
					j::𝐣𝐥.Cfloat
				}), n::(𝐣𝐥.@cunion N2 {
					i::𝐣𝐥.Cint
					j::𝐣𝐥.Cfloat
				}), s::𝐣𝐥.Ptr{SG1})::_)::𝐣𝐥.@cstruct SG1 {
					i::𝐣𝐥.Cint
				}""", "SG1", "N1", "N2", "f12", "f13", "g8")
		end
		
		@testset "pre-processor directives" begin
			check("""
				macro DEFINE_CHAR() return quote ('\\'') end end
				const DEFINE_CHAR = (@DEFINE_CHAR)""", "@DEFINE_CHAR", "DEFINE_CHAR")
			
			check("""
				macro DEFINE_STRING() return quote ("\\"") end end
				const DEFINE_STRING = (@DEFINE_STRING)""", "@DEFINE_STRING", "DEFINE_STRING")
			
			check("""
				macro DEFINE_INT() return quote (1234) end end
				const DEFINE_INT = (@DEFINE_INT)""", "@DEFINE_INT", "DEFINE_INT")
			
			check("""
				macro DEFINE_OxINT() return quote (0x0000abcd) end end
				const DEFINE_OxINT = (@DEFINE_OxINT)""", "@DEFINE_OxINT", "DEFINE_OxINT")
			
			check("""
				macro DEFINE_OINT() return quote (0x000001ff) end end
				const DEFINE_OINT = (@DEFINE_OINT)""", "@DEFINE_OINT", "DEFINE_OINT")
			
			check("""
				macro DEFINE_INTu() return quote (0x000010e1) end end
				const DEFINE_INTu = (@DEFINE_INTu)""", "@DEFINE_INTu", "DEFINE_INTu")
			
			check("""
				macro DEFINE_FLOAT() return quote (0.1234f0) end end
				const DEFINE_FLOAT = (@DEFINE_FLOAT)""", "@DEFINE_FLOAT", "DEFINE_FLOAT")
			
			check("""
				macro DEFINE_DOUBLE() return quote (0.1234) end end
				const DEFINE_DOUBLE = (@DEFINE_DOUBLE)""", "@DEFINE_DOUBLE", "DEFINE_DOUBLE")
			
			check("""
				macro DEFINE_DOT_FLOAT() return quote (0.1234f0) end end
				const DEFINE_DOT_FLOAT = (@DEFINE_DOT_FLOAT)""", "@DEFINE_DOT_FLOAT", "DEFINE_DOT_FLOAT")
			
			check("""
				macro DEFINE_DOT_DOUBLE() return quote (0.1234) end end
				const DEFINE_DOT_DOUBLE = (@DEFINE_DOT_DOUBLE)""", "@DEFINE_DOT_DOUBLE", "DEFINE_DOT_DOUBLE")
			
			check("""
				macro DEFINE_FLOAT_DOT() return quote (1234.0f0) end end
				const DEFINE_FLOAT_DOT = (@DEFINE_FLOAT_DOT)""", "@DEFINE_FLOAT_DOT", "DEFINE_FLOAT_DOT")
			
			check("""
				macro DEFINE_DOUBLE_DOT() return quote (1234.0) end end
				const DEFINE_DOUBLE_DOT = (@DEFINE_DOUBLE_DOT)""", "@DEFINE_DOUBLE_DOT", "DEFINE_DOUBLE_DOT")
			
			check("""
				macro DEFINE_EXP_FLOAT() return quote (-2140.0f0) end end
				const DEFINE_EXP_FLOAT = (@DEFINE_EXP_FLOAT)""", "@DEFINE_EXP_FLOAT", "DEFINE_EXP_FLOAT")
			
			check("""
				macro DEFINE_EXP_DOUBLE() return quote (-2140.0) end end
				const DEFINE_EXP_DOUBLE = (@DEFINE_EXP_DOUBLE)""", "@DEFINE_EXP_DOUBLE", "DEFINE_EXP_DOUBLE")
			
			check("""
				macro DEFINE_INT_TYPE() return quote (\$(𝐣𝐥.Cint)) end end
				const DEFINE_INT_TYPE = (@DEFINE_INT_TYPE)""", "@DEFINE_INT_TYPE", "DEFINE_INT_TYPE")
			
			check("""
				macro DEFINE_UINT_TYPE() return quote (\$(𝐣𝐥.Cuint)) end end
				const DEFINE_UINT_TYPE = (@DEFINE_UINT_TYPE)""", "@DEFINE_UINT_TYPE", "DEFINE_UINT_TYPE")
			
			check("""
				macro DEFINE_DEFINED() return quote (@DEFINE_INT_TYPE) end end""", "@DEFINE_DEFINED")
			
			check("""
				macro E6_0() return quote 0 end end""", "@E6_0")
		end
	end
	
	@testset "generated" begin
		io = IOBuffer()
		@test (generate(io, nothing => cvts) ; true)
	end
end

