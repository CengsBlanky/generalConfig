" plugins {{{
execute 'source' plug_file
call plug#begin(fnameescape(plugin_path))
" git integrations for vim
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
" vim comment toggle
Plug 'tpope/vim-commentary'
" auto close parenthese
Plug 'cohama/lexima.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle'}
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" better hlsearch
Plug 'haya14busa/incsearch.vim'
" file management nnn
Plug 'mcchrish/nnn.vim'
" simple vim templates
Plug 'aperezdc/vim-template'
" show git diff in gutter
Plug 'airblade/vim-gitgutter'
" fuzzy finder for vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" better statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" colorschemes
Plug 'morhetz/gruvbox'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'joshdick/onedark.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'sheerun/vim-polyglot'
" fileype and syntax plugin for LaTeX filest
Plug 'lervag/vimtex'
" css color preview
Plug 'ap/vim-css-color'
" easymotion
Plug 'easymotion/vim-easymotion'
" vim webAPIs
Plug 'mattn/webapi-vim'
" use unicode in vim easily
Plug 'chrisbra/unicode.vim'
" autoformat plugin
Plug 'vim-autoformat/vim-autoformat'
" frontend formatter
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
" vim rust plugin
Plug 'rust-lang/rust.vim'
" golang plugin
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" markdown plugin
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" toml file plugin
Plug 'cespare/vim-toml'
" org-mode for vim
Plug 'jceb/vim-orgmode'
" slide presentation based on markdown
Plug 'sotte/presenting.vim'
" snippets engine and Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

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
" nnn config{{{
" Floating window (neovim latest and vim with patch 8.2.191)
if !has("win32")
    let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }
    " replace nerdtree with nnn
    let g:nnn#replace_netrw = 1
endif
" }}}
" vim templates config{{{
let g:templates_directory=["~/.vim/templates/"]
let g:username='zengshuai'
let g:email='zengs1994@gmail.com'
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
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_left_sep = ''

" }}}
" git-gutter {{{
" coc-git has sign conflict, just don't use it
let g:gitgutter_sign_priority = 0
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '*'
let g:gitgutter_sign_removed = '-'
" }}}
" vim fugitive config {{{
nnoremap <M-s> :Git status<CR>
" add guioptions '!' and make terminal output colored in mac
nnoremap <M-d> :!git diff<CR>
nnoremap <leader>ca :wall <bar> Git add * <bar> Git commit -am "
nnoremap <leader>cm :Git commit -am "
" git push
nnoremap <leader>ps :Git push<CR>
" }}}
" fzf config {{{
nnoremap <leader>z :Files<cr>
" }}}
" colorscheme plugin {{{
if has("gui_running")
    " for light version of theme
    let ayucolor="light"
else
    let ayucolor="dark"
endif
let g:onedark_terminal_italics=1
let g:onedark_hide_endofbuffer=1
" let ayucolor="mirage" " for mirage version of theme

" }}}
" rust.vim setting {{{
let g:rustfmt_autosave = 1
" }}}
" easymotion {{{
" use <leader>w to invoke easymotion, so do not add use <leader>w keybinding again
map <leader> <Plug>(easymotion-prefix)
" }}}
" markdown plugin{{{
" keybinding
augroup markdown_keybinding
    autocmd!
    autocmd FileType markdown nnoremap <silent><leader>t :TableFormat<CR>
augroup END
" }}}
" vim go setting {{{
" autocmd FileType go nmap <leader>r <Plug>(go-run-split)
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_template_autocreate=0
" }}}
" UltiSnips {{{
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<C-s>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
" let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/plugins/vim-snippets/UltiSnips', "UltiSnips"]

" }}}
" vim autoformat {{{
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
" c/c++ and javascript autoformat config
autocmd BufWritePre *.c,*.cpp,*.h,*.java :Autoformat
"}}}
" {{{ prettier config
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html Prettier
"}}}

" }}}
" colorscheme {{{
if has("gui_running")
    set background=light
    colorscheme ayu
    let g:airline_theme='onehalflight'
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
