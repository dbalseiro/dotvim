nnoremap <leader>f :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>f :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
    let temp=@@
    if a:type ==# 'v'
        execute "normal `<v`>y"
    elseif a:type ==# 'char'
        execute "normal `[v`]y"
    else
        return
    endif

    execute "Ag " . shellescape(@@)
    copen

    let @@=temp
endfunction
