set t_Co=256
set number
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4 " when hitting tab or backspace, how many spaces
                  "should a tab be (see expandtab)
set showcmd
set ignorecase
set smartcase 		" Intelligent case-smart searching
set gdefault
set hidden
set ruler
"set foldmethod=syntax
set foldmethod=expr
set foldlevel=100
set ttyfast
set virtualedit+=block
set enc=utf-8
set guioptions=
"set splitbelow
syntax on

let g:mapleader = ","
let g:maplocalleader = ","
let g:LatexBox_Folding=1

nnoremap <silent> <c-n> :NERDTreeToggle<CR>
nnoremap <silent> <leader>tt :TagbarToggle<CR>
nnoremap <Space> za

let g:UltiSnipsEditSplit = "vertical"

let g:languagetool_jar='/Users/andreas/Downloads/LanguageTool/LanguageTool.jar'

let g:LatexBox_latexmk_options = "-pdf -pvc"

let g:slime_target = "tmux"

" Clang Complete Settings
"let g:clang_library_path='/opt/local/libexec/llvm-3.2/lib'
let g:clang_use_library=0
let g:clang_complete_copen=1
let g:clang_complete_macros=1
let g:clang_complete_patterns=0
let g:clang_complete_auto=0
let g:clang_snippets=1
" Avoids lame path cache generation and other unknown sources for includes 
"let g:clang_auto_user_options=''
let g:clang_memory_percent=80
let g:clang_debug=1
"let g:neocomplcache_force_overwrite_completefunc=1

"set conceallevel=2
"set concealcursor=vin
let g:clang_snippets=1
"let g:clang_conceal_snippets=1
" The single one that works with clang_complete
let g:clang_snippets_engine='ultisnips'
nnoremap <Leader>uu :call g:ClangUpdateQuickFix()<CR>

map <c-w><c-t> :WMToggle<cr>

fun! SetupVAM()
    " YES, you can customize this vam_install_path path and everything still works!
    let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
    exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

    " * unix based os users may want to use this code checking out VAM
    " * windows users want to use http://mawercer.de/~marc/vam/index.php
    "   to fetch VAM, VAM-known-repositories and the listed plugins
    "   without having to install curl, unzip, git tool chain first
    " -> BUG [4] (git-less installation)
    if !filereadable(vam_install_path.'/vim-addon-manager/.git/config') && 1 == confirm("git clone VAM into ".vam_install_path."?","&Y\n&N")
        " I'm sorry having to add this reminder. Eventually it'll pay off.
        call confirm("Remind yourself that most plugins ship with documentation (README*, doc/*.txt). Its your first source of knowledge. If you can't find the info you're looking for in reasonable time ask maintainers to improve documentation")
        exec '!p='.shellescape(vam_install_path).'; mkdir -p "$p" && cd "$p" && git clone --depth 1 git://github.com/MarcWeber/vim-addon-manager.git'
        " VAM run helptags automatically if you install or update plugins
        exec 'helptags '.fnameescape(vam_install_path.'/vim-addon-manager/doc')
    endif

    call vam#ActivateAddons(['vimproc', 'a',
\    'current-func-info', 'Tabular', 'fugitive', 'cmake%599', 'cmake%600',
\    'showmarks', 'vimoutliner-colorscheme-fix', 'TVO_The_Vim_Outliner',
\    'The_NERD_tree', 'github:majutsushi/tagbar', 'The_NERD_Commenter',
\    'surround', 'Mustang2', 'delimitMate', 'vim-addon-local-vimrc',
\    'rainbow_parentheses', 'extradite', 'quickfixsigns', 'EasyMotion',
\    'vim-scala@behaghel', 'vim-addon-sbt', 'Mustang2', 'vimwiki',
\    'github:LaTeX-Box-Team/LaTeX-Box', 'github:tobig/clang_complete',
\    'github:jpalardy/vim-slime', 'unite', 'unite-outline', 'unite-ack', 
\    'UltiSnips', 'surround'], {'auto_install' : 1})
    " , 'DirDiff'
endfun
call SetupVAM()

if has("mac")
    "set transparency=10
    set guifont=monaco:h10
    set noantialias
    set vb
endif

let g:molokai_original=1
"colorscheme wombat256mod
"colorscheme molokai
colorscheme Mustang

if has("mac")
    "set transparency=10
    "set guifont=monaco:h10
    "set noantialias
    set vb
endif

" Complete options (disable preview scratch window)
set completeopt=longest,menuone ",preview
set pumheight=15
set nocompatible

filetype plugin indent on

cmap W! w !sudo tee % >/dev/null

" Better Search
set hlsearch
set incsearch

cabbrev help tab help

" keep some more lines for scope
set scrolloff=5

set wildmenu
set mouse=a " use mouse everywhere
set wildmode=list:longest " turn on wild mode huge list
set backspace=indent,eol,start " make backspace a more flexible

" set list
set listchars=tab:>-,trail:- " show tabs and trailing

set showcmd " show the command being typed
set showmatch " show matching brackets

" Folding background
hi Folded guibg=bg

" Vim-Latex {{{

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files
" defaults to 'plaintex' instead of 'tex', which results in vim-latex
" not being loaded.  The following changes the default filetype back to
" 'tex':
let g:tex_flavor='latex'

" Vim-LaTex settings
 let g:Tex_SmartKeyQuote = 0
"
" let g:Tex_GotoError=0 " don't go automaticly to first error
" Note: latex/suitecompiler.vim, at line 605, calls 'cfile', which will
"       cause the insertion point to jump to the beginning of the line.
"       I've changed this to call 'cgetfile' instead.
"
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'pdf'
let g:Tex_PromptedEnvironments = 'equation,equation*,align,align*,figure,figure*,subfigure'

if has("unix") && match(system("uname"),'Darwin') != -1
    " Debug: echo "Mac!"
    let g:Tex_ViewRule_pdf = 'open -a Skim.app'
    "let g:Tex_CompileRule_pdf = 'pdflatex -file-line-error -interaction nonstopmode $* -synctex=1'
    let g:Tex_CompileRule_pdf = 'latexmk -pdf -silent $*'
else
    " Debug: echo "Not a Mac!"
endif

"let g:Tex_ViewRule_pdf = 'kpdf'
    "
"set errorformat=%f:%l:\ %m
" let g:Tex_CompileRule_bib = '/opt/local/bin/biber $'
"let g:Tex_CompileRule_pdf = 'rubber $*'

" Vim-Latex Custom Macros (http://tiny.cc/7Pbwu) {
" lets latex-suite compile the file automatically when the buffer is saved
" au BufWritePost *.tex call Tex_RunLaTeX()

" if exists('*IMAP')
"    augroup MyIMAPs
"      au!
"      au VimEnter * call IMAP('veps', "\\varepsilon",'tex')
"      au VimEnter * call IMAP('CRE', "\hat{a}_{}^{\\dagger}",'tex')
"      au VimEnter * call IMAP('ANI', "\hat{a}_{<++>}",'tex')
"
"      au VimEnter * call IMAP('EAL', "\\begin{align}\<CR><++>\<CR>\\end{align}<++>",'tex')
"
"      au VimEnter * call IMAP('EFE', "\\begin{figure}\<CR><++>\<CR>\\end{figure}<++>", 'tex')
"      au VimEnter * call IMAP('MAT', "\\begin{bmatrix}<++>\\end{bmatrix}<++>", 'tex')
"      au VimEnter * call IMAP('DET', "\\begin{vmatrix}<++>\\end{vmatrix}<++>", 'tex')
"      au VimEnter * call IMAP('SUBFI', "\\begin{figure}[htbp]\<CR>\\centering\<CR>\\subfigure[<+Title 1+>]{\<CR>\\includegraphics[width=7cm]{<+File 1+>}\<CR>\\label{fig:<+Label 1+>}\<CR>}\<CR>\\subfigure[<+Title 2+>]{\<CR>\\includegraphics[width=7cm]{<+File 2+>}\<CR>\\label{fig:<+Label 2+>}\<CR>}\<CR>\\caption{<+Main caption+>}\<CR>\\label{fig:<+Label+>}\<CR>\\end{figure}\<CR><++>", 'tex')

"    augroup END
" endif

" }

"}}}

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :tabe $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nmap <silent> <leader>ez :tabe ~/.zshrc<CR>

nnoremap j gj
nnoremap k gk

vnoremap <           <gv
vnoremap >           >gv

" map <C-u> <esc>:tabprevious<cr>
" map <C-i> <esc>:tabnext<cr>
"

"
" History and backup
"
set viminfo='10,:20,\"100,n~/.viminfo
set history=1000
set nobackup
set nowritebackup
set noswapfile

"
" Persistent-undo (vim 7.3)
"
if has("persistend_undo")
    set undofile
    set undodir=/tmp
endif

set clipboard=unnamed
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp


" ,s to show trailing whitespace
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

:noremap <S-h> :bprev<CR>
:noremap <S-l> :bnext<CR>

:noremap <Leader>w :w<cr>
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
    else
        execute "copen"
    endif
endfunction

augroup QFixToggle
    autocmd!
    autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
    autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END

noremap <silent><leader>qq <Esc>:call QFixToggle(0)<CR>
noremap <silent><leader>r <Esc>:RainbowParenthesesToggleAll<CR>

set laststatus=2

" strip all trailing whitespace from file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
"nnoremap <leader>a :%! astyle --style=kr --indent=spaces=4 --pad-oper --unpad-paren --pad-header --add-brackets --align-pointer=name  --lineend=linux

inoremap jj <ESC>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

nmap <leader>aa :A<cr>
nmap <leader>as :AS<cr>
nmap <leader>av :AV<cr>
nmap <leader>an :AN<cr>
nmap <leader>ai :AI<cr>

nmap <leader>ac :Tabularize /,\zs/l0l1<cr>
vmap <leader>ac :Tabularize /,\zs/l0l1<cr>

nmap <leader>a' :Tabularize /^[^']*/l0l1<cr>
vmap <leader>a' :Tabularize /^[^']*/l0l1<cr>

nmap <leader>a& :Tabularize /&/l1l1<cr>
vmap <leader>a& :Tabularize /&/l1l1<cr>

nmap <leader>a= :Tabularize /=<cr>
vmap <leader>a= :Tabularize /=<cr>

nmap <leader>mm :make<cr>
vmap <leader>mm :make<cr>

nmap <leader>mp :exec "!makebg" v:servername "'" . &makeprg . "'" &makeef<CR><CR>
nmap <leader>mc :exec "!rm " &makeef "; makebg" v:servername "'" . &makeprg . "'"  &makeef<CR><CR> 

command! -nargs=1 OpenURL :call OpenURL(<q-args>)
" open URL under cursor in browser
nnoremap <leader>gb :OpenURL <cfile><CR>
nnoremap <leader>gA :OpenURL http://www.answers.com/<cword><CR>
nnoremap <leader>gG :OpenURL http://www.google.com/search?q=<cword><CR>
nnoremap <leader>gW :OpenURL http://en.wikipedia.org/wiki/Special:Search?search=<cword><CR>

set makeprg=~/.vim-cmake-makeprg

map ü <C-]>
map ö [
map ä ]
map Ö {
map Ä }
map Ü /

:au! BufRead,BufNewFile *apple-gmux*/.* setlocal noet
nnoremap <silent> <leader>g :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

set tags=tags;/

if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
  let &listchars = "tab:\u21e5\u00b7,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
else
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<
endif

au BufNewFile,BufRead repl set filetype=scala

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Unite                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"call unite#custom_filters('file,file/new,buffer,file_rec', ['matcher_fuzzy', 'sorter_default', 'converter_default'])
"call unite#custom_filters('file', ['matcher_fuzzy', 'sorter_default', 'converter_default'])
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    <leader>f [unite]

nnoremap <silent> [unite]e  :<C-u>UniteWithCursorWord
\ -buffer-name=ack ack<CR>
nnoremap <silent> [unite]a  :<C-u>Unite
\ -buffer-name=ack ack<CR>
nnoremap <silent> [unite]c  :<C-u>Unite
\ -buffer-name=file_rec file_rec<CR>
"nnoremap <silent> [unite]b  :<C-u>UniteWithBufferDir
"\ -buffer-name=file_rec_buffer -prompt=%\ file_rec file_mru<CR>
nnoremap <silent> [unite]b  :<C-u>Unite
\ -buffer-name=buffers buffer_tab<CR>
nnoremap <silent> [unite]t  :<C-u>Unite
\ -buffer-name=buffers tab<CR>
nnoremap <silent> [unite]r  :<C-u>Unite
\ -buffer-name=register register<CR>
nnoremap <silent> [unite]o  :<C-u>Unite outline<CR>
nnoremap <silent> [unite]f
\ :<C-u>Unite -buffer-name=resume resume<CR>
nnoremap <silent> [unite]d
\ :<C-u>Unite -buffer-name=files -default-action=lcd directory_mru<CR>
nnoremap <silent> [unite]ma
\ :<C-u>Unite mapping<CR>
nnoremap <silent> [unite]me
\ :<C-u>Unite output:message<CR>
nnoremap <silent> [unite]r  :<C-u>UniteResume<CR>
nnoremap  [unite]f  :<C-u>Unite source<CR>
nnoremap <silent> [unite]l  :<C-u>Unite
\ -buffer-name=line line<CR>

nnoremap <silent> [unite]s
        \ :<C-u>Unite -buffer-name=files -no-split
        \ jump_point file_point buffer_tab
        \ file_rec:! file file/new file_mru<CR>


" Start insert.
let g:unite_enable_start_insert = 1
"let g:unite_enable_short_source_names = 1

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  " Overwrite settings.

  nmap <buffer> <ESC>      <Plug>(unite_exit)
  imap <buffer> jj      <Plug>(unite_insert_leave)
  "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

imap <buffer><expr> j unite#smart_map('j', '')
"imap <buffer> <TAB>   <Plug>(unite_select_next_line)
imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
imap <buffer> '     <Plug>(unite_quick_match_default_action)
nmap <buffer> '     <Plug>(unite_quick_match_default_action)
imap <buffer><expr> x
        \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
nmap <buffer> x     <Plug>(unite_quick_match_choose_action)
nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
nnoremap <silent><buffer><expr> l
        \ unite#smart_map('l', unite#do_action('default'))

let unite = unite#get_current_unite()
if unite.buffer_name =~# '^search'
  nnoremap <silent><buffer><expr> r     unite#do_action('replace')
else
  nnoremap <silent><buffer><expr> r     unite#do_action('rename')
endif

nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
\ empty(unite#mappings#get_current_filters()) ? ['sorter_reverse'] : [])
endfunction"}}}

"let g:vimfiler_as_default_explorer = 1
"let g:vimfiler_safe_mode_by_default = 0
"let g:vimfiler_tree_leaf_icon = ' '
"let g:vimfiler_tree_opened_icon = '▾'
"let g:vimfiler_tree_closed_icon = '▸'
"let g:vimfiler_file_icon = '-'
"let g:vimfiler_marked_file_icon = '*'

"autocmd VimEnter * if !argc() | VimFiler | endif

"nnoremap <silent> <c-n> :VimFiler -buffer-name=explorer -split -winwidth=50 -toggle -no-quit<CR>

"let g:neocomplcache_enable_at_startup = 1
autocmd FileType scala set shiftwidth=2 tabstop=2 softtabstop=2 expandtab
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"

nnoremap <leader>i :IndentGuidesToggle<CR>

" clean up windows file endings
nnoremap <leader>vl :%s/\r$<CR>
"nnoremap <leader>vi :%s/\#include <GL\/freeglut.h>/\#ifdef OSXGLUT\#include <glut.h>\#else\#include <GL\/freeglut.h>\#endif<CR>
nnoremap <leader>vi :%s/#include <GL\/freeglut.h>/\#ifdef OSXGLUT\#include <foo.h>#endif<CR>

au BufEnter *.scala setl formatprg=java\ -jar\ ~/Downloads/scalariform.jar\ --stdin\ --stdout

nnoremap <leader>oo :set guifont=monaco:h12<CR>:set antialias<CR>
nnoremap <leader>ol :set guifont=monaco:h10<CR>:set noantialias<CR>

au BufRead,BufNewFile *.pde set filetype=Cpp
au BufRead,BufNewFile *.ino set filetype=Cpp
