" plugins {{{
execute 'source' plug_file
call plug#begin(fnameescape(plugin_path))
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" auto close parenthese
Plug 'cohama/lexima.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle'}
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" better hlsearch
Plug 'haya14busa/incsearch.vim'
Plug 'aperezdc/vim-template'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ap/vim-css-color', {'for': ['css', 'vue', 'javascript', 'html', 'less', 'scss']}
Plug 'easymotion/vim-easymotion'
Plug 'mattn/webapi-vim'
Plug 'vim-autoformat/vim-autoformat', {'for': ['c', 'cpp', 'java']}
Plug 'prettier/vim-prettier', {
  \ 'on': ['Prettier', 'AsnycPrettier'],
  \ 'do': 'yarn install'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoUpdateBinaries' }
Plug 'godlygeek/tabular', {'for': 'markdown'}
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'euclio/vim-markdown-composer', {'for': 'markdown'}
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'sotte/presenting.vim', {'for': 'markdown'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" colorscheme & statusline {{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'joshdick/onedark.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'sheerun/vim-polyglot'
if has('nvim') && v:version > 800
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif
" }}}
" filetype icon (always keeps at the bottom of plugin list)
Plug 'ryanoasis/vim-devicons'
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
" aperezdc/vim-template {{{
let g:templates_directory=["~/.vim/templates/"]
let g:username='zengshuai'
let g:email='zengs1994@gmail.com'
" }}}
" tpope/vim-commentary {{{
augroup commentary_vim
    autocmd!
    autocmd FileType c setlocal commentstring=//\ %s
    autocmd FileType cpp setlocal commentstring=//\ %s
augroup END
" }}}
" neoclide/coc.nvim {{{
execute 'source' coc_config_file
" }}}
" haya14busa/incsearch.vim {{{
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" }}}
" vim-airline/vim-airline {{{
" Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1
" enable fugitive show git info
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_left_sep = ''

" }}}
" airblade/vim-gitgutter {{{
" coc-git has sign conflict, just don't use it
let g:gitgutter_sign_priority = 0
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '*'
let g:gitgutter_sign_removed = '-'
" }}}
" tpope/vim-fugitive {{{
nnoremap <M-s> :Git status<CR>
" add guioptions '!' and make terminal output colored in mac
nnoremap <M-d> :!git diff<CR>
nnoremap <leader>ca :wall <bar> Git add * <bar> Git commit -am "
nnoremap <leader>cm :Git commit -am "
" git push
nnoremap <leader>ps :Git push<CR>
" }}}
" junegunn/fzf {{{
nnoremap <C-p> :Files<cr>
" }}}
" rust-lang/rust.vim {{{
let g:rustfmt_autosave = 1
" }}}
" easymotion/vim-easymotion {{{
" use <leader>w to invoke easymotion, so do not add use <leader>w keybinding again
map <leader> <Plug>(easymotion-prefix)
" }}}
" plasticboy/vim-markdown {{{
" keybinding
let g:vim_markdown_folding_disabled = 1
augroup markdown_keybinding
    autocmd!
    autocmd FileType markdown nnoremap <silent><leader>t :TableFormat<CR>
augroup END
" }}}
" euclio/vim-markdown-composer {{{
autocmd BufWritePost *.md :ComposerUpdate
let g:markdown_composer_open_browser = 0
" }}}
" fatih/vim-go {{{
" autocmd FileType go nmap <leader>r <Plug>(go-run-split)
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_template_autocreate=0
" }}}
" SirVer/ultisnips {{{
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<C-s>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
" }}}
" vim-autoformat/vim-autoformat {{{
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
" c/c++ and javascript autoformat config
autocmd BufWritePre *.c,*.cpp,*.h,*.java :Autoformat
"}}}
" prettier/vim-prettier {{{
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.svelte,*.yaml,*.html Prettier
"}}}
" colorscheme plugins {{{
let g:onedark_hide_endofbuffer=1
" let ayucolor="mirage" " for mirage version of theme
if has("gui_running") || has("nvim")
    set background=dark
    colorscheme ayu
    let ayucolor="mirage"
    " let g:airline_theme='onehalfdark'
else
    set background=dark
    colorscheme gruvbox
endif

" colorscheme onedark
" colorscheme onehalflight
" colorscheme onehalflight
" colorscheme onehalfdark
" let g:airline_theme='papercolor'
" let g:airline_theme='onehalfdark'


" }}}
" }}}