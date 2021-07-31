" predefined variables {{{
let language_set="en_US.UTF-8"
let vim_config_file="~/.vimrc"
let plugin_path="~/.vim/plugins/"
let plug_file="~/.vim/plug.vim"
let coc_config_file="~/.vim/coc-config.vim"

" }}}
" GUI {{{
" must put on top
set guioptions-=T
set guioptions-=m
set guioptions-=r
set guioptions-=L
" do not allowed vim menu get loaded
" because it might conflicts with some key binding
set guioptions+=M

if has("win32")
    set guifont=FiraCode_NF:h12
else
    set guifont=FiraCode_NF:h16
endif

" }}}
" OS {{{

" Mac {{{
if has("gui_macvim")
    set lines=48 columns=108
    autocmd BufEnter * set guioptions+=!
    autocmd BufNewFile * set guioptions-=!
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
    " enable ligatures in gvim
    set renderoptions=type:directx
    autocmd InsertLeave * exec "redraw!"
endif
" }}}

" }}}
" editor {{{
" default {{{
set nocompatible
filetype plugin indent on
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
" when file has been chaged outside of vim buffer, autoload it
set autoread
" when switch between buffers or execute specific command save current buffer
set autowrite
set confirm
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set noswapfile
set noundofile
set clipboard=unnamed
" add ctags support
set tags=tags
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" display
set hlsearch
set mousehide
set noshowmode
set nocursorline
set colorcolumn=81
set signcolumn=yes
set linebreak
set sidescroll=5
set listchars+=precedes:<,extends:>
" Give more space for displaying messages.
set cmdheight=2
" }}}
" keymappings {{{

" close current window or buffer
noremap <silent><M-w> :close<cr>
noremap <silent><M-b> :bd<cr>
" use keystroke to open my vimrc
nnoremap <silent><F2> :execute 'edit' vim_config_file<CR>
" format json by python
nnoremap <F4> :%!python -m json.tool<cr>
" screen scroll add <nowait> to execute immediately
" see autocmd_keymap_force to set scroll down
" use backspace to scroll up
nnoremap <BS> <C-b>
" <leader> <Enter> to create new line in normal mode
nnoremap <silent><nowait><leader><Enter> :set paste<CR>m`o<ESC>``:set nopaste<CR>
" switch between buffers
nnoremap <silent><nowait><RIGHT> :bn<CR>
nnoremap <silent><nowait><LEFT> :bp<CR>
nnoremap <silent><TAB> :bn<CR>
" open file in tab with keys
noremap <C-n> :tabedit
" cd to current file directory
nnoremap <leader>cd :lcd %:p:h<cr>
" use <leader>w to close current window
" noremap <leader>w :close<CR>
" use <leader>t to go next tab
noremap <leader>t :tabnext<CR>
" map <esc> to quit terminal mode
tnoremap <Esc> <C-\><C-n>
" upper or lower wordcase
nnoremap <leader>u gUiw
nnoremap <leader>l guiw
" open NERDTreeToggle
noremap <silent><F1> :NERDTreeToggle<CR>
" split current window
nnoremap <leader>- :split %<CR>
" use <UP> and <DOWN> to scroll screen
nnoremap <silent><UP> 1<C-U><DOWN>
nnoremap <silent><DOWN> 1<C-D><UP>

"" Open explorer where current file is located {{{
"" Only for win for now.
func! File_manager() abort
    " Windows only for now
    if has("win32")
        if exists("b:netrw_curdir")
            let path = substitute(b:netrw_curdir, "/", "\\", "g")
        elseif expand("%:p") == ""
            let path = expand("%:p:h")
        else
            let path = expand("%:p")
        endif
        silent exe '!start explorer.exe /select,' .. path
    else
        echomsg "Not yet implemented!"
    endif
endfunc

nnoremap <silent> gof :call File_manager()<CR>
"}}}

" to use `ALT/Meta+{h,j,k,l}` to navigate windows from any mode: {{{
tnoremap <M-h> <C-\><C-N><C-w>h
tnoremap <M-j> <C-\><C-N><C-w>j
tnoremap <M-k> <C-\><C-N><C-w>k
tnoremap <M-l> <C-\><C-N><C-w>l
inoremap <M-h> <C-\><C-N><C-w>h
inoremap <M-j> <C-\><C-N><C-w>j
inoremap <M-k> <C-\><C-N><C-w>k
inoremap <M-l> <C-\><C-N><C-w>l
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
" }}}

" }}}
" autocmd {{{

augroup filetype_vim_specific
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup filetype_indent_size
    autocmd!
    autocmd FileType html,css,javascript,typescript,vue setlocal tabstop=2 shiftwidth=2
augroup END

augroup filetype_styleset
    autocmd!
    autocmd FileType json,text,markdown,vim,xml,properties,toml setlocal colorcolumn=0
    autocmd FileType rust,html,vue,sh setlocal colorcolumn=99
augroup END

function TrimEndLinesAndTrailingSpaces()
    let save_cursor = getpos(".")
    silent! %s#\($\n\s*\)\+\%$##
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
endfunction
augroup filetype_edit_behavior
    autocmd!
    autocmd FileType * setlocal textwidth=0
    " do not auto add comment when add new comment line in normal mode
    autocmd FileType * setlocal formatoptions-=o
    " auto remove all trailing empty lines before saving
    autocmd BufWritePre * call TrimEndLinesAndTrailingSpaces()
augroup END

augroup keymap_force
    autocmd!
    autocmd FileType * nnoremap <nowait> <Space> <C-f>
augroup END

augroup windows_display
    autocmd!
    autocmd WinLeave * setlocal norelativenumber number
    autocmd WinEnter * setlocal relativenumber
augroup END

function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" auto source vimrc after write
autocmd BufWritePost vim_config_file source vim_config_file
" when creating new buffer, auto switch to insert mode
autocmd BufNewFile * startinsert
" delete other buffers {{{
command! -nargs=? -complete=buffer -bang Bonly
    \ :call BufOnly('<args>', '<bang>')

function! BufOnly(buffer, bang)
	if a:buffer == ''
		" No buffer provided, use the current buffer.
		let buffer = bufnr('%')
	elseif (a:buffer + 0) > 0
		" A buffer number was provided.
		let buffer = bufnr(a:buffer + 0)
	else
		" A buffer name was provided.
		let buffer = bufnr(a:buffer)
	endif

	if buffer == -1
		echohl ErrorMsg
		echomsg "No matching buffer for" a:buffer
		echohl None
		return
	endif

	let last_buffer = bufnr('$')

	let delete_count = 0
	let n = 1
	while n <= last_buffer
		if n != buffer && buflisted(n)
			if a:bang == '' && getbufvar(n, '&modified')
				echohl ErrorMsg
				echomsg 'No write since last change for buffer'
							\ n '(add ! to override)'
				echohl None
			else
				silent exe 'bdel' . a:bang . ' ' . n
				if ! buflisted(n)
					let delete_count = delete_count+1
				endif
			endif
		endif
		let n = n+1
	endwhile

	if delete_count == 1
		echomsg delete_count "buffer deleted"
	elseif delete_count > 1
		echomsg delete_count "buffers deleted"
	endif

endfunction
" }}}

" }}}
" code compile and run {{{

func! CompileRunCode()
    let target_binary="./a.out"
    if has("win32")
        let target_binary="a.exe"
    endif
    if filereadable('Makefile')
        nnoremap <C-c> :make clean<CR>
        set makeprg=make\ -f\ Makefile
        exec "wall | !make && make run"
        return
    endif
    if filereadable('Cargo.toml')
        exec "wall | !cargo run"
        return
    endif
    if &filetype=="c"
        exec join(["write | !gcc -Wall -g *.c &&", target_binary], " ")
    elseif &filetype=="cpp"
        exec join(["write | !g++ -Wall -g *.cpp &&", target_binary], " ")
    elseif &filetype=="java"
        exec "write | !javac %:p && java %:r"
    elseif &filetype=="python"
        exec "write | !python %:p"
    elseif &filetype=="javascript"
        exec "write | !node %:p"
    elseif &filetype=="go"
        exec "write | !go run %:p"
    else
        echo "unsupported code run for current buffer."
    endif
endfunc

augroup exe_single_file_code
    autocmd!
    autocmd FileType c,cpp,java,python,javascript,go,rust
            \ nnoremap <nowait><buffer> <leader>r
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
" Plug 'jiangmiao/auto-pairs'
Plug 'cohama/lexima.vim'
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
" vim rust plugin
Plug 'rust-lang/rust.vim'
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
" css color preview
Plug 'ap/vim-css-color'
" vim webAPIs
Plug 'mattn/webapi-vim'
" easymotion
Plug 'easymotion/vim-easymotion'
" fileype and syntax plugin for LaTeX filest
Plug 'lervag/vimtex'
" markdown plugin
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" toml file plugin
Plug 'cespare/vim-toml'
" use unicode in vim easily
Plug 'chrisbra/unicode.vim'
" org-mode for vim
Plug 'jceb/vim-orgmode'
Plug 'Chiel92/vim-autoformat'
" frontend formatter
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
" golang plugin
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" slide presentation based on markdown
Plug 'sotte/presenting.vim'
" snippets engine and Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" filetype icon (always keeps at the bottom plugin list)
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
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync
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
    let g:gruvbox_italic=1
endif

" colorscheme onedark
" colorscheme onehalflight
" colorscheme onehalflight
" colorscheme onehalfdark
" let g:airline_theme='papercolor'
" let g:airline_theme='onehalfdark'

" enable true colors support
set termguicolors
set t_Co=256
" enable Comment italic
" highlight Comment cterm=italic gui=italic

" }}}

" TODO add .vscode config file
" TODO snippets integration optimize
" TODO learn vim sessions
