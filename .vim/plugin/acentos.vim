let g:con_acentos = 0

function! MapAcentos()
    if g:con_acentos == 0
        inoremap nn ñ
        inoremap aa á
        inoremap ee é
        inoremap ii í
        inoremap oo ó
        inoremap uu ú
        let g:con_acentos = 1
    else
        iunmap nn
        iunmap aa
        iunmap ee
        iunmap ii
        iunmap oo
        iunmap uu
        let g:con_acentos = 0
    endif
endfunction

inoremap <c-f> <esc>:call MapAcentos()<cr>a
