
Clang.isdecl(x) = false
function _convert(ctx::ConverterContext, decl::CLTypedefDecl)
	name = _convertType(ctx, decl)
	(o, c, typ) = _convertTypedefType(ctx, underlying_type(decl))
	typ = isdecl(typ) || typedecl(typ) isa CLNoDeclFound ? typ : typedecl(typ)
	kind = :atcompile
	
	# if typ is the definition and it was just converted then we need to remove that conversion in favor of this one
	if (typ isa CLEnumDecl || typ isa CLUnionDecl || typ isa CLStructDecl) && !isempty(ctx.converted) && getdef(typ) == last(ctx.converted).decl
		pop!(ctx.converted)
		typ = typ isa CLEnumDecl ? _convertEnum(ctx, typ) : _convertAggregate(ctx, typ)
	else
		typ = _convertType(ctx, typ)
		ctx.typedefs[name] = "$(o)$(typ)$(c)"
		kind = :atcompile_typedefs
	end
	
	_export(ctx, name)
	push!(ctx.converted, JuliaizedC(
		decl,
		"CBinding.@ctypedef $(name) $(o)$(typ)$(c)",
		kind,
	))
end


function _convert(ctx::ConverterContext, decl::CLEnumDecl)
	expr = _convertEnum(ctx, decl)
	push!(ctx.converted, JuliaizedC(
		decl,
		expr,
		:atcompile,
	))
end


function _convert(ctx::ConverterContext, decl::Union{CLUnionDecl, CLStructDecl})
	expr = _convertAggregate(ctx, decl)
	isnothing(expr) || push!(ctx.converted, JuliaizedC(
		decl,
		expr,
		:atcompile,
	))
end



function _convertEnum(ctx, decl::CLEnumDecl; indent::Int = 0)
	name = _convertType(ctx, decl)
	
	vals = []
	for c in children(decl)
		vname = _convertName(ctx, c)
		vtype = _convertType(ctx, type(c))
		vval  = value(c)
		_export(ctx, vname)
		push!(vals, "$(vname) = $(vtype)($(vval))")
	end
	
	tabs = repeat('\t', indent)
	body = "{"*(isempty(vals) ? "" : "\n$(tabs)\t$(join(vals, "\n$(tabs)\t"))")*"\n$(tabs)}"
	
	_export(ctx, name)
	return "CBinding.@cenum $(name) $(body)"
end



function _convertAggregate(ctx, decl::Union{CLUnionDecl, CLStructDecl}; indent::Int = 0)
	kind = decl isa CLUnionDecl ? "CBinding.@cunion" : "CBinding.@cstruct"
	name = _convertType(ctx, decl)
	packing = nothing
	
	if getdef(decl) isa CLInvalidFile  # this is an opaque type, don't convert, use _convertType(ctx, decl) instead
		return nothing
	elseif getdef(decl) != decl  # this is a forward decl, so wait for actual decl to convert
		return nothing
	else
		fields = []
		lastAgg = nothing
		for c in children(decl)
			#@info c
			if c isa CLFieldDecl
				fname = _convertName(ctx, c)
				ftype = type(c)
				if ftype isa CLElaborated
					ftype = typedecl(ftype)
					if lastAgg == ftype && !isnothing(last(last(fields)))
						push!(last(last(fields)), fname)
					else
						ftypename = _convertType(ctx, ftype)
						push!(fields, ftypename => fname)
						lastAgg = nothing
					end
				else
					if isbit(c)
						fname = "($(fname):$(bitwidth(c)))"
						ftypename = _convertType(ctx, ftype)
						push!(fields, ftypename => fname)
						lastAgg = nothing
					else
						(augment, atype) = _convertAugmentedType(ctx, ftype)
						if lastAgg == atype && !isnothing(last(last(fields))) && (atype isa CLEnumDecl || atype isa CLUnionDecl || atype isa CLStructDecl)
							push!(last(last(fields)), fname*"::"*augment)
						else
							ftypename = _convertType(ctx, ftype)
							push!(fields, ftypename => fname)
							lastAgg = nothing
						end
					end
				end
			elseif c isa CLEnumDecl || c isa CLUnionDecl || c isa CLStructDecl
				ftype = c isa CLEnumDecl ? _convertEnum(ctx, c, indent = indent+1) : _convertAggregate(ctx, c, indent = indent+1)
				ftype = isnothing(ftype) ? _convertType(ctx, c) : ftype
				push!(fields, ftype => (isempty(spelling(c)) ? [] : nothing))
				lastAgg = c
			elseif c isa CLPackedAttr && isnothing(packing)
				packing = spelling(c)
			else
				error("Unable to convert nested aggregate type at $(Interval(c)) `$(c)`")
			end
		end
		
		fields = map(fields) do (ftype, fname)
			if isnothing(fname) || (fname isa Array && isempty(fname))
				return ftype
			elseif fname isa Array && !isempty(fname)
				return "($(join(fname, ", ")))::$(ftype)"
			else
				return "$(fname)::$(ftype)"
			end
		end
		
		tabs = repeat('\t', indent)
		body = "{"*(isempty(fields) ? "" : "\n$(tabs)\t$(join(fields, "\n$(tabs)\t"))")*"\n$(tabs)}"
		body = isnothing(packing) ? body : "$(body) __$(packing)__"
	end
	
	_export(ctx, name)
	return "$(kind) $(name) $(body)"
end



_convertTypedefType(ctx, decl) = ("", "", decl)
_convertTypedefType(ctx, decl::CLTypedef) = typedecl(decl) isa CLNoDeclFound ? ("", "", decl) : _convertTypedefType(ctx, typedecl(decl))
function _convertTypedefType(ctx, decl::CLConstantArray)
	(o, c, typ) = _convertTypedefType(ctx, element_type(decl))
	return ("(CBinding.@carray ("*o,c*")[$(element_num(decl))])", typ)
end



_convertAugmentedType(ctx, decl) = ("{}", decl)
 _convertAugmentedType(ctx, decl::CLElaborated) = _convertAugmentedType(ctx, typedecl(decl))
function _convertAugmentedType(ctx, decl::CLConstantArray)
	(augment, typ) = _convertAugmentedType(ctx, element_type(decl))
	return ("(CBinding.@carray ($(augment))[$(element_num(decl))])", typ)
end
todo"determine the best way to represent incomplete array types, as pointers, or as empty arrays"
function _convertAugmentedType(ctx, decl::CLIncompleteArray)
	(augment, typ) = _convertAugmentedType(ctx, element_type(decl))
	augment = augment == "{}" ? "" : augment
	return ("Base.Ptr{$(augment)}", typ)
end
function _convertAugmentedType(ctx, decl::CLPointer)
	(augment, typ) = _convertAugmentedType(ctx, pointee_type(decl))
	augment = augment == "{}" ? "" : augment
	return ("Base.Ptr{$(augment)}", typ)
end



_convertType(ctx, typ::CLChar_S) = "Base.Cchar"
_convertType(ctx, typ::CLChar_U) = "Base.Cuchar"
_convertType(ctx, typ::CLSChar) = "Base.Cchar"
_convertType(ctx, typ::CLUChar) = "Base.Cuchar"

_convertType(ctx, typ::CLShort) = "Base.Cshort"
_convertType(ctx, typ::CLInt) = "Base.Cint"
_convertType(ctx, typ::CLLong) = "Base.Clong"
_convertType(ctx, typ::CLLongLong) = "Base.Clonglong"

_convertType(ctx, typ::CLUShort) = "Base.Cushort"
_convertType(ctx, typ::CLUInt) = "Base.Cuint"
_convertType(ctx, typ::CLULong) = "Base.Culong"
_convertType(ctx, typ::CLULongLong) = "Base.Culonglong"

_convertType(ctx, typ::CLFloat) = "Base.Cfloat"
_convertType(ctx, typ::CLDouble) = "Base.Cdouble"
_convertType(ctx, typ::CLLongDouble) = "CBinding.Clongdouble"
_convertType(ctx, typ::CLComplex) = "Base.Complex{$(_convertType(ctx, element_type(typ)))}"

_convertType(ctx, typ::CLBool) = "Base.Cbool"
_convertType(ctx, typ::CLVoid) = "Base.Cvoid"
_convertType(ctx, typ::CLFirstBuiltin) = "Base.Cvoid"   # TODO:  this decision needs to be evaluated!
_convertType(ctx, typ::CLVector) = error("$(typ) $(element_num(typ))")
function _convertType(ctx, typ::Union{CLTypedef, CLTypedefDecl})
	name = typ isa CLTypedefDecl || typedecl(typ) isa CLNoDeclFound ? _convertName(ctx, typ) : _convertType(ctx, typedecl(typ))
	return haskey(ctx.typedefs, name) ? ctx.typedefs[name] : name
end
_convertType(ctx, typ::CLPointer) = "Base.Ptr{$(_convertType(ctx, pointee_type(typ)))}"
_convertType(ctx, typ::CLConstantArray) = "(CBinding.@carray ($(_convertType(ctx, element_type(typ))))[$(element_num(typ))])"
_convertType(ctx, typ::CLIncompleteArray) = "Base.Ptr{$(_convertType(ctx, element_type(typ)))}"
_convertType(ctx, typ::CLElaborated) = _convertType(ctx, typedecl(typ))
_convertType(ctx, typ::Union{CLEnumDecl, CLUnionDecl, CLStructDecl}) = _convertName(ctx, typ)

Clang.calling_conv(t::CLType) = Clang.calling_conv(t.type)
Clang.argnum(t::CLType) = argnum(t.type)
Clang.argtype(t::CLType, i) = CLType(argtype(t.type, UInt(i)))
Clang.result_type(t::CLType) = CLType(result_type(t.type))
function _convertType(ctx, typ::CLUnexposed)
	num = argnum(typ)
	if num >= 0   # this is a function signature
		ret = _convertType(ctx, result_type(typ))
		args = map(i -> _convertType(ctx, argtype(typ, i-1)), 1:num)
		isvariadic(typ) && push!(args, "Base.Vararg")
		return "CBinding.Cfunction{$(ret), Base.Tuple{$(join(args, ", "))}}"
	else
		error("A non-function `unexposed` type is not yet supported")
	end
end


_convertName(ctx, decl::CLCursor) = _convertName(ctx, spelling(decl))
_convertName(ctx, name::String) = (name in Clang.RESERVED_WORDS) ? name*"_" : name

