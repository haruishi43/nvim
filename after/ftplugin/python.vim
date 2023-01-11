" setlocal autoindent
" :h ft-python-ident

" Indent is weird for both tree-sitter and neovim
" Let's fix this by forcing my formatting

if !exists('g:python_indent')
  let g:python_indent = {}
endif
let g:python_indent.closed_paren_align_last_line = v:false
let g:python_indent.continue = 'shiftwidth()'
let g:python_indent.open_paren = 'shiftwidth()'
let g:python_indent.nested_paren = 'shiftwidth()'

