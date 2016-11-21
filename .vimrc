autocmd!

au bufreadpost,filereadpost *.drl set ft=drools
au bufreadpost,filereadpost asana_comment.txt set ft=asana


"VUNDLE
set noshowmode
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'L9'
Plugin 'wincent/Command-T'
Plugin 'nvie/vim-togglemouse'
Plugin 'ivalkeen/vim-simpledb'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
"Plugin 'OmniSharp/omnisharp-vim'
"Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-repeat'
Plugin 'jeetsukumaran/vim-buffergator'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
"Plugin 'tpope/vim-dispatch'
"Plugin 'SirVer/ultisnips'
"" Optional:
Plugin 'honza/vim-snippets'
" All of your Plugins must be added before the following line
"Bundle 'altercation/vim-colors-solarized'
Bundle 'morhetz/gruvbox'

call vundle#end()            " required
filetype plugin indent on    " required

let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\ 
"set term=xterm-256color
set termencoding=utf-8
set guifont=Menlo\ for\ Powerline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType java set tags=~/.ctags/gcaba.tags
autocmd FileType php set tags=~/.ctags/gcaba_php.tags

autocmd FileType java,php,js autocmd BufWritePre <buffer> %s/\s\+$//e

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



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set t_Co=256 " 256 colors
:set background=dark
:color gruvbox
let g:gruvbox_contrast_dark="medium"
hi Normal ctermbg=none

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
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
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :tabnew\|:edit %%<cr>

"""""""""""""""""""""
" TAB MAPS
""""""""""""""""""""""
noremap <leader>B :tabnew<cr>
noremap <leader>n :tabprevious<cr>
noremap <leader>m :tabnext<cr>

"""""""""""""""""""""
" SPLIT MAPS
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
" MULTIPURPOSE TAB KEYg
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
""""""""""""
" UltiSnip "
""""""""""""
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<c-tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
imap <C-Z> <Plug>snipMateNextOrTrigger
smap <C-Z> <Plug>snipMateNextOrTrigger

" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
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
" DUPLICATE CURRENT FILE
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
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>o :w\|:!./%<cr>

set foldmethod=manual
set nofoldenable

command! ClearQuickfixList cexpr []
nmap <leader>ff :ClearQuickfixList<cr>
""""""""""""""""
" LINE NUMBERS "
""""""""""""""""
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
autocmd FocusLost * call ToggleNumbersOn()
autocmd FocusGained * call ToggleRelativeOn()
autocmd InsertEnter * call ToggleNumbersOn()
autocmd InsertLeave * call ToggleRelativeOn()

"""""""""""""""""
" ASANA PROJECT "
"""""""""""""""""
map <leader>a :wa\|:lcd $ASANA_PATH\|:make clean asana<cr>

""""""""""""""""""""""
" EASY EDITING VIMRC "
""""""""""""""""""""""
nnoremap <silent> <leader>ve :e $MYVIMRC<CR>
nnoremap <silent> <leader>vs :w\|so $MYVIMRC<CR>
nnoremap <silent> <leader>l :w\|source %<cr>

"""""""""
" ECLIM "
"""""""""
map <F1> :ProjectTreeToggle<cr>
map <leader><F1> :ProjectsTree<cr>
nnoremap <leader>js :JavaSearch -s workspace -x declarations<cr>
nnoremap <leader>ja :JavaSearch -s workspace -x references<cr>
nnoremap <leader>jc :JavaCorrect<cr>
nnoremap <leader>jo :JavaImportOrganize<cr>
nnoremap <leader>jg :JavaGetSet<cr>
nnoremap <leader>jb :w\|Mvn -f ~/git/gcaba-io/source/back-end -Dmaven.test.skip=true clean install<cr>



function! CompilePAD()
    Mvn -f ~/git/padhome/pad/pad_parent -Dmaven.test.skip=true clean install -Pdevelopment-local
endfunction
command! MakePAD :call CompilePAD()

function! CompileJBPM()
    Mvn -f ~/git/padhome/pinkflow-base-project/pinkflow_parent -Dmaven.test.skip=true clean install -Pdevelopment-local
endfunction
command! MakeJBPM :call CompileJBPM()

function! CompilePADC()
    Mvn -f ~/git/padcirculohome/pad-circulo -Dmaven.test.skip=true clean install -Pdevelopment
endfunction
command! MakePADC :call CompilePADC()

function! CompileJBPMC()
    Mvn -f ~/git/padcirculohome/pinkflow-circulo -Dmaven.test.skip=true -Dmaven.color=false clean install -Pdevelopment
endfunction

command! MakeJBPMC :call CompileJBPMC()

command! MakeMBF :Dispatch ssh dbalseiro@localhost -p 8022 'cd /cygdrive/c/workspace/MercedesBenz/git/mb-circulo-mbfonline/PAD; ./build.bat'

nnoremap <leader>jds :JavaDebugStart localhost 8787<cr>
nnoremap <F9> :JavaDebugBreakpointToggle<cr>
nnoremap <leader>jdb :JavaDebugBreakpointRemove!<cr>

nnoremap <F7> :JavaDebugStep over<cr>
nnoremap <F8> :JavaDebugStep into<cr>
nnoremap <S-F8> :JavaDebugStep return<cr>

nnoremap <F5> :JavaDebugThreadResumeAll<cr>

nnoremap <leader>pp :ProjectProblems<cr>
nnoremap <leader>pr :ProjectRefreshAll<cr>
nnoremap <leader>pt :ProjectTab 
 
let g:EclimMvnCompilerAdditionalErrorFormat='\[ERROR]\ %f:[%l\\,%v]\ %m,'
let g:EclimMakeLCD=0

function! Standalone()
    tabnext
    edit ~/jboss-as-7.1.1.Final/standalone/configuration/standalone-io.xml
endfunction
map <F10> :call Standalone()<cr>

function! StandalonePAD()
    tabnext
    edit ~/jboss-as-7.1.1.Final/standalone/configuration/standalone-pad.xml
endfunction
map <F9> :call StandalonePAD()<cr>
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
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" map <C-n> :NERDTreeToggle<CR>
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

"""""""""""""
" Command-T "
"""""""""""""
let g:CommandTWildIgnore=&wildignore . ",**/target/*"
let g:CommandTEncoding="UTF-8"

""""""""""
" Ctrl-P "
""""""""""
set runtimepath^=~/.vim/bundle/ctrlp.vim

let g:ctrlp_map = '<c-s-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['pom.xml']


let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]target',
\}
""""""
" Ag "
""""""
let g:ag_working_path_mode="r"
nnoremap <leader>F :execute "Ag " . shellescape(expand("<cWORD>"))<cr>:cw<cr>
nnoremap \ :Ag<space>

"""""""""""""
" Syntastic "
"""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_php_checkers = ['php']
au BufWriteCmd *.php write || :SyntasticCheck

"""""""""
" DBExt "
"""""""""
let g:dbext_default_profile_gcba = 'type=PGSQL:user=inscripcion_user:host=localhost:dbname=ciclolectivo2016'
let g:dbext_default_profile_pad = 'type=ORA:srvname=localhost:user=padstage:passwd=padstage'

let g:dbext_default_profile = 'pad'
augroup gcba
    au!
    autocmd BufRead */gcaba_io/* DBSetOption profile=gcba
augroup end


"""""""""""""""
" Buffergator "
"""""""""""""""
let g:buffergator_suppress_keymaps = 1
nnoremap <leader>b :BuffergatorOpen<cr>

"""""""""""""
" OmniSharp "
"""""""""""""
let g:OmniSharp_selector_ui = 'ctrlp'  " Use ctrlp.vim
"Set the type lookup function to use the preview window instead of the status line
"let g:OmniSharp_typeLookupInPreview = 1

"Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 1

"Showmatch significantly slows down omnicomplete
"when the first match contains parentheses.
set noshowmatch

"Super tab settings - uncomment the next 4 lines
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
"let g:SuperTabClosePreviewOnPopupClose = 1

"don't autoselect first item in omnicomplete, show if only one item (for preview)
"remove preview if you don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview
" Fetch full documentation during omnicomplete requests.
" There is a performance penalty with this (especially on Mono)
" By default, only Type/Method signatures are fetched. Full documentation can still be fetched when
" you need it with the :OmniSharpDocumentation command.
" let g:omnicomplete_fetch_documentation=1

"Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
"You might also want to look at the echodoc plugin
set splitbelow

" Get Code Issues and syntax errors
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
" If you are using the omnisharp-roslyn backend, use the following
" let g:syntastic_cs_checkers = ['code_checker']
augroup omnisharp_commands
    autocmd!

    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

    " Synchronous build (blocks Vim)
    "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
    " Builds can also run asynchronously with vim-dispatch installed
    autocmd FileType cs nnoremap <leader>B :wa!<cr>:OmniSharpBuildAsync<cr>
    " automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    "show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    "The following commands are contextual, based on the current cursor position.

    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    "finds members in the current buffer
    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
    " cursor can be anywhere on the line containing an issue
    autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    "navigate up by method/property/field
    autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    "navigate down by method/property/field
    autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

augroup END


" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=500
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
nnoremap <leader>nm :OmniSharpRename<cr>
nnoremap <F2> :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>

" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden


""""""""""""""""""
"Build All gcaba "
""""""""""""""""""
function! BuildAllGCABA()
    execute ":ProjectBuild autorizacion-ws"
    execute ":ProjectBuild back-end"
    execute ":ProjectBuild business-entities"
    execute ":ProjectBuild business-model"
    execute ":ProjectBuild rule-engine"
    execute ":ProjectBuild services-api"
    execute ":ProjectRefreshAll"
endfunction
map <leader>ba :call BuildAllGCABA()<cr>


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
