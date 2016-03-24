let s:spc = g:airline_symbols.space

function! airline#extensions#pandoc#word_count()
	if mode() == "s"
		    return 0
	    else
		        let s:old_status = v:statusmsg
			    let position = getpos(".")
			        let s:word_count = 0
				    exe ":silent normal g\<c-g>"
				        let stat = v:statusmsg
					    let s:word_count = 0
					        if stat != '--No lines in buffer--'
							        let s:word_count = str2nr(split(v:statusmsg)[11])
								        let v:statusmsg = s:old_status
									    end
									        call setpos('.', position)
										    return s:word_count 
									    end
								    endfunction

								    function! airline#extensions#pandoc#apply(...)
									    if &ft == "markdown"
										        let w:airline_section_x = "%{airline#extensions#pandoc#word_count()} Words"
										endif
									    if &ft == "pandoc"
										        let w:airline_section_x = "%{airline#extensions#pandoc#word_count()} Words"
										endif
									endfunction

									function! airline#extensions#pandoc#init(ext)
										call a:ext.add_statusline_func('airline#extensions#pandoc#apply')
									endfunction
