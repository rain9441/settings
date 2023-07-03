" source $VIMRUNTIME/mswin.vim
set nocompatible
filetype off

" Preconfigure airline so when it is loaded it works better
" 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

luafile ~/.init.lua
"" " Keep Plug commands between plug#begin() and plug#end().
"" call plug#begin()
"" 
"" Plug 'dracula/vim', { 'as': 'dracula' }
"" 
"" " Basics
"" Plug 'kyazdani42/nvim-web-devicons'
"" Plug 'ryanoasis/vim-devicons'
"" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"" Plug 'jremmen/vim-ripgrep'
"" 
"" " Telescope
"" Plug 'nvim-telescope/telescope.nvim'
"" Plug 'nvim-lua/plenary.nvim'
"" 
"" " Git stuff
"" Plug 'airblade/vim-gitgutter'     " Show git diff of lines edited
"" Plug 'tpope/vim-fugitive'         " :Gblame
"" Plug 'sindrets/diffview.nvim'
"" 
"" " Debugging
"" Plug 'mfussenegger/nvim-dap'        " Debugger
"" Plug 'mxsdev/nvim-dap-vscode-js'    " JS Debugger
"" 
"" " Flow -- eg tools to help in Vim
"" Plug 'preservim/nerdtree'
"" Plug 'jlanzarotta/bufexplorer', { 'branch': '7.4.24' }
"" Plug 'neoclide/coc.nvim', { 'branch': 'release' }
"" Plug 'gennaro-tedesco/nvim-peekup' " Interact with registers
"" Plug 'vim-airline/vim-airline'    " Vim powerline
"" 
"" " other
"" Plug 'scrooloose/syntastic'
"" " Plug 'herringtondarkholme/yats.vim' " TypeScript syntax
"" " Plug 'jparise/vim-graphql'        " GraphQL syntax
"" " Plug 'styled-components/vim-styled-components'
"" 
"" 
"" " Plug 'easymotion/vim-easymotion'
"" " Plug 'asheq/close-buffers.vim'
"" 
"" 
"" " All of your Plugins must be added before the following line
"" call plug#end()              " required
"" filetype plugin indent on    " required

" CoC requires `set hidden`
set hidden

let mapleader = ","

" let g:dracula_italic=0
" let g:dracula_high_contrast_diff=0
" 
" augroup CustomDracula
"   autocmd!
"   autocmd ColorScheme dracula highlight Normal guibg=#101116
"   autocmd ColorScheme dracula highlight CursorLine guibg=#303137
" augroup END

augroup illuminate_augroup
    autocmd!
    autocmd ColorScheme dracula hi IlluminatedWordRead guibg=#505176 gui=none
    autocmd ColorScheme dracula hi IlluminatedWordWrite guibg=#505176 gui=none
    autocmd ColorScheme dracula hi IlluminatedWordText guibg=#505176 gui=none
augroup END



syn enable
" nicer font
" set guifont=Consolas_NFM:h10.5
" hi NonText guibg=black
set expandtab
set ignorecase

" Stop the annoying gvim ding sounds
set belloff=all

" don't leave files everywhere
set nobackup
set noswapfile
set nowritebackup

" default tabs = 4 spaces
set shiftwidth=4
set tabstop=4

" Indent
set autoindent
set smartindent

" Highlight the whole line
set cursorline

" Unsure what this does
set backspace=indent,eol,start

" Line numbers, yes please!
set number
set numberwidth=4

set encoding=utf-8
set termencoding=utf-8

set incsearch
set nohlsearch

set wildmenu
set title
set titlestring=%{getcwd()}

" And ignore node_modules entirely and /dist too
set wildignore+=**/node_modules**
set wildignore+=**/dist**
set wildignore+=**/coverage**

" NvimTree
map <F2> :NvimTreeToggle<CR>
map <F3> :NvimTreeFindFile<CR>
autocmd FileType nvimtree noremap <silent> <buffer> <C-Tab> :wincmd h<CR>
autocmd FileType nvimtree noremap <silent> <buffer> <C-S-Tab> :wincmd h<CR>

" Custom keybindings
" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" BufExplorer
nmap <silent> <expr> <C-Tab> (bufname('%') == "[BufExplorer]") ? 'j' : ':BufExplorer<CR>j'
nmap <silent> <expr> <C-S-Tab> (bufname('%') == "[BufExplorer]") ? 'k' : ':BufExplorer<CR>'

" Showmatch significantly slows down omnicomplete when the first match contains parentheses.
set showmatch
set completeopt=longest,menuone,preview

" Split settings
set splitbelow
set splitright

" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=300

" 'tpope/vim-fugitive'
" Fix some weird error with Fugitive
let g:fugitive_pty = 0

" Bind Ctrl-8 to Ripgrep for selection
vnoremap <C-8> y<Esc>:Rg <C-R>"<CR>
nnoremap <C-8> :Rg<CR>

" Command :Gf <file> to find in files across all files in the current git repo
command! -nargs=1 Gf noautocmd lvimgrep /<args>/gj `git ls-files` | lw
command! -nargs=1 Gfc noautocmd lvimgrep /<args>\C/gj `git ls-files` | lw
 
" Quick goto for config
nmap <leader>cv :e ~/.vimrc<CR>
nmap <leader>cn :e ~/.nvimrc<CR>
nmap <leader>cw :e ~/.mswin.vimrc<CR>
nmap <leader>cc :e ~/.coc.vimrc<CR>
nmap <leader>ci :e ~/.init.lua<CR>
nmap <leader>cl :e ~/.nvimrc.lua<CR>
nmap <leader>co :NERDTree ~/AppData/Local/nvim/<CR>
nmap <leader>c :echo glob("~/.*vimrc")<CR>


" telescope
"" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <C-p> <cmd>Telescope find_files<cr>

nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

nmap <silent> <leader>hr :set filetype=http<CR>:lua require('rest-nvim').run()<CR>
nmap <silent> <leader>h? :lua require('rest-nvim').run(true)<CR>
nmap <silent> <leader>hl :lua require('rest-nvim').last()<CR>

nnoremap <leader>ep :CccPick<CR>

nnoremap <leader>hi :TSHighlightCapturesUnderCursor<CR>
nnoremap <leader>hp :TSPlaygroundToggle<CR>

" 'ryanoasis/vim-devicons'
" WebDev Icons fix: after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

" Load CoC configuration
source ~/.coc.vimrc

" Load MSWIN'ish overrides
source ~/.mswin.vimrc

" NvrimRC
luafile ~/.nvimrc.lua

colorscheme dracula
    
