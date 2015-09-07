" Vim syntax file
" Language:     Asana Comment
" Maintainer:   Diego Balseiro
" URL:          http://www.syntagma.com.ar/asana.vim
" Last Change:  2015 Sep 1
" This shamelessly borrows from the 'java.vim' syntax file.
" Quit when a syntax file was already loaded.

if exists("b:current_syntax")
  finish
endif

syn match   asanaActivity  "^# \* .*$"
syn match   asanaComment   "^# > .*$"
syn match   asanaAttach    "^# \* attached .*$"
syn keyword asanaConditional  attach

" All done! Kick in the highlighting.
hi def link asanaActivity       Error
hi def link asanaComment        String
hi def link asanaAttach         Keyword

" vim: ts=8
