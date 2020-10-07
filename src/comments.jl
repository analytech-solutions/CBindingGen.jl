

function convert_comment(cursor::LibClang.CXCursor, jlname::String)
	cxcomment = LibClang.clang_Cursor_getParsedComment(cursor)
	kind = LibClang.clang_Comment_getKind(cxcomment)
	
	comment = kind == LibClang.CXComment_FullComment ? Markdown.MD(cxcomment) : nothing
	
	return jlname => Comment(comment, [CodeLocation(cursor)])
end


merge_comments!(comments::Dict{String, Comment}, more::Dict{String, Comment}) = foreach(((k, v),) -> merge_comment!(comments, k => v), collect(more))
function merge_comment!(comments::Dict{String, Comment}, comment::Pair{String, Comment})
	(sym, cmt) = comment
	
	isempty(sym) && return
	if haskey(comments, sym)
		md = if isnothing(comments[sym].md)
			isnothing(cmt.md) ? nothing : cmt.md
		else
			isnothing(cmt.md) ? comments[sym].md : Markdown.MD([comments[sym].md.content..., Markdown.HorizontalRule(), cmt.md.content...,])
		end
		comments[sym] = Comment(md, [comments[sym].locs..., cmt.locs...])
	else
		comments[sym] = cmt
	end
end


function Markdown.MD(cxcomment::LibClang.CXComment)
	hasDetails = false
	hasParams  = false
	hasReturns = false
	
	contents = []
	for ind in 1:LibClang.clang_Comment_getNumChildren(cxcomment)
		child = LibClang.clang_Comment_getChild(cxcomment, ind-1)
		kind = LibClang.clang_Comment_getKind(child)
		
		if !hasDetails && !isempty(contents)
			hasDetails = true
			push!(contents, Markdown.Header("Details", 2))
		end
		
		if kind == LibClang.CXComment_Paragraph
			Bool(LibClang.clang_Comment_isWhitespace(child)) || push!(contents, Markdown.Paragraph(child))
		elseif kind == LibClang.CXComment_BlockCommand
			para = LibClang.clang_BlockCommandComment_getParagraph(child)
			para = Markdown.Paragraph(para)
			
			num = LibClang.clang_BlockCommandComment_getNumArgs(child)
			cmd = _string(LibClang.clang_BlockCommandComment_getCommandName, child)
			if cmd == "brief" || cmd == "par" || cmd == "paragraph"
				push!(contents, para)
			elseif cmd == "note" || cmd == "warning" || cmd == "deprecated"
				para = Markdown.Paragraph(["$(uppercase(cmd)):", para.content...])
				push!(contents, para)
			elseif cmd == "sa" || cmd == "see"
				para = isempty(para.content) ? para : Markdown.Paragraph("See also: [`$(strip(first(para.content)))`](@ref)")
				push!(contents, para)
			elseif cmd == "returns" || cmd == "return"
				if !hasReturns
					hasReturns = true
					
					hdr = Markdown.Header("Returns", 2)
					if !isempty(contents) && contents[end] isa Markdown.Header
						contents[end] = hdr
					else
						push!(contents, hdr)
					end
				end
				
				push!(contents, para)
			elseif cmd == "li"
				if !isempty(contents) && contents[end] isa Markdown.List
					push!(contents[end].items, para)
				else
					push!(contents, Markdown.List(para))
				end
			else
				@warn "Unhandled block-command comment: $(cmd)"
			end
		elseif kind == LibClang.CXComment_ParamCommand
			if !hasParams
				hasParams = true
				
				hdr = Markdown.Header("Parameters", 2)
				if !isempty(contents) && contents[end] isa Markdown.Header
					contents[end] = hdr
				else
					push!(contents, hdr)
				end
			end
			
			_addParamCommand(contents, child)
		elseif kind == LibClang.CXComment_VerbatimBlockCommand
			push!(contents, Markdown.Code(child))
		elseif kind == LibClang.CXComment_VerbatimLine
			text = _string(LibClang.clang_VerbatimLineComment_getText, child)
			push!(contents, Markdown.Paragraph(text))
		else
			error("Unhandled document child: $(kind)")
		end
	end
	
	if length(contents) > 1 && contents[end] isa Markdown.Header
		contents = contents[1:end-1]
	end
	
	return Markdown.MD(contents)
end


function Markdown.Paragraph(cxcomment::LibClang.CXComment)
	contents = []
	
	for ind in 1:LibClang.clang_Comment_getNumChildren(cxcomment)
		child = LibClang.clang_Comment_getChild(cxcomment, ind-1)
		kind = LibClang.clang_Comment_getKind(child)
		
		if kind == LibClang.CXComment_Text
			text = _string(LibClang.clang_TextComment_getText, child)
			push!(contents, text)
		elseif kind == LibClang.CXComment_InlineCommand
			_addInlineCommand(contents, child)
		elseif kind == LibClang.CXComment_HTMLStartTag || kind == LibClang.CXComment_HTMLEndTag
			# TODO: handle HTML stuff...
		else
			error("Unhandled paragraph child: $(kind)")
		end
	end
	
	return Markdown.Paragraph(contents)
end


function Markdown.Code(cxcomment::LibClang.CXComment)
	lines = []
	
	for ind in 1:LibClang.clang_Comment_getNumChildren(cxcomment)
		child = LibClang.clang_Comment_getChild(cxcomment, ind-1)
		kind = LibClang.clang_Comment_getKind(child)
		
		if kind == LibClang.CXComment_VerbatimBlockLine
			line = _string(LibClang.clang_VerbatimBlockLineComment_getText, child)
			
			# a line with newlines is probably incorrectly parsed, so only keep before a newline
			push!(lines, first(split(line, '\n', limit=2)))
		else
			error("Unhandled code-block child: $(kind)")
		end
	end
	
	return Markdown.Code(join(lines, '\n'))
end


function _addInlineCommand(contents, cxcomment)
	num = LibClang.clang_InlineCommandComment_getNumArgs(cxcomment)
	cmd = _string(LibClang.clang_InlineCommandComment_getCommandName, cxcomment)
	
	text = _string(LibClang.clang_InlineCommandComment_getArgText, cxcomment, 0)
	kind = LibClang.clang_InlineCommandComment_getRenderKind(cxcomment)
	if kind == LibClang.CXCommentInlineCommandRenderKind_Bold
		push!(contents, Markdown.Bold(text))
	elseif kind == LibClang.CXCommentInlineCommandRenderKind_Emphasized
		push!(contents, Markdown.Italic(text))
	elseif kind == LibClang.CXCommentInlineCommandRenderKind_Monospaced
		push!(contents, Markdown.Code(text))  # TODO: maybe need Code(language, text)
	else
		push!(contents, text)
	end
end


function _addParamCommand(contents, cxcomment)
	num = LibClang.clang_Comment_getNumChildren(cxcomment)
	num == 1 || error("Incorrect number of parameter-command comment children")
	
	para = LibClang.clang_Comment_getChild(cxcomment, 0)
	LibClang.clang_Comment_getKind(para) == LibClang.CXComment_Paragraph || error("Expected a parameter-command comment paragraph")
	
	param = _string(LibClang.clang_ParamCommandComment_getParamName, cxcomment)
	param = Markdown.Paragraph([Markdown.Code(param), ":", Markdown.Paragraph(para).content...,])
	
	if !isempty(contents) && contents[end] isa Markdown.List
		push!(contents[end].items, param)
	else
		push!(contents, Markdown.List(param))
	end
end


