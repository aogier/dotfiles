set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin on

let g:ale_completion_enabled = 0
let g:ale_disable_lsp = 1

let g:ale_virtualtext_cursor = 'current'

call plug#begin()

Plug 'scrooloose/nerdtree'

Plug 'rust-lang/rust.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'
Plug 'vim-python/python-syntax'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

filetype plugin indent on

syntax on
set bg=dark
if $TERM == 'alacritty'
    set ttymouse=sgr
endif
set mouse=a

vnoremap <F9> :sort<CR>
vnoremap <S-F9> :sort n<CR>

let NERDTreeIgnore=['\.pyc$', '\~$', '^\.git$'] "ignore files in NERDTree
let NERDTreeShowHidden=1

nnoremap <F6> :NERDTreeToggleVCS<CR>
inoremap <F6> <Esc> :NERDTreeToggleVCS<CR>

nnoremap <F7> :nohlsearch<CR>
inoremap <F7> <Esc> :nohlsearch<CR>

nnoremap <F12> :ALEGoToDefinition<CR>
inoremap <F12> <Esc> :ALEGoToDefinition<CR>

"always show powerline
set laststatus=2

" sane text files
set fileformat=unix
set encoding=utf-8
set fileencoding=utf-8

" copy, cut and paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

" save
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" quit
nmap <C-q> :q<CR>
imap <C-q> <Esc> :q<CR>

set nu
highlight LineNr ctermfg=237

"I don't like swap files
set noswapfile

nnoremap <expr> <LeftMouse> &ma?"<LeftMouse>i":"<LeftMouse>"

let g:airline_powerline_fonts = 1

let g:poetv_auto_activate = 1

behave mswin
set keymodel=startsel
set selection=inclusive

let g:ale_linters_ignore = {
    \   'yaml': ['yamllint'],
    \}
let g:ale_fixers = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
	\	'python': ['autoflake', 'isort', 'remove_trailing_lines', 'trim_whitespace', 'black'],
    \   'typescript': ['prettier', 'remove_trailing_lines', 'trim_whitespace'],
    \}

let g:ale_python_autoflake_options = '--remove-all-unused-imports'
let g:ale_fix_on_save = 1
let g:ale_markdown_mdl_options = '-r \~MD033,\~MD046'
let g:ale_python_flake8_options = '--max-line-length 88'

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

" display tab as 4 spaces
set ts=4 sts=4 sw=4 expandtab

augroup local_setup

    autocmd!

    " code style
    autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    " nowrap for helm values files
    autocmd BufRead,BufNewFile values*.yaml setlocal nowrap

    " autoclose when only nerdtree is open
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
        \ && b:NERDTree.isTabTree()) | q | endif

augroup end

let g:python_highlight_all = 1

function s:ForbidReplace()
    if v:insertmode isnot# 'i'
        call feedkeys("\<Insert>", "n")
    endif
endfunction
augroup ForbidReplaceMode
    autocmd!
    autocmd InsertEnter  * call s:ForbidReplace()
    autocmd InsertChange * call s:ForbidReplace()
augroup END

set autoread
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
            \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

"set nosmartindent
"set nocindent
"filetype plugin indent on
set cinkeys-=0#
set cinkeys-=:
set indentkeys-=0#
set indentkeys-=<:>
"autocmd FileType * set nocindent
autocmd FileType * set cinkeys-=0#
autocmd FileType * set indentkeys-=0#
autocmd FileType * set cinkeys-=:
autocmd FileType * set indentkeys-=<:>

let g:rustfmt_autosave = 1
"let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

" basic coc

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Ale


nmap <silent>rr <Plug>(coc-rename)

" see also lunaperche slate sorbet
colorscheme habamax
highlight Normal ctermbg=NONE guibg=NONE
