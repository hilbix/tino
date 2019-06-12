":" Copy+paste the next 2 lines or do: bash THIS_FILE_HERE
"git" clone https://github.com/hilbix/tino.git "$HOME/git/tino-rants/"
"ln" --symbolic --backup=t --relative "$HOME/git/tino-rants/howto/.vimrc" "$HOME/.vimrc"
"return"; exit

" set nomodelineexpr		" prevent CVE-2019-12735 with modeline (>=vim 8.1.x)
" set modeline			" enable things like # vim: ft=sh

set secure
set nomodeline			" disable modeline, see CVE-2019-12735
" use securemodelines instead (sudo apt-get install vim-scripts)
source /usr/share/vim-scripts/plugin/securemodelines.vim
let g:secure_modelines_verbose=1

set cul				" Highlight cursor line:
hi CursorLine term=none cterm=none ctermbg=0

" For more things perhaps see https://apfelboymchen.net/gnu/configstuff/scripts/usr/local/etc/vim/vimrc.html
set showcmd			" Show (partial) command in status line.
set showmatch			" Show matching brackets.
set ignorecase			" Do case insensitive matching
set smartcase			" Do smart case matching
set incsearch			" Incremental search
set autowrite			" Automatically save before commands like :next and :make

set background=dark		" better contrast

if has("autocmd")		" Remember last position
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

hi MySHOW ctermbg=black		" Highlight TABs and trailing spaces
match MySHOW /\(\t\)\|\(\s\s*$\)/

set ts=8 sw=8 noet ai ru fo=cqrt ls=2 shm=at

nnoremap M :silent make\|redraw!\|cw\|silent cc<CR>
nnoremap <Esc>m :silent make clean\|silent make\|redraw!\|cw\|silent cc<CR>

nnoremap <F4> :cprevious<CR>
nnoremap <F5> :cnext<CR>

set efm+=#%t#%f#%l#%c#%m#

syntax on

" :P is just easy to type
:command P %s/^\(\(        \)*\)\(\t\+\)/\=(submatch(1).repeat('        ',len(submatch(3))))

" see https://github.com/ConradIrwin/vim-bracketed-paste/blob/master/plugin/bracketed-paste.vim
let g:loaded_bracketed_paste = 1

let &t_ti .= "\<Esc>[?2004h"
let &t_te .= "\<Esc>[?2004l"

function! XTermPasteBegin(ret)
  set pastetoggle=<f29>
  set paste
  return a:ret
endfunction

execute "set <f28>=\<Esc>[200~"
execute "set <f29>=\<Esc>[201~"
map <expr> <f28> XTermPasteBegin("i")
imap <expr> <f28> XTermPasteBegin("")
vmap <expr> <f28> XTermPasteBegin("c")
cmap <f28> <nop>
cmap <f29> <nop>
