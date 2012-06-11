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
set foldmethod=syntax
set foldlevel=100
set ttyfast
set virtualedit+=block
set enc=utf-8
set guioptions=
set splitbelow
syntax on

let g:mapleader = ","

nnoremap <silent> <c-n> :NERDTreeToggle<CR>
nnoremap <silent> <c-i> :TagbarToggle<CR>
nnoremap <silent> <leader>tt :TagbarToggle<CR>

" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-p>"
let g:SuperTabLongestHighlight = "0"

let g:clang_periodic_quickfix = 1
let g:clang_snippets = 1
let g:clang_use_library = 1
let g:clang_library_path = "/usr/lib"

let g:clang_complete_auto = 0
let g:clang_hl_errors=1
let g:clang_debug=1

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

    call vam#ActivateAddons(['a', 'DirDiff', 'Gundo', 'Buffergator', 'current-func-info', 'FuzzyFinder', 'Tabular', 'fugitive', 'cmake%599', 'cmake%600', 'showmarks', 'TVO_The_Vim_Outliner', 'vimoutliner-colorscheme-fix', 'vim-latex', 'The_NERD_tree', 'github:majutsushi/tagbar', 'The_NERD_Commenter', 'surround', 'Mustang2', 'SuperTab%182', 'delimitMate', 'snipmate', 'snipmate-snippets', 'vim-addon-local-vimrc', 'github:Rip-Rip/clang_complete', 'rainbow_parentheses', 'extradite'], {'auto_install' : 1})
endfun
call SetupVAM()

if has("mac")
    "set transparency=10
    set guifont=monaco:h10
    set noantialias
    set vb
endif

colorscheme Mustang

if has("mac")
    "set transparency=10
    set guifont=monaco:h10
    set noantialias
    set vb
endif

" Complete options (disable preview scratch window)
set completeopt=longest,menuone,preview
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
" let g:Tex_SmartKeyQuote = 1
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
    augroup MyIMAPs
      au!
      au VimEnter * call IMAP('veps', "\\varepsilon",'tex')
      au VimEnter * call IMAP('CRE', "\hat{a}_{}^{\\dagger}",'tex')
      au VimEnter * call IMAP('ANI', "\hat{a}_{<++>}",'tex')

      au VimEnter * call IMAP('EAL', "\\begin{align}\<CR><++>\<CR>\\end{align}<++>",'tex')

      au VimEnter * call IMAP('EFE', "\\begin{figure}\<CR><++>\<CR>\\end{figure}<++>", 'tex')
      au VimEnter * call IMAP('MAT', "\\begin{bmatrix}<++>\\end{bmatrix}<++>", 'tex')
      au VimEnter * call IMAP('DET', "\\begin{vmatrix}<++>\\end{vmatrix}<++>", 'tex')
      au VimEnter * call IMAP('SUBFI', "\\begin{figure}[htbp]\<CR>\\centering\<CR>\\subfigure[<+Title 1+>]{\<CR>\\includegraphics[width=7cm]{<+File 1+>}\<CR>\\label{fig:<+Label 1+>}\<CR>}\<CR>\\subfigure[<+Title 2+>]{\<CR>\\includegraphics[width=7cm]{<+File 2+>}\<CR>\\label{fig:<+Label 2+>}\<CR>}\<CR>\\caption{<+Main caption+>}\<CR>\\label{fig:<+Label+>}\<CR>\\end{figure}\<CR><++>", 'tex')

    augroup END
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
set viminfo='10,:20,\"100,%,n~/.viminfo
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

map <leader>fb :FufBuffer<CR>
map <leader>ff :FufFile<CR>
map <leader>fd :FufDir<CR>
map <leader>ft :FufTag<CR>
map <leader>fc :FufCoverageFile<CR>
map <leader>fr :FufTagWithCursorWord!<CR>
map <leader>fl :FufLine<CR>

:noremap <S-h> :bprev<CR>
:noremap <S-l> :bnext<CR>

:noremap <Leader>w :w<cr>
:noremap <Leader>b :BuffergatorToggle<cr> 
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

let g:buffergator_autoexpand_on_split = 0

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

"nmap <leader>ac :Tabularize /,\zs/l0l1<cr>
"vmap <leader>ac :Tabularize /,\zs/l0l1<cr>

"nmap <leader>a' :Tabularize /^[^']*/l0l1<cr>
"vmap <leader>a' :Tabularize /^[^']*/l0l1<cr>

"nmap <leader>a= :Tabularize /=<cr>
"vmap <leader>a= :Tabularize /=<cr>

nmap <leader>mm :make<cr>
vmap <leader>mm :make<cr>

set makeprg=~/.vim-cmake-makeprg

map ü <C-]>
map ö [
map ä ]
map Ö {
map Ä }
map Ü /

autocmd FileType scala set shiftwidth=2 tabstop=2 softtabstop=2 expandtab

:au! BufRead,BufNewFile *apple-gmux*/.* setlocal noet
nnoremap <silent> <leader>g :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>
