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
			check("@ctypedef T1 @Cvoid", "T1")
			check("@ctypedef T2 T1", "T2")
			
			check("@ctypedef T3 @Cchar", "T3")
			check("@ctypedef T4 @Cshort", "T4")
			check("@ctypedef T5 @Cint", "T5")
			check("@ctypedef T6 @Clong", "T6")
			check("@ctypedef T7 @Clonglong", "T7")
			
			check("@ctypedef T8 @Cchar", "T8")
			check("@ctypedef T9 @Cshort", "T9")
			check("@ctypedef T10 @Cint", "T10")
			check("@ctypedef T11 @Clong", "T11")
			check("@ctypedef T12 @Clonglong", "T12")
			
			check("@ctypedef T13 @Cuchar", "T13")
			check("@ctypedef T14 @Cushort", "T14")
			check("@ctypedef T15 @Cuint", "T15")
			check("@ctypedef T16 @Culong", "T16")
			check("@ctypedef T17 @Culonglong", "T17")
			
			check("@ctypedef T18 @Cfloat", "T18")
			check("@ctypedef T19 @Cdouble", "T19")
			check("@ctypedef T20 @Clongdouble", "T20")
			
			check("@ctypedef T21 (@Complex){@Cfloat}", "T21")
			check("@ctypedef T22 (@Complex){@Cdouble}", "T22")
			check("@ctypedef T23 (@Complex){@Clongdouble}", "T23")
		end
		
		@testset "enums" begin
			check("""
				@cenum E1 {
					E1_1 = (@Cuint)(0)
					E1_2 = (@Cuint)(1)
					E1_3 = (@Cuint)(2)
				}""", "E1", "E1_1", "E1_2", "E1_3")
			
			check("""
				@cenum E2 {
					E2_1 = (@Culong)(1)
					E2_2 = (@Culong)(1)
					E2_3 = (@Culong)(11)
					E2_4 = (@Culong)(0)
					E2_5 = (@Culong)(4294967295)
					E2_6 = (@Culong)(281474976710655)
				}""", "E2", "E2_1", "E2_2", "E2_3", "E2_4", "E2_5", "E2_6")
		end
		
		@testset "structs" begin
			check("""
				@cstruct S1 { }""", "S1")
			
			check("""
				@cstruct S2 {
					i::@Cint
				}""", "S2")
			
			check("""
				@cstruct S3 {
					s::S1
				}""", "S3")
			
			check("""
				@cstruct S4 {
					@cstruct {
						i::@Cint
						s::S3
					}
				}""", "S4")
			
			check("""
				@cstruct S5 {
					s::@cstruct {
						i::@Cint
						s::S3
					}
				}""", "S5")
			
			check("""
				@cstruct S6 {
					(s, s1)::@cstruct S7 {
						i::@Cint
						s::S3
					}
					i::@Cint
					s2::S7
				}""", "S6", "S7")
			
			check("""
				@cstruct S8 {
					s::S7
				}""", "S8")
			
			check("""
				@cstruct S9 {
					(s1, s2)::@cstruct {
						i::@Cint
					}
				}""", "S9")
			
			check("""
				@cstruct S10 {
					@cstruct S11 {
						i::@Cint
					}
				}""", "S10", "S11")
			
			check("""
				@cstruct S12 {
					(s1, s2::(@Ptr){_}, s3::(@Ptr){(@Ptr){_}}, s4::(@Ptr){(@Ptr){(@Ptr){_}}})::@cstruct {
						i::@Cint
					}
				}""", "S12")
			
			check("""
				@cstruct S13 {
					s::(@Ptr){@cstruct {
						i::@Cint
					}}
				}""", "S13")
			
			check("""
			@cstruct S14 {
				(s1, s2::(@Ptr){_}, s3::(_)[2], s4::((_)[2])[5], s5::(((@Ptr){_})[2])[5], s6::(((@Ptr){_})[2])[])::@cstruct {
					i::@Cint
				}
			}""", "S14")
			
			check("""
				@cstruct S15 {
					s::(@cstruct {
						i::@Cint
					})[2]
				}""", "S15")
			
			check("""
				@cstruct S16 {
					i::@Cint
					u::@Cuint
				}""", "S16")
			
			check("""
				@cstruct S17 {
					c::@Cchar
					i::@Cint
				}""", "S17")
			
			check("""
				@cstruct S18 {
					c::@Cchar
					i::@Cint
				} __packed__""", "S18")
			
			check("""
				@cstruct S19 {
					@cstruct {
						c::@Cchar
					} __packed__
					@cstruct {
						i::@Cint
					} __packed__
				}""", "S19")
			
			check("""
				@cstruct S20 {
					@cstruct {
						c::@Cchar
					}
					@cstruct {
						i::@Cint
					}
				} __packed__""", "S20")
			
			check("""
				@cstruct S21 {
					f::(@Ptr){(@Cfunction){(@Cvoid), (@Tuple){}, (@CDECL)}}
				}""", "S21")
			
			check("""
				@cstruct S22 {
					f::(@Ptr){(@Cfunction){((@Ptr){(@Cfunction){(@cunion {
						i::@Cint
						f::@Cfloat
						@cstruct {
							j::@Cint
						}
					}), (@Tuple){(@Cint), (@Cfloat)}, (@CDECL)}}), (@Tuple){(S22), (@Cint)}, (@CDECL)}}
				}""", "S22")
			
			check("""
				@cstruct S23 {
					f::(@Ptr){(@Cfunction){(@Cint), (@Tuple){((@Ptr){(@Cconst)(@Cchar)}), (@Vararg)}, (@CDECL)}}
				}""", "S23")
			
			check("""
				@cstruct S24""", "S24")
			
			check("""
				@cstruct _S24""", "_S24")
			
			check("""
				@cstruct S25 {
					s1::(@Ptr){S24}
					s2::(@Ptr){_S24}
					s3::(@Ptr){S25}
				}""", "S25")
			
			check("""
				@cstruct S24 {
					s1::(@Ptr){S24}
					s2::(@Ptr){_S24}
					s3::S25
				}""", "S24")
			
			check("""
				@cstruct S26 {
					(e1, e2::(@Ptr){_})::@cenum E3 {
						E3_1 = (@Cuint)(0)
					}
					e3::E3
					(e4, e5::(@Ptr){_})::E1
				}""", "S26", "E3", "E3_1")
		end
		
		@testset "typedefs" begin
			check("""
				@ctypedef S27 @cstruct S27_ {
					i::@Cint
				}""", "S27", "S27_")
			
			check("""
				@ctypedef S28 @cstruct {
					i::@Cint
				}""", "S28")
			
			check("""
				@cstruct S29""", "S29")
			
			check("""
				@ctypedef S29_ S29""", "S29_")
			
			check("""
				@ctypedef S29_ptr (@Ptr){S29}""", "S29_ptr")
			
			check("""
				@cstruct S29 {
					s1::(@Ptr){S29_}
					s2::S29_ptr
				}""", "S29")
			
			check("""
				@cstruct S30""", "S30")
			
			check("""
				@ctypedef F1 (@Ptr){(@Cfunction){(@Cvoid), (@Tuple){(S30)}, (@CDECL)}}""", "F1")
			
			check("""
				@cstruct S30 {
					(i, j, k)::@Cint
					f::F1
				}""", "S30")
			
			check("""
				@ctypedef F2 (@Ptr){(@Cfunction){(@cstruct F2ret {
					i::@Cint
					f::@Cfloat
				}), (@Tuple){(@cunion {
					i::@Cint
					f::@Cfloat
				})}, (@CDECL)}}""", "F2", "F2ret")
			
			check(true, """
				@ctypedef F3 ((@Ptr){(@Cfunction){(@cstruct F3ret {
					i::@Cint
					f::@Cfloat
				}), (@Tuple){((@cunion {
					i::@Cint
					f::@Cfloat
				})[1]), ((@Ptr){F3ret})}, (@CDECL)}})[3]""", "F3", "F3ret")
			
			check("""
				@cstruct _S31""", "_S31")
			
			check("""
				@ctypedef S31 _S31""", "S31")
			
			check("""
				@cstruct S32 {
					s::(@Ptr){S31}
				}""", "S32")
			
			check("""
				@ctypedef S33 @cstruct S33 {
					i::@Cint
				}""", "S33")
			
			check("""
				@ctypedef S34 @cstruct {
					i::(@Cconst)(@Cint)
					p::(@Ptr){(@Cconst)(@Cint)}
					cp::(@Cconst)((@Ptr){(@Cconst)(@Cint)})
					s::(@Ptr){(@Cconst)(S33)}
					cs::(@Cconst)((@Ptr){(@Cconst)(S33)})
				}""", "S34")
			
			check("""
				@ctypedef S35 @cstruct {
					(cp::(@Ptr){(@Cconst)(_)}, p::(@Ptr){(@Cconst)(_)}, s::(@Cconst)(_))::@cstruct {
						i::@Cint
					}
				}""", "S35")
			
			check("""
				@ctypedef S36 @cstruct {
					length::@Cint
					data::(@Cchar)[]
				}""", "S36")
			
			check("""
				@cstruct S37 {
					(x, y::(@Ptr){(@Cfunction){(_), (@Tuple){}, (@CDECL)}}, z::(@Ptr){(@Cfunction){(_), (@Tuple){(@Cint)}, (@CDECL)}})::@Cint
				}""", "S37")
			
			check("""
				@ctypedef E4 @cenum E4_ {
					E4_1 = (@Cuint)(0)
				}""", "E4", "E4_", "E4_1")
			
			check("""
				@ctypedef E5 @cenum {
					E5_1 = (@Cuint)(0)
				}""", "E5", "E5_1")
			
			check("""
				@ctypedef E6 @cenum {
					E6_0 = (@Cuchar)(0)
					E6_1 = (@Cuchar)(1)
				} __packed__""", "E6", "E6_0", "E6_1")
			
			check("""
				@ctypedef T24 (@Cint)[2]""", "T24")
			
			check("""
				@ctypedef T25 ((@Cint)[2])[5]""", "T25")
			
			check("""
				@ctypedef T26 ((@Ptr){(@Cconst)(@Cint)})[2]""", "T26")
			
			check("""
				@ctypedef T27 (@cstruct {
					i::@Cint
				})[3]""", "T27")
		end
		
		@testset "variables" begin
			check("""
				@cextern g1::(@Cconst)(@Cint)""", "g1")
			
			check("""
				@cextern g2::(@Cconst)(S24)""", "g2")
			
			check("""
				@cextern g3::(@Cconst)((@Ptr){S24})""", "g3")
			
			check("""
				@cextern g4::@Cint""", "g4")
			
			check("""
				@cextern g5::S24""", "g5")
			
			check("""
				@cextern g6::(@Ptr){S24}""", "g6")
		end
		
		@testset "functions" begin
			check("""
				@cextern f1()::@Cvoid""", "f1")
			
			check("""
				@cextern f2()::@Cvoid""", "f2")
			
			check("""
				@cextern f3()::@Cint""", "f3")
			
			check("""
				@cextern f4(i::@Cint)::@Cvoid""", "f4")
			
			check("""
				@cextern f5(i::@Cint, var"?vararg?"...)::@Cint""", "f5")
			
			check("""
				@cextern f6(p::(@Ptr){(@Cconst)(@Cchar)})::@Cvoid""", "f6")
			
			check("""
				@cextern f7(i1::(@Cint), i2::(@Cint), var"?3?"::(@Cint), var"?4?"::(@Cint), i5::(@Cint))::@Cvoid""", "f7")
			
			check("""
				@cextern f8(i1::(@Cint), var"?2?"::(@Cint), _2::(@Cint))::@Cvoid""", "f8")
			
			check("""
				@cextern f9(arg::(@Ptr){(@Cfunction){(@Cint), (@Tuple){(@Cint), (@Cint)}, (@CDECL)}})::@Cvoid""", "f9")
			
			check("""
				@cextern f10()::(@Ptr){(@Cfunction){(@Cint), (@Tuple){(@Cint), (@Cint)}, (@CDECL)}}""", "f10")
			
			check("""
				@cextern f11::(@Ptr){(@Cfunction){(@cstruct {
					i::@Cint
					f::@Cfloat
				}), (@Tuple){(@cunion {
					i::@Cint
					f::@Cfloat
				})}, (@CDECL)}}""", "f11")
			
			check(true, """
				@cextern (g8, f12::(@Ptr){(@Cfunction){(_), (@Tuple){(@cunion {
					i::@Cint
					j::@Cfloat
				}), (@cunion N1 {
					i::@Cint
					j::@Cfloat
				}), ((@Ptr){SG1})}, (@CDECL)}}, f13(u::(@cunion {
					i::@Cint
					j::@Cfloat
				}), n::(@cunion N2 {
					i::@Cint
					j::@Cfloat
				}), s::(@Ptr){SG1})::_)::@cstruct SG1 {
					i::@Cint
				}""", "SG1", "N1", "N2", "f12", "f13", "g8")
		end
	end
	
	@testset "generated" begin
		io = IOBuffer()
		@test (generate(io, nothing => cvts) ; true)
	end
end

