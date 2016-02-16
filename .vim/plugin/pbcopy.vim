let g:vim_pbcopy_cmd = "pbcopy"

"COPY
vnoremap <silent> cy :<C-U>call <SID>copyVisualSelection(visualmode(), 1)<CR>
nnoremap <silent> cy :set opfunc=<SID>copyVisualSelection<CR>g@
nmap <silent> cyy ^cy$

"PASTE
nmap <f3> :set paste<cr>:r !pbpaste<cr>:set nopaste<cr>$
imap <f3> <esc>:set paste<cr>:r !pbpaste<cr>:set nopaste<cr>A

function! s:getVisualSelection()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][:col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    return lines
endfunction

function! s:sendTextToPbCopy(escapedText)
    execute "silent !echo -n " . a:escapedText . " | " . g:vim_pbcopy_cmd
    redraw! " Fix up the screen
    return 0
endfunction

function! s:getShellEscapedLines(listOfLines)
    if exists("g:vim_pbcopy_escape_backslashes") && g:vim_pbcopy_escape_backslashes
        " Global override is set and is truthy
        return shellescape(escape(join(a:listOfLines, "\n"), '\'), 1)
    elseif exists("g:vim_pbcopy_escape_backslashes")
        " Global override is set and is falsey
        return shellescape(join(a:listOfLines, "\n"), 1)
    endif
    return shellescape(join(a:listOfLines, "\n"), 1)
endfunction

function! s:copyVisualSelection(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@

    if a:0  " Invoked from Visual mode, use '< and '> marks.
      silent exe "normal! `<" . a:type . "`>y"
    elseif a:type == 'line'
      silent exe "normal! '[V']y"
    elseif a:type == 'block'
      silent exe "normal! `[\<C-V>`]y"
    else
      silent exe "normal! `[v`]y"
    endif

    let lines = split(@@, "\n")
    let escapedLines = s:getShellEscapedLines(lines)
    let error =  s:sendTextToPbCopy(escapedLines)

    " Reset the selection and register contents
    let &selection = sel_save
    " let @@ = reg_save
endfunction

