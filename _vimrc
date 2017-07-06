source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set guifont=Consolas:h08:cANSI
if has("gui_running")
	colorscheme evening
	set lines=30 columns=150
endif

"""BASIC TOOLS
"Navigating with guides
inoremap <Space><Space> <Esc>/<++><Enter>"_c4l
vnoremap <Space><Space> <Esc>/<++><Enter>"_c4l
map <Space><Space> <Esc>/<++><Enter>"_c4l
inoremap ;gui <++>
"For normal mode when in terminals (in X I have caps mapped to esc, this replaces it when I don't have X)
inoremap jw <Esc>
inoremap wj <Esc>
inoremap <C-l> <Space><Space>
"""END

syntax on

"au BufWinLeave * mkview
"au BufWinEnter * silent loadview

let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
"Spell-check set to F6
map <F6> :setlocal spell! spelllang=en_us<CR>
map <F10> :Goyo<CR>
map <F1> :NERDTreeToggle<CR>

com! FormatJSON %!python -m json.tool

" tell vim to keep a backup file
" set backup
" set backupdir=C:\\vim-temp\\backups
" set dir=C:\\vim-temp\\swaps

set nobackup
set noswapfile

set number
set autoindent

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
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
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

