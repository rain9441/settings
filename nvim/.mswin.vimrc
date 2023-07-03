if 1
  let s:save_cpo = &cpoptions
endif
set cpo&vim

" MSWIN
" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
behave mswin

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

if has("clipboard")
    vnoremap <C-X> "+x
    vnoremap <C-C> "+y
    map <C-V>		"+gP
    cmap <C-V>		<C-R>+
endif

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.
" Use CTRL-G u to have CTRL-Z only undo the paste.

if 1
    exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
    exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']
endif

" Use CTRL-S for saving, also in Insert mode (<C-O> doesn't work well when
" using completions).
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<Esc>:update<CR>gi

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

" CTRL-Z is Undo; not in cmdline though
noremap <C-Z> u
inoremap <C-Z> <C-O>u

" CTRL-Y is Redo (although not repeat); not in cmdline though
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" noremap <C-Tab> :e #<CR>
" noremap <C-S-Tab> :bprev<CR>
" noremap <C-Tab><C-Tab> :e #<CR>

source ~/.vimrc.mruclose
nnoremap <C-F4> :bp\|bd #<CR>
" nnoremap <A-w><A-w> :bp\|bd #<CR>
nnoremap <A-w><A-w> :BufferCloseAndGoToMRU<CR>
nnoremap <A-w><A-a> :BufferCloseOthers<CR>
nnoremap <A-w><A-q> :BufferCloseAll<CR>

if has("gui_running")
    "set guioptions -=m " menu
    "set guioptions -=T " tabs
    "set guioptions -=r " right scrollbar
    "set guioptions -=L " left scrollbar
endif

set cpo&
if 1
  let &cpoptions = s:save_cpo
  unlet s:save_cpo
endif
