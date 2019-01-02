autocmd!

"VUNDLE
set noshowmode
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'nvie/vim-togglemouse'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'airblade/vim-gitgutter'
Plugin 'terryma/vim-multiple-cursors'

Plugin 'tpope/vim-rails'

set rtp+=/usr/local/opt/fzf
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Este deberia ser el ultimo plugin en cargarse
Plugin 'ryanoasis/vim-devicons'

Plugin 'NLKNguyen/papercolor-theme'
Plugin 'junegunn/seoul256.vim'
Bundle 'morhetz/gruvbox'

call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEAUTIFICATION:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0
let g:airline_theme = 'minimalist'
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\ 
"set term=xterm-256color

set termencoding=utf-8
set guifont=Menlo\ for\ Powerline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CAONFIGURATION:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType java set tags=~/.ctags/gcaba.tags
autocmd FileType php set tags=~/.ctags/gcaba_php.tags

set list
set listchars=eol:¬,tab:▸\ ,trail:·,nbsp:·
"let &colorcolumn="80,120"

"delete trailing
nnoremap <silent> <F6> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

function! BackSpaceDiego()
    if empty(getline('.'))
        " Si es una linea vacia, la borro y me posiciono al final de la de
        " arriba
        execute 'normal ddk$'
    else
        "Si no es una linea vacia y estoy en la primera posicion, voy arriba y
        "unifico las lineas (y borro el caracter que queda en el medio.
        let col = col('.') - 1
        if !col
            execute 'normal kJx'

        "Si no es una linea vacia y tampoco estoy en la primera posicion de la
        "linea... backspace normal
        else
            execute 'normal X'
        endif
    endif
endfunction

nnoremap <s-bs> o<esc>
nnoremap <silent> <bs> :call BackSpaceDiego()<cr>

set noswapfile
set pastetoggle=<F2>
set nowrap "dont like wrapping
set mouse=a

" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cursorline
set cmdheight=1
set switchbuf=useopen
set showtabline=2
set winwidth=79
" This makes RVM work inside Vim. I have no idea why.
set shell=bash
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
let mapleader=","
" Fix slow O inserts
:set timeout timeoutlen=1000 ttimeoutlen=100

" wrap :cnext/:cprevious and :lnext/:lprevious
function! WrapCommand(direction, prefix)
    if a:direction == "up"
        try
            execute a:prefix . "previous"
        catch /^Vim\%((\a\+)\)\=:E553/
            execute a:prefix . "last"
        catch /^Vim\%((\a\+)\)\=:E\%(776\|42\):/
        endtry
    elseif a:direction == "down"
        try
            execute a:prefix . "next"
        catch /^Vim\%((\a\+)\)\=:E553/
            execute a:prefix . "first"
        catch /^Vim\%((\a\+)\)\=:E\%(776\|42\):/
        endtry
    endif
endfunction

" <Home> and <End> go up and down the quickfix list and wrap around
nnoremap <silent> {{ :call WrapCommand('up', 'c')<CR>
nnoremap <silent> }}  :call WrapCommand('down', 'c')<CR>

" <C-Home> and <C-End> go up and down the location list and wrap around
nnoremap <silent> [[ :call WrapCommand('up', 'l')<CR>
nnoremap <silent> ]]  :call WrapCommand('down', 'l')<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set t_Co=256 " 256 colors
:set background=dark
":color gruvbox
":colorscheme PaperColor
let g:seoul256_background = 256
colo seoul256
"let g:gruvbox_contrast_dark="hard"
"hi Normal ctermbg=none

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <silent> <leader><cr> :nohlsearch\|let @/=""<cr>
endfunction
call MapCR()
nnoremap <leader><leader> <c-^>
nnoremap <leader>. :only<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :tabnew\|:edit %%<cr>

"""""""""""""""""""""
" TAB MAPS:
""""""""""""""""""""""
noremap <leader>B :tabnew<cr>
noremap <leader>n :tabprevious<cr>
noremap <leader>m :tabnext<cr>

"""""""""""""""""""""
" SPLIT MAPS:
""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>S :split\|:edit %%<cr>
map <leader>s :vsplit\|:edit %%<cr>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l
map <c-s> <c-w><s-t>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY:
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
autocmd FileType java inoremap <s-tab> <c-x><c-u>
autocmd FileType cs inoremap <s-tab> <c-x><c-o>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fijarse si existe el directorio antes de grabar... si no preguntar para "
" crear                                                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrc-auto-mkdir
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)

    function! s:auto_mkdir(dir, force)
        if !isdirectory(a:dir) && (a:force || input("'" . a:dir . "' no existe. Crear [y/N]") =~? '^y\%[es]$')
            call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
    endfunction
augroup END

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>r :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DUPLICATE CURRENT FILE:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! DuplicateFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        redraw!
    endif
endfunction
map <leader>d :call DuplicateFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>t :w\|:!./%<cr>

set foldmethod=manual
set nofoldenable

command! ClearQuickfixList cexpr []
nmap <leader>ff :ClearQuickfixList<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LINE NUMBERS:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set relativenumber
set number
function! ToggleNumbersOn()
    set relativenumber!
    set number
endfunction
function! ToggleRelativeOn()
    set number!
    set relativenumber
    set number
endfunction
autocmd FocusLost   * if &buftype != 'terminal' | call ToggleNumbersOn() | endif
autocmd FocusGained * if &buftype != 'terminal' | call ToggleNumbersOn() | endif
autocmd InsertEnter * if &buftype != 'terminal' | call ToggleNumbersOn() | endif
autocmd InsertLeave * if &buftype != 'terminal' | call ToggleNumbersOn() | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EASY EDITING VIMRC:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>ve :e $MYVIMRC<CR>
nnoremap <silent> <leader>vs :w\|so $MYVIMRC<CR>
nnoremap <silent> <leader>l :w\|source %<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remember cursor position between vim sessions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   execute "normal! g'\"" |
    \ endif
autocmd BufRead * normal zz
"^ center buffer around cursor when opening file

"""""""
" GIT "
"""""""
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gh :!tig %<cr>
nnoremap <leader>gv :!tig<cr>
nnoremap <leader>gp :Git push<cr>
nnoremap <leader>gl :Gpull<cr>

""""""""""""
" NERDTree "
""""""""""""
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-t> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
"quiero seguir usando netrw para explora directorios
let g:NERDTreeHijackNetrw=0

function! NERDTreeHighlightFile(extension, fg, bg)
    exec 'autocmd FileType nerdtree highlight '.a:extension.' ctermbg='.a:bg.' ctermfg='.a:fg
    exec 'autocmd FileType nerdtree syn match '.a:extension.' #^\s\+.*'.a:extension.'$#'
endfunction

"""""""""
" netrw "
"""""""""
" Toggle Vexplore with ctr-n
function! ToggleVExplorer()
    if exists("t:expl_buf_num")
        let expl_win_num = bufwinnr(t:expl_buf_num)
        if expl_win_num != -1
            let cur_win_nr = winnr()
            "exec expl_win_nr . 'wincmd w'
            close
            exec cur_win_nr . 'wincmd w'
            unlet t:expl_buf_num
        else
            unlet t:expl_buf_num
        endif
    else
        exec '1wincmd w'
        Vexplore
        let t:expl_buf_num = bufnr("%")
    endif
endfunction
map <silent> <c-n> :call ToggleVExplorer()<cr>
"Hit enter in the file browser to open the selected file with vsplit to the
"right of the browser
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"default to tree mode
let g:netrw_liststyle = 0
"change directory to the current buffer when opening files
set autochdir

""""""""""""""""""""
" multiple-cursors "
""""""""""""""""""""
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

"""""""""""""""""
" Indent Guides "
"""""""""""""""""
let g:indent_guides_guide_size = 1

"""""""
" FZF "
"""""""
function! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfunction

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

nnoremap <C-p> :call FzfOmniFiles()<CR>

command! -bang -nargs=* Find call fzf#vim#grep('rg --ignore-file tags --column --line-number --no-heading --fixed-strings --ignore-case  --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).' '.s:find_git_root(), 1, <bang>0)
nnoremap <leader>F :execute "Find " . shellescape(expand("<cWORD>"))<cr>
nnoremap \ :Find<space>

nnoremap ; :Buffers<cr>
nnoremap ' :Tags<cr>

