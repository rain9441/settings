" source $VIMRUNTIME/mswin.vim
set nocompatible
filetype off

" Preconfigure airline so when it is loaded it works better
" 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

luafile ~/.init.lua

" CoC requires `set hidden`
set hidden

let mapleader = ","

augroup IlluminateHighlights
    autocmd!
    autocmd ColorScheme dracula hi IlluminatedWordRead guibg=#505176 gui=none
    autocmd ColorScheme dracula hi IlluminatedWordWrite guibg=#505176 gui=none
    autocmd ColorScheme dracula hi IlluminatedWordText guibg=#505176 gui=none
augroup END

syn enable

set expandtab
set ignorecase

" Stop the annoying gvim ding sounds
set belloff=all

" don't leave files everywhere
set nobackup
set noswapfile
set nowritebackup

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

" QuickFix window always on bottom
augroup QuickFixToBottom
    autocmd!
    autocmd FileType qf wincmd J
augroup END

" NvimTree
map <F2> :NvimTreeToggle<CR>
map <F3> :NvimTreeFindFile<CR>

" Custom keybindings
" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" BufExplorer
nnoremap <silent> <C-Tab> <cmd>call CustomTab()<CR>
nnoremap <silent> <C-S-Tab> <cmd>call CustomTab()<CR>

augroup UnlistBuffers
    autocmd!
    autocmd TermOpen * set nobl
    autocmd FileType dapui-console set nobl
    autocmd FileType dap-repl set nobl
    autocmd FileType OverseerList set nobl
augroup END

function! CustomTab()
    let info = getbufinfo('%')[0]
    let buftype = getbufvar(bufnr(), '&buftype')
    if info.listed && empty(buftype)
        lua require('telescope.builtin').buffers()
    else
        let wininfo = getwininfo()
        for win in wininfo
            if win.bufnr > 0 && getbufinfo(win.bufnr)[0].listed == 1
                " echo "found" .. getbufinfo(win.bufnr)[0]
                exec win.winnr .. "wincmd w"
                lua require('telescope.builtin').buffers()
                break
            endif
        endfor
    endif
endfunction

" Showmatch significantly slows down omnicomplete when the first match contains parentheses.
set showmatch
set completeopt=longest,menuone,preview

" Split settings
set splitbelow
set splitright

" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=300

" Tabs, tabs, omg tabs
set shiftwidth=4
set tabstop=4

augroup FileTypeBasedShiftWidths
  autocmd!
  autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
  autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
  autocmd FileType lua setlocal shiftwidth=2 tabstop=2
augroup END

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
nmap <silent> <leader>cv :e ~/.vimrc<CR>
nmap <silent> <leader>cn :e ~/.nvimrc<CR>
nmap <silent> <leader>cw :e ~/.mswin.vimrc<CR>
nmap <silent> <leader>cc :e ~/.coc.vimrc<CR>
nmap <silent> <leader>ci :e ~/.init.lua<CR>
nmap <silent> <leader>cl :e ~/.nvimrc.lua<CR>
nmap <silent> <leader>co :e ~/AppData/Local/nvim/<CR>
nmap <silent> <leader>c :echo glob("~/.*vimrc")<CR>

" Quack
nnoremap <leader>= <cmd>lua require("duck").hatch()<CR>
nnoremap <leader>- <cmd>lua require("duck").cook()<CR>

" MoveLine
" Normal-mode commands
nnoremap <silent> <A-Up> :MoveLine(-1)<CR>
nnoremap <silent> <A-Down> :MoveLine(1)<CR>
vnoremap <silent> <A-Up> :MoveBlock(-1)<CR>
vnoremap <silent> <A-Down> :MoveBlock(1)<CR>

" Overseer
nmap <silent> <leader>ol <cmd>OverseerToggle<CR>
nmap <silent> <leader>ot <cmd>OverseerToggle<CR>
nmap <silent> <leader>oi <cmd>OverseerInfo<CR>
nmap <silent> <leader>ob <cmd>OverseerBuild<CR>
nmap <silent> <leader>or <cmd>OverseerRun<CR>
nmap <silent> <leader>tr <cmd>lua require('neotest').overseer.run({})<CR>

" Debugger
nmap <silent> <F4> <cmd>lua require('dap').pause()<CR>
nmap <silent> <F5> <cmd>lua require('dap.ext.vscode').load_launchjs()<CR><cmd>lua require('dap').continue()<CR>
nmap <silent> <F6> <cmd>lua require('dap').terminate()<CR>
" nmap <silent> <F9> <cmd>lua require('dap').toggle_breakpoint()<CR>
" nmap <silent> <C-F9> <cmd>lua require('dap').set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>
nmap <silent> <F9> <cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<CR>
nmap <silent> <C-F9> <cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint()<CR>
nmap <silent> <F10> <cmd>lua require('dap').step_over()<CR>
nmap <silent> <F11> <cmd>lua require('dap').step_into()<CR>
nmap <silent> <S-F11> <cmd>lua require('dap').step_out()<CR>
nmap <silent> <F12> <cmd>lua require('dap').run_to_cursor()<CR>
nmap <silent> <leader>dl <cmd>lua require('dap').list_breakpoints()<CR><cmd>copen<CR>
nmap <silent> <leader>de <cmd>lua require('dap').set_exception_breakpoints()<CR>
nmap <silent> <leader>ds <cmd>lua print(require('dap').status())<CR>
nmap <silent> <leader>du <cmd>lua require('dapui').toggle()<CR>
nmap <silent> <leader>db <cmd>lua require('dap').set_exception_breakpoints({ 'all' })<CR>
lua vim.fn.sign_define('DapBreakpointCondition', {text = '🤔', texthl = '', linehl = '', numhl = ''})
lua vim.fn.sign_define('DapBreakpoint', {text = '🟦', texthl = '', linehl = '', numhl = ''})
lua vim.fn.sign_define('DapBreakpointRejected', {text = '🟥', texthl = '', linehl = '', numhl = ''})
lua vim.fn.sign_define('DapStopped', {text = '👉', texthl = '', linehl = '', numhl = ''})

" Quick Fix"
nnoremap <silent><expr> <leader>qq "<cmd>".(get(getqflist({"winid": 1}), "winid") != 0? "cclose" : "bot copen")."<cr>"
nmap <silent> <leader>qo :bot copen<CR>
nmap <silent> <leader>qc :cclose<CR>

nnoremap <silent> t <Plug>(comment_toggle_linewise_current)
nnoremap <silent> <C-T> <Plug>(comment_toggle_blockwise_current)
vnoremap <silent> T <Plug>(comment_toggle_linewise_visual)
vnoremap <silent> <C-T> <Plug>(comment_toggle_blockwise_visual)

" telescope
"" Find files using Telescope command-line sugar.
nnoremap <silent> <C-p> <cmd>Telescope find_files<cr>
nnoremap <silent> <leader>ff <cmd>Telescope find_files<cr>
nnoremap <silent> <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>fo <cmd>lua require('telescope.builtin').live_grep({ grep_open_files = true })<cr>
nnoremap <silent> <leader>ff <cmd>lua require('telescope.builtin').live_grep({ grep_open_files = true })<cr>
nnoremap <silent> <leader>fs <cmd>Telescope grep_string<cr>
nnoremap <silent> <leader>fb <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <silent> <leader>ftt <cmd>Telescope git_commits<cr>
nnoremap <silent> <leader>ftb <cmd>Telescope git_bcommits<cr>
nnoremap <silent> <leader>fts <cmd>Telescope git_status<cr>
nnoremap <silent> <leader>fl <cmd>Telescope builtin<cr>
nnoremap <silent> <leader>ss <cmd>Telescope session-lens search_session<cr>

nmap <silent> <leader>hr :set filetype=http<CR>:lua require('rest-nvim').run()<CR>
nmap <silent> <leader>h? :lua require('rest-nvim').run(true)<CR>
nmap <silent> <leader>hl :lua require('rest-nvim').last()<CR>

nnoremap <silent> <leader>ep :CccPick<CR>
nnoremap <silent> <leader>n <cmd>lua require('neogen').generate()<CR>

" Treesj (join / split funcitons
nnoremap <silent> <leader>m :TSJToggle<CR>

" Treesitter
nnoremap <silent> <leader>hi :TSHighlightCapturesUnderCursor<CR>
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
    
