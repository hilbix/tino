":" Copy+paste the next 2 lines or do: bash THIS_FILE_HERE
"git" clone https://github.com/hilbix/tino.git "$HOME/git/tino-rants/"
"ln" --symbolic --backup=t --relative "$HOME/git/tino-rants/howto/.vimrc" "$HOME/.vimrc"
"return"; exit

" set nomodelineexpr		" prevent CVE-2019-12735 with modeline (>=vim 8.1.x)
" set modeline			" enable things like # vim: ft=sh

set swapsync=			" disable sync, huge advantage on ZFS, minor disadvantage
set secure
set nomodeline			" disable modeline, see CVE-2019-12735
" use securemodelines instead of insecure modeline
if filereadable(expand('~/.vim/plugins/securemodelines.vim'))
  " In case you cannot sudo:
  " apt-get download vim-scripts && dpkg -x vim-scripts_*_all.deb tmp/
  " cp tmp/usr/share/vim-scripts/plugin/securemodelines.vim ~/.vim/plugins/
  source ~/.vim/plugins/securemodelines.vim
else
  " sudo apt-get install vim-scripts
  source /usr/share/vim-scripts/plugin/securemodelines.vim
endif

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
syntax on			" of course

set background=dark		" I always use dark terminals for better contrast and more easy reading

hi MySHOW ctermbg=black		" Highlight TABs and trailing spaces
match MySHOW /\(\t\)\|\(\s\s*$\)/

" TAB is 8, it always has been and always will be.  Right?
set ts=8 sw=8 noet ai ru fo=cqrt ls=2 shm=at
map Q :q<CR>

" Easy make: "M" to "make" and jump to first error, ESC+M to "make clean"
nnoremap M :silent make\|redraw!\|cw\|silent cc<CR>
nnoremap <Esc>m :silent make clean\|silent make\|redraw!\|cw\|silent cc<CR>

" Easy to detect error output:
" #W#path/to/file#line#column#warning message#
" #E#path/to/file#line#column#error message#
set efm+=#%t#%f#%l#%c#%m#
set efm+=#%t#%f#%l##%m#
set efm+=#%t#%f###%m#
set efm+=#%t#%f##%c#%m#
" Jump to prev/next error (on sane keyboards there is a gap between F4 and F5, so easy to reach, spot and use)
nnoremap <F4> :cprevious<CR>
nnoremap <F5> :cnext<CR>

if has("autocmd")
  augroup vimrc
    autocmd!
    " Remember last position
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " !WARNING!  Following only works for the standard TAB setting of 8
    " :P is just easy to type, adjust to the TAB setting
    autocmd FileType *      command! P %s#^\(\(        \)*\)\(\t\+\)#\=(submatch(1).repeat('        ',len(submatch(3))))
    " this must be adjusted to the TAB stop setting of FT python, it's 8 at my side
    autocmd FileType python command! P %s#^\(\t*\)\(\(        \)\+\)#\=(submatch(1).repeat('	',len(submatch(2))/8))
  augroup END
else
  command P %s/^\(\(        \)*\)\(\t\+\)/\=(submatch(1).repeat('        ',len(submatch(3))))
endif

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

