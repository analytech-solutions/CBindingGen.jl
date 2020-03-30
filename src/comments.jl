

# TODO: this should convert the parsed XML into a better doc string
function convert_comment(cursor::LibClang.CXCursor, jlname::String)
	io = IOBuffer()
	
	comment = _string(LibClang.clang_Cursor_getRawCommentText, cursor)
	if !isnothing(comment)
		for (ind, line) in enumerate(split(comment, '\n'))
			line = replace(line, r"^\s*/?\*+/?\s*" => "")
			ind == 1 && isempty(line) && continue
			println(io, line)
		end
	end
	
	# TODO: need to generate a real URL encoding of the location for "C Reference"
	expr = String(take!(io))
	ref  = "[C Reference]($(CodeLocation(cursor)))"
	expr = isempty(expr) ? ref : "$(rstrip(expr))\n\n$(ref)"
	expr = isempty(jlname) ? "" : replace(expr, '\\' => "\\\\")
	
	return jlname => expr
end


merge_comment!(comments::Dict{String, String}, comment::Pair{String, String}) = isempty(comment.first) || (comments[comment.first] = haskey(comments, comment.first) ? join((comments[comment.first], comment.second), "\n\n") : comment.second)
merge_comments!(comments::Dict{String, String}, more::Dict{String, String}) = foreach(((k, v),) -> merge_comment!(comments, k => v), collect(more))



