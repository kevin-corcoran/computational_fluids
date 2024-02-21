let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <C-Tab> =UltiSnips#ListSnippets()
inoremap <silent> <Plug>(fzf-maps-i) :call fzf#vim#maps('i', 0)
inoremap <expr> <Plug>(fzf-complete-buffer-line) fzf#vim#complete#buffer_line()
inoremap <expr> <Plug>(fzf-complete-line) fzf#vim#complete#line()
inoremap <expr> <Plug>(fzf-complete-file-ag) fzf#vim#complete#path('ag -l -g ""')
inoremap <expr> <Plug>(fzf-complete-file) fzf#vim#complete#path("find . -path '*/\.*' -prune -o -type f -print -o -type l -print | sed 's:^..::'")
inoremap <expr> <Plug>(fzf-complete-path) fzf#vim#complete#path("find . -path '*/\.*' -prune -o -print | sed '1d;s:^..::'")
inoremap <expr> <Plug>(fzf-complete-word) fzf#vim#complete#word()
inoremap <C-L> u[s1z=`]au
inoremap <C-F> : silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"':w
inoremap <expr> <C-X><C-K> fzf#vim#complete('cat /usr/share/dict/words')
inoremap <F1> :set invfullscreena
vnoremap  :'<,'>w !xclip -sel clip
nnoremap  : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &':redraw!
xmap  h
nmap  h
snoremap <silent>  "_c
omap  h
xnoremap <silent> 	 :call UltiSnips#SaveLastVisualSelection()gvs
snoremap <silent> 	 :call UltiSnips#ExpandSnippetOrJump()
map <NL> j
map  k
map  l
nmap  :Buffers
snoremap  "_c
nnoremap  :FZF
omap <silent> % <Plug>(MatchitOperationForward)
xmap <silent> % <Plug>(MatchitVisualForward)
nmap <silent> % <Plug>(MatchitNormalForward)
xnoremap / /\v
snoremap / /\v
nnoremap / /\v
nmap H gT
nmap L gt
omap <silent> [% <Plug>(MatchitOperationMultiBackward)
xmap <silent> [% <Plug>(MatchitVisualMultiBackward)
nmap <silent> [% <Plug>(MatchitNormalMultiBackward)
nmap \l :set list! " Toggle tabs and EOL
xmap \l :set list! " Toggle tabs and EOL
omap \l :set list! " Toggle tabs and EOL
nmap \q gqip
xmap \q gqip
omap \q gqip
nmap \  :let @/='' " clear search
xmap \  :let @/='' " clear search
omap \  :let @/='' " clear search
smap \l :set list! " Toggle tabs and EOL
smap \q gqip
smap \  :let @/='' " clear search
omap <silent> ]% <Plug>(MatchitOperationMultiForward)
xmap <silent> ]% <Plug>(MatchitVisualMultiForward)
nmap <silent> ]% <Plug>(MatchitNormalMultiForward)
xmap a% <Plug>(MatchitVisualTextObject)
xmap gx <Plug>NetrwBrowseXVis
smap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
omap <silent> g% <Plug>(MatchitOperationBackward)
xmap <silent> g% <Plug>(MatchitVisualBackward)
nmap <silent> g% <Plug>(MatchitNormalBackward)
nnoremap j gj
nnoremap k gk
nnoremap mt :call MoveToNextTab()
nnoremap mT :call MoveToPrevTab()
xmap <C-H> h
nmap <C-H> h
nnoremap <Plug>(-fzf-vim-do) :execute g:__fzf_command
nnoremap <Plug>(-fzf-/) /
nnoremap <Plug>(-fzf-:) :
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))
snoremap <C-R> "_c
snoremap <silent> <C-H> "_c
snoremap <silent> <Del> "_c
snoremap <silent> <BS> "_c
snoremap <silent> <C-Tab> :call UltiSnips#ListSnippets()
onoremap <silent> <Plug>(fzf-maps-o) :call fzf#vim#maps('o', 0)
xnoremap <silent> <Plug>(fzf-maps-x) :call fzf#vim#maps('x', 0)
nnoremap <silent> <Plug>(fzf-maps-n) :call fzf#vim#maps('n', 0)
vnoremap <C-C> :'<,'>w !xclip -sel clip
nnoremap <C-S-PageDown> :tabm +1
nnoremap <C-S-PageUp> :tabm -1
nnoremap <C-F> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &':redraw!
map <C-L> l
omap <C-H> h
map <C-K> k
map <C-J> j
nnoremap <C-T> :FZF
nmap <C-P> :Buffers
vnoremap <F1> :set invfullscreen
nnoremap <F1> :set invfullscreen
xmap <silent> <Plug>(MatchitVisualTextObject) <Plug>(MatchitVisualMultiBackward)o<Plug>(MatchitVisualMultiForward)
onoremap <silent> <Plug>(MatchitOperationMultiForward) :call matchit#MultiMatch("W",  "o")
onoremap <silent> <Plug>(MatchitOperationMultiBackward) :call matchit#MultiMatch("bW", "o")
xnoremap <silent> <Plug>(MatchitVisualMultiForward) :call matchit#MultiMatch("W",  "n")m'gv``
xnoremap <silent> <Plug>(MatchitVisualMultiBackward) :call matchit#MultiMatch("bW", "n")m'gv``
nnoremap <silent> <Plug>(MatchitNormalMultiForward) :call matchit#MultiMatch("W",  "n")
nnoremap <silent> <Plug>(MatchitNormalMultiBackward) :call matchit#MultiMatch("bW", "n")
onoremap <silent> <Plug>(MatchitOperationBackward) :call matchit#Match_wrapper('',0,'o')
onoremap <silent> <Plug>(MatchitOperationForward) :call matchit#Match_wrapper('',1,'o')
xnoremap <silent> <Plug>(MatchitVisualBackward) :call matchit#Match_wrapper('',0,'v')m'gv``
xnoremap <silent> <Plug>(MatchitVisualForward) :call matchit#Match_wrapper('',1,'v')m'gv``
nnoremap <silent> <Plug>(MatchitNormalBackward) :call matchit#Match_wrapper('',0,'n')
nnoremap <silent> <Plug>(MatchitNormalForward) :call matchit#Match_wrapper('',1,'n')
inoremap  : silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"':w
inoremap <silent> 	 =UltiSnips#ExpandSnippetOrJump()
inoremap  u[s1z=`]au
inoremap <expr>  fzf#vim#complete('cat /usr/share/dict/words')
let &cpo=s:cpo_save
unlet s:cpo_save
set autoread
set background=dark
set backspace=indent,eol,start
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set formatoptions=tcqrn1
set helplang=en
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set listchars=tab:▸\ ,eol:¬
set matchpairs=(:),{:},[:],<:>
set modelines=0
set mouse=a
set printoptions=paper:a4
set ruler
set runtimepath=~/.vim,~/.vim/bundle/Vundle.vim,~/.vim/bundle/vim-latex-live-preview,~/.vim/bundle/julia-vim,~/.vim/bundle/fzf,~/.vim/bundle/fzf.vim,~/.vim/bundle/vim-notebook,~/.vim/bundle/vimtex,~/.vim/bundle/ultisnips,~/.vim/bundle/vim-snippets,/var/lib/vim/addons,/etc/vim,/usr/share/vim/vimfiles,/usr/share/vim/vim82,/usr/share/vim/vim82/pack/dist/opt/matchit,/usr/share/vim/vimfiles/after,/etc/vim/after,/var/lib/vim/addons/after,~/.vim/after,~/.vim/bundle/Vundle.vim,~/.vim/bundle/Vundle.vim/after,~/.vim/bundle/vim-latex-live-preview/after,~/.vim/bundle/julia-vim/after,~/.vim/bundle/fzf/after,~/.vim/bundle/fzf.vim/after,~/.vim/bundle/vim-notebook/after,~/.vim/bundle/vimtex/after,~/.vim/bundle/ultisnips/after,~/.vim/bundle/vim-snippets/after,/usr/lib/python3/dist-packages/powerline/bindings/vim
set scrolloff=3
set shiftwidth=2
set showcmd
set showmatch
set smartcase
set softtabstop=2
set spelllang=en_us
set splitbelow
set splitright
set statusline=%!py3eval('powerline.new_window()')
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set switchbuf=usetab,newtab,useopen
set tabline=%!py3eval('powerline.tabline()')
set tabstop=2
set textwidth=79
set updatetime=500
set wildcharm=26
set wildignore=*.pyc
set wildmenu
set window=49
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/code
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd advect.py
set stal=2
tabnew
tabnew
tabnew
tabnew
tabnew
tabnew
tabnew
tabnew
tabrewind
edit ~/ucsc/master-2/quarter-1/computational-fluids/cfd/cfd/advect1d/utils.py
set splitbelow splitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
let s:cpo_save=&cpo
set cpo&vim
inoremap <buffer> <nowait> <silent> <S-Tab> =UltiSnips#JumpBackwards()
imap <buffer> <F5> :w:exec '!python3 -i' shellescape(@%, 1)
snoremap <buffer> <nowait> <silent> <S-Tab> :call UltiSnips#JumpBackwards()
map <buffer> <F5> :w:exec '!python3 -i' shellescape(@%, 1)
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=b:#,fb:-
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'python'
setlocal filetype=python
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcqrn1
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\s*\\(from\\|import\\)
setlocal includeexpr=substitute(substitute(substitute(v:fname,b:grandparent_match,b:grandparent_sub,''),b:parent_match,b:parent_sub,''),b:child_match,b:child_sub,'g')
setlocal indentexpr=GetPythonIndent(v:lnum)
setlocal indentkeys=0{,0},0),0],:,!^F,o,O,e,<:>,=elif,=except
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=python3complete#Complete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=4
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(34)')
setlocal suffixesadd=.py
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'python'
setlocal syntax=python
endif
setlocal tabstop=8
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=79
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 2 - ((1 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
2
normal! 05|
tabnext
edit advect.py
set splitbelow splitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
let s:cpo_save=&cpo
set cpo&vim
imap <buffer> <F5> :w:exec '!python3 -i' shellescape(@%, 1)
map <buffer> <F5> :w:exec '!python3 -i' shellescape(@%, 1)
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=b:#,fb:-
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'python'
setlocal filetype=python
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcqrn1
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\s*\\(from\\|import\\)
setlocal includeexpr=substitute(substitute(substitute(v:fname,b:grandparent_match,b:grandparent_sub,''),b:parent_match,b:parent_sub,''),b:child_match,b:child_sub,'g')
setlocal indentexpr=GetPythonIndent(v:lnum)
setlocal indentkeys=0{,0},0),0],:,!^F,o,O,e,<:>,=elif,=except
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=python3complete#Complete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=4
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=4
setlocal spell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(23)')
setlocal suffixesadd=.py
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'python'
setlocal syntax=python
endif
setlocal tabstop=8
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=79
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 22 - ((19 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
22
normal! 05|
tabnext
edit ~/ucsc/master-2/quarter-1/computational-fluids/cfd/cfd/advect1d/euler.py
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 43 + 25) / 50)
exe 'vert 1resize ' . ((&columns * 168 + 93) / 186)
exe '2resize ' . ((&lines * 43 + 25) / 50)
exe 'vert 2resize ' . ((&columns * 14 + 93) / 186)
argglobal
let s:cpo_save=&cpo
set cpo&vim
imap <buffer> <F5> :w:exec '!python3 -i' shellescape(@%, 1)
map <buffer> <F5> :w:exec '!python3 -i' shellescape(@%, 1)
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=b:#,fb:-
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'python'
setlocal filetype=python
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcqrn1
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\s*\\(from\\|import\\)
setlocal includeexpr=substitute(substitute(substitute(v:fname,b:grandparent_match,b:grandparent_sub,''),b:parent_match,b:parent_sub,''),b:child_match,b:child_sub,'g')
setlocal indentexpr=GetPythonIndent(v:lnum)
setlocal indentkeys=0{,0},0),0],:,!^F,o,O,e,<:>,=elif,=except
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=python3complete#Complete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=4
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(18)')
setlocal suffixesadd=.py
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'python'
setlocal syntax=python
endif
setlocal tabstop=8
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=79
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 109 - ((3 * winheight(0) + 21) / 43)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
109
normal! 032|
wincmd w
argglobal
if bufexists("~/ucsc/master-2/quarter-1/computational-fluids/cfd/cfd/scalar.py") | buffer ~/ucsc/master-2/quarter-1/computational-fluids/cfd/cfd/scalar.py | else | edit ~/ucsc/master-2/quarter-1/computational-fluids/cfd/cfd/scalar.py | endif
let s:cpo_save=&cpo
set cpo&vim
imap <buffer> <F5> :w:exec '!python3 -i' shellescape(@%, 1)
map <buffer> <F5> :w:exec '!python3 -i' shellescape(@%, 1)
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=b:#,fb:-
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'python'
setlocal filetype=python
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcqrn1
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\s*\\(from\\|import\\)
setlocal includeexpr=substitute(substitute(substitute(v:fname,b:grandparent_match,b:grandparent_sub,''),b:parent_match,b:parent_sub,''),b:child_match,b:child_sub,'g')
setlocal indentexpr=GetPythonIndent(v:lnum)
setlocal indentkeys=0{,0},0),0],:,!^F,o,O,e,<:>,=elif,=except
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=python3complete#Complete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=4
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(45)')
setlocal suffixesadd=.py
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'python'
setlocal syntax=python
endif
setlocal tabstop=8
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=79
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 91 - ((3 * winheight(0) + 21) / 43)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
91
normal! 0
wincmd w
exe '1resize ' . ((&lines * 43 + 25) / 50)
exe 'vert 1resize ' . ((&columns * 168 + 93) / 186)
exe '2resize ' . ((&lines * 43 + 25) / 50)
exe 'vert 2resize ' . ((&columns * 14 + 93) / 186)
tabnext
edit ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/eigensystem.F90
set splitbelow splitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:!
setlocal commentstring=!%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'fortran'
setlocal filetype=fortran
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=cqrn1t
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\c#\\=\\s*include\\s\\+
setlocal includeexpr=
setlocal indentexpr=FortranGetFreeIndent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e,=~end,=~case,=~if,=~else,=~do,=~where,=~elsewhere,=~select,=~endif,=~enddo,=~endwhere,=~endselect,=~elseif,=~type,=~interface,=~forall,=~associate,=~block,=~enum,=~endforall,=~endassociate,=~endblock,=~endenum
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(16)')
setlocal suffixesadd=.f08,.f03,.f95,.f90,.for,.f,.F,.f77,.ftn,.fpp
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'fortran'
setlocal syntax=fortran
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=132
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 101 - ((27 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
101
normal! 014|
tabnext
edit ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/driver_euler1d.F90
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd w
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 24 + 25) / 50)
exe 'vert 1resize ' . ((&columns * 60 + 93) / 186)
exe '2resize ' . ((&lines * 22 + 25) / 50)
exe 'vert 2resize ' . ((&columns * 60 + 93) / 186)
exe '3resize ' . ((&lines * 24 + 25) / 50)
exe 'vert 3resize ' . ((&columns * 120 + 93) / 186)
exe '4resize ' . ((&lines * 24 + 25) / 50)
exe 'vert 4resize ' . ((&columns * 4 + 93) / 186)
exe '5resize ' . ((&lines * 22 + 25) / 50)
exe 'vert 5resize ' . ((&columns * 120 + 93) / 186)
exe '6resize ' . ((&lines * 22 + 25) / 50)
exe 'vert 6resize ' . ((&columns * 4 + 93) / 186)
argglobal
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:!
setlocal commentstring=!%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'fortran'
setlocal filetype=fortran
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=cqrn1t
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\c#\\=\\s*include\\s\\+
setlocal includeexpr=
setlocal indentexpr=FortranGetFreeIndent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e,=~end,=~case,=~if,=~else,=~do,=~where,=~elsewhere,=~select,=~endif,=~enddo,=~endwhere,=~endselect,=~elseif,=~type,=~interface,=~forall,=~associate,=~block,=~enum,=~endforall,=~endassociate,=~endblock,=~endenum
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(10)')
setlocal suffixesadd=.f08,.f03,.f95,.f90,.for,.f,.F,.f77,.ftn,.fpp
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'fortran'
setlocal syntax=fortran
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=132
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 28 - ((3 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
28
normal! 028|
lcd ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template
wincmd w
argglobal
if bufexists("~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_FOG.F90") | buffer ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_FOG.F90 | else | edit ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_FOG.F90 | endif
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:!
setlocal commentstring=!%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'fortran'
setlocal filetype=fortran
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=cqrn1t
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\c#\\=\\s*include\\s\\+
setlocal includeexpr=
setlocal indentexpr=FortranGetFreeIndent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e,=~end,=~case,=~if,=~else,=~do,=~where,=~elsewhere,=~select,=~endif,=~enddo,=~endwhere,=~endselect,=~elseif,=~type,=~interface,=~forall,=~associate,=~block,=~enum,=~endforall,=~endassociate,=~endblock,=~endenum
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(11)')
setlocal suffixesadd=.f08,.f03,.f95,.f90,.for,.f,.F,.f77,.ftn,.fpp
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'fortran'
setlocal syntax=fortran
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=132
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template
wincmd w
argglobal
if bufexists("~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_ReconEvolveAvg.F90") | buffer ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_ReconEvolveAvg.F90 | else | edit ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_ReconEvolveAvg.F90 | endif
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:!
setlocal commentstring=!%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'fortran'
setlocal filetype=fortran
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=cqrn1t
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\c#\\=\\s*include\\s\\+
setlocal includeexpr=
setlocal indentexpr=FortranGetFreeIndent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e,=~end,=~case,=~if,=~else,=~do,=~where,=~elsewhere,=~select,=~endif,=~enddo,=~endwhere,=~endselect,=~elseif,=~type,=~interface,=~forall,=~associate,=~block,=~enum,=~endforall,=~endassociate,=~endblock,=~endenum
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(12)')
setlocal suffixesadd=.f08,.f03,.f95,.f90,.for,.f,.F,.f77,.ftn,.fpp
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'fortran'
setlocal syntax=fortran
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=132
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 9 - ((8 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
9
normal! 0
lcd ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template
wincmd w
argglobal
if bufexists("~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_reconstruct.F90") | buffer ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_reconstruct.F90 | else | edit ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_reconstruct.F90 | endif
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:!
setlocal commentstring=!%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'fortran'
setlocal filetype=fortran
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=cqrn1t
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\c#\\=\\s*include\\s\\+
setlocal includeexpr=
setlocal indentexpr=FortranGetFreeIndent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e,=~end,=~case,=~if,=~else,=~do,=~where,=~elsewhere,=~select,=~endif,=~enddo,=~endwhere,=~endselect,=~elseif,=~type,=~interface,=~forall,=~associate,=~block,=~enum,=~endforall,=~endassociate,=~endblock,=~endenum
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(13)')
setlocal suffixesadd=.f08,.f03,.f95,.f90,.for,.f,.F,.f77,.ftn,.fpp
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'fortran'
setlocal syntax=fortran
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=132
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template
wincmd w
argglobal
if bufexists("~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_getFlux.F90") | buffer ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_getFlux.F90 | else | edit ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_getFlux.F90 | endif
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:!
setlocal commentstring=!%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'fortran'
setlocal filetype=fortran
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=cqrn1t
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\c#\\=\\s*include\\s\\+
setlocal includeexpr=
setlocal indentexpr=FortranGetFreeIndent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e,=~end,=~case,=~if,=~else,=~do,=~where,=~elsewhere,=~select,=~endif,=~enddo,=~endwhere,=~endselect,=~elseif,=~type,=~interface,=~forall,=~associate,=~block,=~enum,=~endforall,=~endassociate,=~endblock,=~endenum
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(14)')
setlocal suffixesadd=.f08,.f03,.f95,.f90,.for,.f,.F,.f77,.ftn,.fpp
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'fortran'
setlocal syntax=fortran
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=132
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 21 - ((0 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
21
normal! 0
lcd ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template
wincmd w
argglobal
if bufexists("~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_update.F90") | buffer ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_update.F90 | else | edit ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_update.F90 | endif
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:!
setlocal commentstring=!%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'fortran'
setlocal filetype=fortran
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=cqrn1t
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\c#\\=\\s*include\\s\\+
setlocal includeexpr=
setlocal indentexpr=FortranGetFreeIndent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e,=~end,=~case,=~if,=~else,=~do,=~where,=~elsewhere,=~select,=~endif,=~enddo,=~endwhere,=~endselect,=~elseif,=~type,=~interface,=~forall,=~associate,=~block,=~enum,=~endforall,=~endassociate,=~endblock,=~endenum
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(15)')
setlocal suffixesadd=.f08,.f03,.f95,.f90,.for,.f,.F,.f77,.ftn,.fpp
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'fortran'
setlocal syntax=fortran
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=132
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 20 - ((0 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
20
normal! 0
lcd ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template
wincmd w
exe '1resize ' . ((&lines * 24 + 25) / 50)
exe 'vert 1resize ' . ((&columns * 60 + 93) / 186)
exe '2resize ' . ((&lines * 22 + 25) / 50)
exe 'vert 2resize ' . ((&columns * 60 + 93) / 186)
exe '3resize ' . ((&lines * 24 + 25) / 50)
exe 'vert 3resize ' . ((&columns * 120 + 93) / 186)
exe '4resize ' . ((&lines * 24 + 25) / 50)
exe 'vert 4resize ' . ((&columns * 4 + 93) / 186)
exe '5resize ' . ((&lines * 22 + 25) / 50)
exe 'vert 5resize ' . ((&columns * 120 + 93) / 186)
exe '6resize ' . ((&lines * 22 + 25) / 50)
exe 'vert 6resize ' . ((&columns * 4 + 93) / 186)
tabnext
edit ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/roe.F90
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 69 + 93) / 186)
exe 'vert 2resize ' . ((&columns * 116 + 93) / 186)
argglobal
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:!
setlocal commentstring=!%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'fortran'
setlocal filetype=fortran
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=cqrn1t
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\c#\\=\\s*include\\s\\+
setlocal includeexpr=
setlocal indentexpr=FortranGetFreeIndent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e,=~end,=~case,=~if,=~else,=~do,=~where,=~elsewhere,=~select,=~endif,=~enddo,=~endwhere,=~endselect,=~elseif,=~type,=~interface,=~forall,=~associate,=~block,=~enum,=~endforall,=~endassociate,=~endblock,=~endenum
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(5)')
setlocal suffixesadd=.f08,.f03,.f95,.f90,.for,.f,.F,.f77,.ftn,.fpp
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'fortran'
setlocal syntax=fortran
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=132
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 12 - ((11 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
12
normal! 0
wincmd w
argglobal
if bufexists("~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_PLM.F90") | buffer ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_PLM.F90 | else | edit ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_PLM.F90 | endif
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:!
setlocal commentstring=!%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'fortran'
setlocal filetype=fortran
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=cqrn1t
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\c#\\=\\s*include\\s\\+
setlocal includeexpr=
setlocal indentexpr=FortranGetFreeIndent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e,=~end,=~case,=~if,=~else,=~do,=~where,=~elsewhere,=~select,=~endif,=~enddo,=~endwhere,=~endselect,=~elseif,=~type,=~interface,=~forall,=~associate,=~block,=~enum,=~endforall,=~endassociate,=~endblock,=~endenum
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(6)')
setlocal suffixesadd=.f08,.f03,.f95,.f90,.for,.f,.F,.f77,.ftn,.fpp
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'fortran'
setlocal syntax=fortran
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=132
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 69 + 93) / 186)
exe 'vert 2resize ' . ((&columns * 116 + 93) / 186)
tabnext
edit ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/definition.h
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 23 + 25) / 50)
exe 'vert 1resize ' . ((&columns * 93 + 93) / 186)
exe '2resize ' . ((&lines * 23 + 25) / 50)
exe 'vert 2resize ' . ((&columns * 93 + 93) / 186)
exe '3resize ' . ((&lines * 23 + 25) / 50)
exe 'vert 3resize ' . ((&columns * 92 + 93) / 186)
exe '4resize ' . ((&lines * 23 + 25) / 50)
exe 'vert 4resize ' . ((&columns * 92 + 93) / 186)
argglobal
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal cindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=^\\s*#\\s*define
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'cpp'
setlocal filetype=cpp
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=n1croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\s*#\\s*include
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=ccomplete#Complete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(1)')
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'cpp'
setlocal syntax=cpp
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=79
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
argglobal
if bufexists("~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/grid_init.F90") | buffer ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/grid_init.F90 | else | edit ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/grid_init.F90 | endif
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:!
setlocal commentstring=!%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'fortran'
setlocal filetype=fortran
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=cqrn1t
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\c#\\=\\s*include\\s\\+
setlocal includeexpr=
setlocal indentexpr=FortranGetFreeIndent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e,=~end,=~case,=~if,=~else,=~do,=~where,=~elsewhere,=~select,=~endif,=~enddo,=~endwhere,=~endselect,=~elseif,=~type,=~interface,=~forall,=~associate,=~block,=~enum,=~endforall,=~endassociate,=~endblock,=~endenum
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(2)')
setlocal suffixesadd=.f08,.f03,.f95,.f90,.for,.f,.F,.f77,.ftn,.fpp
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'fortran'
setlocal syntax=fortran
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=132
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 34 - ((13 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
34
normal! 032|
wincmd w
argglobal
if bufexists("~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/slug.init") | buffer ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/slug.init | else | edit ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/slug.init | endif
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:#
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'conf'
setlocal filetype=conf
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=n1croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(3)')
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'conf'
setlocal syntax=conf
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=79
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 12 - ((4 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
12
normal! 011|
wincmd w
argglobal
if bufexists("~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/sim_initBlock.F90") | buffer ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/sim_initBlock.F90 | else | edit ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/sim_initBlock.F90 | endif
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:!
setlocal commentstring=!%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'fortran'
setlocal filetype=fortran
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=cqrn1t
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\c#\\=\\s*include\\s\\+
setlocal includeexpr=
setlocal indentexpr=FortranGetFreeIndent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e,=~end,=~case,=~if,=~else,=~do,=~where,=~elsewhere,=~select,=~endif,=~enddo,=~endwhere,=~endselect,=~elseif,=~type,=~interface,=~forall,=~associate,=~block,=~enum,=~endforall,=~endassociate,=~endblock,=~endenum
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(4)')
setlocal suffixesadd=.f08,.f03,.f95,.f90,.for,.f,.F,.f77,.ftn,.fpp
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'fortran'
setlocal syntax=fortran
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=132
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
exe '1resize ' . ((&lines * 23 + 25) / 50)
exe 'vert 1resize ' . ((&columns * 93 + 93) / 186)
exe '2resize ' . ((&lines * 23 + 25) / 50)
exe 'vert 2resize ' . ((&columns * 93 + 93) / 186)
exe '3resize ' . ((&lines * 23 + 25) / 50)
exe 'vert 3resize ' . ((&columns * 92 + 93) / 186)
exe '4resize ' . ((&lines * 23 + 25) / 50)
exe 'vert 4resize ' . ((&columns * 92 + 93) / 186)
tabnext
edit ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/averageState.F90
set splitbelow splitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:!
setlocal commentstring=!%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'fortran'
setlocal filetype=fortran
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=cqrn1t
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\c#\\=\\s*include\\s\\+
setlocal includeexpr=
setlocal indentexpr=FortranGetFreeIndent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e,=~end,=~case,=~if,=~else,=~do,=~where,=~elsewhere,=~select,=~endif,=~enddo,=~endwhere,=~endselect,=~elseif,=~type,=~interface,=~forall,=~associate,=~block,=~enum,=~endforall,=~endassociate,=~endblock,=~endenum
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(7)')
setlocal suffixesadd=.f08,.f03,.f95,.f90,.for,.f,.F,.f77,.ftn,.fpp
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'fortran'
setlocal syntax=fortran
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=132
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 11 - ((10 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
11
normal! 02|
tabnext
edit ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/makefile
set splitbelow splitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=sO:#\ -,mO:#\ \ ,b:#
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=1
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'make'
setlocal filetype=make
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=n1croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=^\\s*include
setlocal includeexpr=
setlocal indentexpr=GetMakeIndent()
setlocal indentkeys=!^F,o,O,<:>,=else,=endif
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=%!py3eval('powerline.statusline(9)')
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'make'
setlocal syntax=make
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=79
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 5 - ((4 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
5
normal! 016|
tabnext 6
set stal=1
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/cfd/cfd/advect1d/utils.py
badd +12 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/code/advect.py
badd +258 ~/ucsc/master-2/quarter-1/computational-fluids/cfd/cfd/advect1d/euler.py
badd +104 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/eigensystem.F90
badd +28 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/driver_euler1d.F90
badd +14 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/roe.F90
badd +13 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/grid_data.F90
badd +3 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/averageState.F90
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/makefile
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/cfd/cfd/scalar.py
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_FOG.F90
badd +9 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_ReconEvolveAvg.F90
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_reconstruct.F90
badd +21 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_getFlux.F90
badd +19 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_update.F90
badd +89 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/soln_PLM.F90
badd +0 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/grid_init.F90
badd +5 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/slug.init
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/sim_initBlock.F90
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/slopeLimiter.F90
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/eos.F90
badd +26 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/hll.F90
badd +28 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/bc.F90
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/cfl.F90
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/definition.h
badd +25 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/sim_init.F90
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/primconsflux.F90
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/cfd/cfd/advect1d/limiters.py
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/io.F90
badd +27 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_04/template/sim_data.F90
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOS
set winminheight=1 winminwidth=1
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
