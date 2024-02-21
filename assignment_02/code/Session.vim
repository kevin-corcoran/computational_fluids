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
vnoremap  :w xclip -i -sel c
nnoremap  : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &':redraw!
nmap  h
xmap  h
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
nnoremap / /\v
nmap H gT
nmap L gt
omap <silent> [% <Plug>(MatchitOperationMultiBackward)
xmap <silent> [% <Plug>(MatchitVisualMultiBackward)
nmap <silent> [% <Plug>(MatchitNormalMultiBackward)
omap \  :let @/='' " clear search
xmap \  :let @/='' " clear search
nmap \  :let @/='' " clear search
omap \q gqip
xmap \q gqip
nmap \q gqip
omap \l :set list! " Toggle tabs and EOL
xmap \l :set list! " Toggle tabs and EOL
nmap \l :set list! " Toggle tabs and EOL
omap <silent> ]% <Plug>(MatchitOperationMultiForward)
xmap <silent> ]% <Plug>(MatchitVisualMultiForward)
nmap <silent> ]% <Plug>(MatchitNormalMultiForward)
xmap a% <Plug>(MatchitVisualTextObject)
xmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
omap <silent> g% <Plug>(MatchitOperationBackward)
xmap <silent> g% <Plug>(MatchitVisualBackward)
nmap <silent> g% <Plug>(MatchitNormalBackward)
nnoremap j gj
nnoremap k gk
nnoremap mt :call MoveToNextTab()
nnoremap mT :call MoveToPrevTab()
nnoremap <Plug>(-fzf-:) :
nnoremap <Plug>(-fzf-/) /
nnoremap <Plug>(-fzf-vim-do) :execute g:__fzf_command
nmap <C-H> h
xmap <C-H> h
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
vnoremap <C-C> :w xclip -i -sel c
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
set wildmenu
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/ucsc/master-2/quarter-1/computational-fluids/assignment_02/code
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd DiffyQ.f90
$argadd Driver_DiffyQ.f90
set stal=2
tabnew
tabnew
tabnew
tabnew
tabrewind
edit output.txt
set splitbelow splitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
if bufexists("output.txt") | buffer output.txt | else | edit output.txt | endif
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
setlocal comments=fb:-,fb:*,n:>
setlocal commentstring=
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
if &filetype != 'text'
setlocal filetype=text
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
setlocal statusline=%!py3eval('powerline.statusline(5)')
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'text'
setlocal syntax=text
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
let s:l = 5 - ((4 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
5
normal! 011|
tabnext
edit Driver_DiffyQ.f90
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
exe 'vert 1resize ' . ((&columns * 82 + 91) / 183)
exe 'vert 2resize ' . ((&columns * 100 + 91) / 183)
argglobal
if bufexists("Driver_DiffyQ.f90") | buffer Driver_DiffyQ.f90 | else | edit Driver_DiffyQ.f90 | endif
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
setlocal statusline=%!py3eval('powerline.statusline(3)')
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
let s:l = 70 - ((37 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
70
normal! 027|
wincmd w
argglobal
if bufexists("DiffyQ.f90") | buffer DiffyQ.f90 | else | edit DiffyQ.f90 | endif
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
setlocal spell
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
let s:l = 76 - ((0 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
76
normal! 026|
wincmd w
exe 'vert 1resize ' . ((&columns * 82 + 91) / 183)
exe 'vert 2resize ' . ((&columns * 100 + 91) / 183)
tabnext
edit makefile
set splitbelow splitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
if bufexists("makefile") | buffer makefile | else | edit makefile | endif
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
setlocal statusline=%!py3eval('powerline.statusline(7)')
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
let s:l = 8 - ((7 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
8
normal! 029|
tabnext
edit LA/Driver_LinAl.f90
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
exe 'vert 1resize ' . ((&columns * 91 + 91) / 183)
exe 'vert 2resize ' . ((&columns * 94 + 91) / 183)
argglobal
if bufexists("LA/Driver_LinAl.f90") | buffer LA/Driver_LinAl.f90 | else | edit LA/Driver_LinAl.f90 | endif
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
setlocal statusline=%!py3eval('powerline.statusline(1)')
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
let s:l = 46 - ((38 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
46
normal! 0
wincmd w
argglobal
if bufexists("LA/LinAl.f90") | buffer LA/LinAl.f90 | else | edit LA/LinAl.f90 | endif
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
let s:l = 411 - ((3 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
411
normal! 0
lcd ~/ucsc/master-2/quarter-1/computational-fluids/assignment_02/code
wincmd w
exe 'vert 1resize ' . ((&columns * 91 + 91) / 183)
exe 'vert 2resize ' . ((&columns * 94 + 91) / 183)
tabnext
edit ~/UCSC/am_213b/am213b/Assignments/assignment_5/code/prob3.jl
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
exe 'vert 1resize ' . ((&columns * 44 + 91) / 183)
exe 'vert 2resize ' . ((&columns * 45 + 91) / 183)
argglobal
if bufexists("~/UCSC/am_213b/am213b/Assignments/assignment_5/code/prob3.jl") | buffer ~/UCSC/am_213b/am213b/Assignments/assignment_5/code/prob3.jl | else | edit ~/UCSC/am_213b/am213b/Assignments/assignment_5/code/prob3.jl | endif
let s:cpo_save=&cpo
set cpo&vim
cnoremap <buffer> <expr> <S-Tab> LaTeXtoUnicode#CmdTab(128)
xnoremap <buffer> <nowait> <silent> [[ :let b:jlblk_count=v:count1gv:call julia_blocks#vwrapper_move("julia_blocks#moveblock_p")
onoremap <buffer> <nowait> <silent> [[ :let b:jlblk_count=v:count1:call julia_blocks#owrapper_move(v:operator, "julia_blocks#moveblock_p", 0, 1)
nnoremap <buffer> <nowait> <silent> [[ :let b:jlblk_count=v:count1 | call julia_blocks#moveblock_p()
xnoremap <buffer> <nowait> <silent> [] :let b:jlblk_count=v:count1gv:call julia_blocks#vwrapper_move("julia_blocks#moveblock_P")
onoremap <buffer> <nowait> <silent> [] :let b:jlblk_count=v:count1:call julia_blocks#owrapper_move(v:operator, "julia_blocks#moveblock_P", 1, 1)
nnoremap <buffer> <nowait> <silent> [] :let b:jlblk_count=v:count1 | call julia_blocks#moveblock_P()
xnoremap <buffer> <nowait> <silent> [j :let b:jlblk_count=v:count1gv:call julia_blocks#vwrapper_move("julia_blocks#move_p")
onoremap <buffer> <nowait> <silent> [j :let b:jlblk_count=v:count1:call julia_blocks#owrapper_move(v:operator, "julia_blocks#move_p", 0, 1)
nnoremap <buffer> <nowait> <silent> [j :let b:jlblk_count=v:count1 | call julia_blocks#move_p()
xnoremap <buffer> <nowait> <silent> [J :let b:jlblk_count=v:count1gv:call julia_blocks#vwrapper_move("julia_blocks#move_P")
onoremap <buffer> <nowait> <silent> [J :let b:jlblk_count=v:count1:call julia_blocks#owrapper_move(v:operator, "julia_blocks#move_P", 1, 1)
nnoremap <buffer> <nowait> <silent> [J :let b:jlblk_count=v:count1 | call julia_blocks#move_P()
xnoremap <buffer> <nowait> <silent> ]] :let b:jlblk_count=v:count1gv:call julia_blocks#vwrapper_move("julia_blocks#moveblock_n")
onoremap <buffer> <nowait> <silent> ]] :let b:jlblk_count=v:count1:call julia_blocks#owrapper_move(v:operator, "julia_blocks#moveblock_n", 0, 0)
nnoremap <buffer> <nowait> <silent> ]] :let b:jlblk_count=v:count1 | call julia_blocks#moveblock_n()
xnoremap <buffer> <nowait> <silent> ]j :let b:jlblk_count=v:count1gv:call julia_blocks#vwrapper_move("julia_blocks#move_n")
onoremap <buffer> <nowait> <silent> ]j :let b:jlblk_count=v:count1:call julia_blocks#owrapper_move(v:operator, "julia_blocks#move_n", 0, 0)
nnoremap <buffer> <nowait> <silent> ]j :let b:jlblk_count=v:count1 | call julia_blocks#move_n()
xnoremap <buffer> <nowait> <silent> ][ :let b:jlblk_count=v:count1gv:call julia_blocks#vwrapper_move("julia_blocks#moveblock_N")
onoremap <buffer> <nowait> <silent> ][ :let b:jlblk_count=v:count1:call julia_blocks#owrapper_move(v:operator, "julia_blocks#moveblock_N", 1, 0)
nnoremap <buffer> <nowait> <silent> ][ :let b:jlblk_count=v:count1 | call julia_blocks#moveblock_N()
xnoremap <buffer> <nowait> <silent> ]J :let b:jlblk_count=v:count1gv:call julia_blocks#vwrapper_move("julia_blocks#move_N")
onoremap <buffer> <nowait> <silent> ]J :let b:jlblk_count=v:count1:call julia_blocks#owrapper_move(v:operator, "julia_blocks#move_N", 1, 0)
nnoremap <buffer> <nowait> <silent> ]J :let b:jlblk_count=v:count1 | call julia_blocks#move_N()
xnoremap <buffer> <nowait> <silent> aj :let b:jlblk_inwrapper=1:let b:jlblk_count=max([v:prevcount,1]):call julia_blocks#vwrapper_select("julia_blocks#select_a")
onoremap <buffer> <nowait> <silent> aj :let b:jlblk_inwrapper=1:let b:jlblk_count=max([v:prevcount,1]):call julia_blocks#owrapper_select(v:operator, "julia_blocks#select_a")
xnoremap <buffer> <nowait> <silent> ij :let b:jlblk_inwrapper=1:let b:jlblk_count=max([v:prevcount,1]):call julia_blocks#vwrapper_select("julia_blocks#select_i")
onoremap <buffer> <nowait> <silent> ij :let b:jlblk_inwrapper=1:let b:jlblk_count=max([v:prevcount,1]):call julia_blocks#owrapper_select(v:operator, "julia_blocks#select_i")
nnoremap <buffer> <silent> <Plug>(JuliaDocPrompt) :call julia#doc#prompt()
cnoremap <buffer> <expr> 	 LaTeXtoUnicode#CmdTab(9)
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
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=#1
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:#
setlocal commentstring=#=%s=#
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
setlocal define=^\\s*macro\\>
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'julia'
setlocal filetype=julia
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
setlocal include=^\\s*\\%(reload\\|include\\)\\>
setlocal includeexpr=
setlocal indentexpr=GetJuliaIndent()
setlocal indentkeys=0),0],!^F,o,O,e,=end,=else,=catch,=finally,),],}
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=:JuliaDocKeywordprg
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
setlocal suffixesadd=.jl
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'julia'
setlocal syntax=julia
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
let s:l = 26 - ((21 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
26
normal! 0
wincmd w
argglobal
if bufexists("~/UCSC/am_213b/am213b/Assignments/assignment_5/code/DiffyQ.jl") | buffer ~/UCSC/am_213b/am213b/Assignments/assignment_5/code/DiffyQ.jl | else | edit ~/UCSC/am_213b/am213b/Assignments/assignment_5/code/DiffyQ.jl | endif
let s:cpo_save=&cpo
set cpo&vim
cnoremap <buffer> <expr> <S-Tab> LaTeXtoUnicode#CmdTab(128)
xnoremap <buffer> <nowait> <silent> [[ :let b:jlblk_count=v:count1gv:call julia_blocks#vwrapper_move("julia_blocks#moveblock_p")
onoremap <buffer> <nowait> <silent> [[ :let b:jlblk_count=v:count1:call julia_blocks#owrapper_move(v:operator, "julia_blocks#moveblock_p", 0, 1)
nnoremap <buffer> <nowait> <silent> [[ :let b:jlblk_count=v:count1 | call julia_blocks#moveblock_p()
xnoremap <buffer> <nowait> <silent> [] :let b:jlblk_count=v:count1gv:call julia_blocks#vwrapper_move("julia_blocks#moveblock_P")
onoremap <buffer> <nowait> <silent> [] :let b:jlblk_count=v:count1:call julia_blocks#owrapper_move(v:operator, "julia_blocks#moveblock_P", 1, 1)
nnoremap <buffer> <nowait> <silent> [] :let b:jlblk_count=v:count1 | call julia_blocks#moveblock_P()
xnoremap <buffer> <nowait> <silent> [j :let b:jlblk_count=v:count1gv:call julia_blocks#vwrapper_move("julia_blocks#move_p")
onoremap <buffer> <nowait> <silent> [j :let b:jlblk_count=v:count1:call julia_blocks#owrapper_move(v:operator, "julia_blocks#move_p", 0, 1)
nnoremap <buffer> <nowait> <silent> [j :let b:jlblk_count=v:count1 | call julia_blocks#move_p()
xnoremap <buffer> <nowait> <silent> [J :let b:jlblk_count=v:count1gv:call julia_blocks#vwrapper_move("julia_blocks#move_P")
onoremap <buffer> <nowait> <silent> [J :let b:jlblk_count=v:count1:call julia_blocks#owrapper_move(v:operator, "julia_blocks#move_P", 1, 1)
nnoremap <buffer> <nowait> <silent> [J :let b:jlblk_count=v:count1 | call julia_blocks#move_P()
xnoremap <buffer> <nowait> <silent> ]] :let b:jlblk_count=v:count1gv:call julia_blocks#vwrapper_move("julia_blocks#moveblock_n")
onoremap <buffer> <nowait> <silent> ]] :let b:jlblk_count=v:count1:call julia_blocks#owrapper_move(v:operator, "julia_blocks#moveblock_n", 0, 0)
nnoremap <buffer> <nowait> <silent> ]] :let b:jlblk_count=v:count1 | call julia_blocks#moveblock_n()
xnoremap <buffer> <nowait> <silent> ]j :let b:jlblk_count=v:count1gv:call julia_blocks#vwrapper_move("julia_blocks#move_n")
onoremap <buffer> <nowait> <silent> ]j :let b:jlblk_count=v:count1:call julia_blocks#owrapper_move(v:operator, "julia_blocks#move_n", 0, 0)
nnoremap <buffer> <nowait> <silent> ]j :let b:jlblk_count=v:count1 | call julia_blocks#move_n()
xnoremap <buffer> <nowait> <silent> ][ :let b:jlblk_count=v:count1gv:call julia_blocks#vwrapper_move("julia_blocks#moveblock_N")
onoremap <buffer> <nowait> <silent> ][ :let b:jlblk_count=v:count1:call julia_blocks#owrapper_move(v:operator, "julia_blocks#moveblock_N", 1, 0)
nnoremap <buffer> <nowait> <silent> ][ :let b:jlblk_count=v:count1 | call julia_blocks#moveblock_N()
xnoremap <buffer> <nowait> <silent> ]J :let b:jlblk_count=v:count1gv:call julia_blocks#vwrapper_move("julia_blocks#move_N")
onoremap <buffer> <nowait> <silent> ]J :let b:jlblk_count=v:count1:call julia_blocks#owrapper_move(v:operator, "julia_blocks#move_N", 1, 0)
nnoremap <buffer> <nowait> <silent> ]J :let b:jlblk_count=v:count1 | call julia_blocks#move_N()
xnoremap <buffer> <nowait> <silent> aj :let b:jlblk_inwrapper=1:let b:jlblk_count=max([v:prevcount,1]):call julia_blocks#vwrapper_select("julia_blocks#select_a")
onoremap <buffer> <nowait> <silent> aj :let b:jlblk_inwrapper=1:let b:jlblk_count=max([v:prevcount,1]):call julia_blocks#owrapper_select(v:operator, "julia_blocks#select_a")
xnoremap <buffer> <nowait> <silent> ij :let b:jlblk_inwrapper=1:let b:jlblk_count=max([v:prevcount,1]):call julia_blocks#vwrapper_select("julia_blocks#select_i")
onoremap <buffer> <nowait> <silent> ij :let b:jlblk_inwrapper=1:let b:jlblk_count=max([v:prevcount,1]):call julia_blocks#owrapper_select(v:operator, "julia_blocks#select_i")
nnoremap <buffer> <silent> <Plug>(JuliaDocPrompt) :call julia#doc#prompt()
cnoremap <buffer> <expr> 	 LaTeXtoUnicode#CmdTab(9)
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
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=#1
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:#
setlocal commentstring=#=%s=#
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
setlocal define=^\\s*macro\\>
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'julia'
setlocal filetype=julia
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
setlocal include=^\\s*\\%(reload\\|include\\)\\>
setlocal includeexpr=
setlocal indentexpr=GetJuliaIndent()
setlocal indentkeys=0),0],!^F,o,O,e,=end,=else,=catch,=finally,),],}
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=:JuliaDocKeywordprg
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
setlocal suffixesadd=.jl
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'julia'
setlocal syntax=julia
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
let s:l = 309 - ((0 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
309
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 44 + 91) / 183)
exe 'vert 2resize ' . ((&columns * 45 + 91) / 183)
tabnext 2
set stal=1
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_02/code/output.txt
badd +76 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_02/code/DiffyQ.f90
badd +14 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_02/code/Driver_DiffyQ.f90
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_02/code/LA/Driver_LinAl.f90
badd +1 ~/UCSC/am_213b/am213b/Assignments/assignment_5/code/prob3.jl
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_02/code/LA/LinAl.f90
badd +309 ~/UCSC/am_213b/am213b/Assignments/assignment_5/code/DiffyQ.jl
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_02/code/sol.dat
badd +19 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_02/code/julPlot.jl
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_02/code/Amat.dat
badd +4 ~/UCSC/am_213b/am213b/Assignments/assignment_5/code/prob5.jl
badd +1 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_02/code/sol.gif
badd +9 ~/ucsc/master-2/quarter-1/computational-fluids/assignment_02/code/makefile
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
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
