" predefined variables {{{
let language_set="en_US.UTF-8"
let vim_config_file="~/.vimrc"
let plugin_path="~/.vim/plugins/"
let plug_file="~/.vim/plug.vim"
let coc_config_file="~/.vim/coc-config.vim"
let coc_setting_file="~/.vim/coc-settings.json"
let coc_extentions_path="~/.vim/coc_extensions"
" }}}
" GUI {{{
if has("gui")
    set guioptions-=T
    set guioptions-=m
    set guioptions-=r
    set guioptions-=L
    set guioptions+=M
    " keymappings {{{
    " <shift-Enter> to create new line in normal mode
    nnoremap <S-Enter> o<Esc>
    if has("macunix")
        set guioptions+=!
    endif
    " }}}
endif
" }}}
" OS {{{

" Mac {{{
if has("macunix")
    " to use `Meta+{h,j,k,l}` to navigate windows from any mode: {{{
    tnoremap <D-h> <C-\><C-N><C-w>h
    tnoremap <D-j> <C-\><C-N><C-w>j
    tnoremap <D-k> <C-\><C-N><C-w>k
    tnoremap <D-l> <C-\><C-N><C-w>l
    inoremap <D-h> <C-\><C-N><C-w>h
    inoremap <D-j> <C-\><C-N><C-w>j
    inoremap <D-k> <C-\><C-N><C-w>k
    inoremap <D-l> <C-\><C-N><C-w>l
    nnoremap <D-h> <C-w>h
    nnoremap <D-j> <C-w>j
    nnoremap <D-k> <C-w>k
    nnoremap <D-l> <C-w>l
    " }}}
endif
" }}}
" Linux {{{
" }}}
" Windows {{{
if has("win32")
    let language_set="en-us"
    " Make shift-insert work like in Xterm
    map <S-Insert> <MiddleMouse>
    map! <S-Insert> <MiddleMouse>
    " Use the internal diff if available. {{{
    " Otherwise use the special 'diffexpr' for Windows.
    if &diffopt !~# 'internal'
    set diffexpr=MyDiff()
    endif
    function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg1 = substitute(arg1, '!', '\!', 'g')
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg2 = substitute(arg2, '!', '\!', 'g')
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let arg3 = substitute(arg3, '!', '\!', 'g')
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
        if empty(&shellxquote)
            let l:shxq_sav = ''
            set shellxquote&
        endif
        let cmd = '"' . $VIMRUNTIME . '\diff"'
        else
        let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    let cmd = substitute(cmd, '!', '\!', 'g')
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    if exists('l:shxq_sav')
        let &shellxquote=l:shxq_sav
    endif
    endfunction
    endif
    " }}}
" }}}

" }}}
" editor {{{
" default {{{
set nocompatible
filetype plugin indent on
" hide the mouse when typing
set mousehide
syntax on
set fileformat=unix
set fileformats=unix,dos
execute 'language' language_set
" unicode characters in the file autoload/float.vim
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
" let mapleader=","
" let maplocalleader=","
inoremap jk <esc>
" TextEdit might fail if hidden is not set.
set hidden
set number
set relativenumber
set backspace=2
set incsearch
set smartcase
set tabstop=4 smarttab shiftwidth=4 expandtab autoindent shiftround
set showcmd
set laststatus=2
set wildmenu
set showmatch
set confirm
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set noswapfile
set noundofile
set clipboard=unnamed
" display
set hlsearch
set signcolumn=auto
set lines=48 columns=85
set noshowmode
set nocursorline
set colorcolumn=81
set linebreak
set sidescroll=5
set listchars+=precedes:<,extends:>
" Give more space for displaying messages.
set cmdheight=2
" }}}
" keymappings {{{

" use keystroke to open my vimrc
nnoremap <F2> :execute 'edit' vim_config_file<CR>
" foramt json by python
nnoremap <F4> :%!python -m json.tool<cr>
" screen scroll add <nowait> to execute immediately
" see autocmd_keymap_force
nnoremap <S-space> <C-b>
" use <leader> n to go next buffer
" use <leader> p to go previous buffer
noremap <silent><nowait><leader>] :bn<CR>
noremap <silent><nowait><leader>[ :bp<CR>
" noremap <C-TAB> :bn<CR>
" <meta>-b close current buffer
" open file in tab with keys
noremap <C-n> :tabedit 
" cd to current file directory
nnoremap <leader>cd :lcd %:p:h<cr>
" use <leader>w to close current tab
noremap <leader>w :tabclose<cr>
" use <leader>t to go next tab
noremap <leader>t :tabnext<cr>
" map <esc> to quit terminal mode
tnoremap <Esc> <C-\><C-n>
" use <C-u> uppercase current word
" use <C-l> lowercase current word
nnoremap <C-u> gUiw
nnoremap <C-l> guiw
if has("macunix")
    " close window
    noremap <silent><D-w> :close<cr>
    " close current buffer
    " note: D means meta key in mac
    noremap <silent><D-b> :bd<cr>
else
    " close window
    noremap <silent><A-w> :close<cr>
    " close current buffer
    noremap <silent><A-b> :bd<cr>
endif

" to use `ALT+{h,j,k,l}` to navigate windows from any mode: {{{
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" }}}

" }}}
" autocmd {{{

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup filetype_indent
    autocmd!
    autocmd FileType html,htm,javascript,typescript,vue setlocal tabstop=2 shiftwidth=2
augroup END

augroup filetype_styleset
    autocmd!
    autocmd FileType json,txt,vim setlocal colorcolumn=0
augroup END

" when enter terminal mode, auto switch to insert mode
autocmd TerminalOpen * startinsert

" when insert newline with command "o", do not auto insert comment
autocmd BufEnter * setlocal formatoptions-=o

" when creating new buffer, auto switch to insert mode
autocmd BufNewFile * startinsert

augroup keymap_force
    autocmd!
    autocmd FileType * :nnoremap <nowait> <Space> <C-f><CR>
augroup END
" }}}
" code compile and run {{{

func! CompileRunCode()
    let target_binary="./a.out"
    if has("win32")
        target_binary="a.exe"
    endif
    if filereadable('Makefile')
        set makeprg=make\ -f\ Makefile
        exec "wall | !make && make run"
        return
    endif
    if &filetype=="c"
        exec join(["write | !gcc -Wall %:p &&", target_binary], " ")
    elseif &filetype=="cpp"
        exec join(["write | !g++ -Wall %:p &&", target_binary], " ")
    elseif &filetype=="java"
        exec "write | !javac %:p && java %<"
    elseif &filetype=="python"
        exec "write | !python %:p"
    elseif &filetype=="javascript"
        exec "write | !node %:p"
    endif
endfunc

augroup exe_code
    autocmd!
    autocmd FileType c,cpp,java,python,javascript 
            \ nnoremap <buffer> <localleader>r
            \ :call CompileRunCode()<CR>
augroup END

" }}}
" }}}
" plugins {{{
execute 'source' plug_file
call plug#begin(fnameescape(plugin_path))
" git integrations for vim
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
" vim comment toggle
Plug 'tpope/vim-commentary'
" auto insert paired brackets
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle'}
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'qpkorr/vim-renamer'
" better hlsearch
Plug 'haya14busa/incsearch.vim'
" file management nnn
Plug 'mcchrish/nnn.vim'
" vim templates
Plug 'tibabit/vim-templates'
" show git diff in gutter
Plug 'airblade/vim-gitgutter'
" tabnine AI code completion
Plug 'codota/tabnine-vim'
" fuzzy finder for vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" better statusline 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" colorscheme
Plug 'morhetz/gruvbox'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'joshdick/onedark.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'sheerun/vim-polyglot'

call plug#end()
" }}}
" plugins setting {{{

" haya14busa/incsearch.vim {{{
" automatically turn off hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" }}}
" nnn config{{{
" Floating window (neovim latest and vim with patch 8.2.191)
if !has("win32")
    let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }
    " replace nerdtree with nnn
    let g:nnn#replace_netrw = 1
endif
" }}}
" vim templates config{{{
let g:tmpl_search_paths=["~/.vim/templates/"]
let g:tmpl_author_name='zengshuai'
let g:tmpl_author_email='zengs1994@gmail.com'
" }}}
" tpope commentary config{{{
augroup commentary_vim 
    autocmd!
    autocmd FileType c setlocal commentstring=//\ %s
    autocmd FileType cpp setlocal commentstring=//\ %s
augroup END
" }}}
" coc config {{{
execute 'source' coc_config_file
" }}}
" better incsearch plugin setting {{{
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" }}}
" vim airline config {{{
" Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1
" enable fugitive show git info
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline_skip_empty_sections = 1
" let g:airline_theme='papercolor'
" let g:airline_theme='onehalfdark'
let g:airline_theme='onehalflight'
if has("win32")
    let g:airline_left_alt_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
endif

" }}}
" git-gutter {{{
" coc-git has sign conflict, just don't use it
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '*'
let g:gitgutter_sign_removed = '-'
" }}}
" vim fugitive config {{{
if has("macunix")
    nnoremap <M-s> :Git status<CR>
    nnoremap <M-d> :!git diff<CR>
else
    nnoremap <D-s> :Git status<CR>
    " add guioptions '!' and make terminal output colored in mac
    nnoremap <D-d> :!git diff<CR>
endif
nnoremap <leader>ca :wall <bar> Git add * <bar> Git commit -am "
" git push
nnoremap <leader>ps :Git push<CR>
" }}}
" fzf config {{{
nnoremap <leader>f :Files<cr>
" }}}
" colorscheme plugin {{{
let ayucolor="light"  " for light version of theme
let g:onedark_terminal_italics=1
let g:onedark_hide_endofbuffer=1
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme

" }}}

" }}}
" colorscheme {{{
colorscheme ayu
" colorscheme onehalflight
" colorscheme gruvbox
" colorscheme onedark
" colorscheme onehalflight
" colorscheme onehalfdark

" enable true colors support
set termguicolors     
" terminal setting
set termguicolors 
set t_Co=256
" Fira code does not support italic
if has("win32")
    set guifont=Fira_Code:h12:cANSI:qDRAFT
endif
set guifont=Menlo:h20
" enable Comment italic
highlight Comment cterm=italic gui=italic

" }}}
