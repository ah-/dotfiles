syntax on
filetype plugin indent on

set t_Co=256
set number
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set showcmd
set ignorecase
set smartcase
set gdefault
set hidden
set ruler
set foldmethod=syntax
set foldlevel=100
set ttyfast
set virtualedit+=block
set enc=utf-8
set guioptions=
set cul
set vb
set laststatus=2
"set macmeta

" Complete options (disable preview scratch window)
"set completeopt=longest,menuone ",preview
set completeopt=menuone ",preview
set pumheight=15
set nocompatible

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

" History and backup
set viminfo='10,:20,\"100,n~/.viminfo
set history=1000
set nobackup
set nowritebackup
set noswapfile

set clipboard=unnamed
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

let g:mapleader = " "
let g:maplocalleader = " "
let g:UltiSnipsEditSplit = "vertical"

cmap W! w !sudo tee % >/dev/null

nnoremap <silent> <c-n> :NERDTreeToggle<CR>
"nnoremap <silent> <c-n> :VimFiler -toggle -simple<CR>
nnoremap <silent> <leader>tt :TagbarToggle<CR>

" Quickly edit/reload the vimrc file
nnoremap <silent> <leader>ev :tabe $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>
nnoremap <silent> <leader>ez :tabe ~/.zshrc<CR>

nnoremap j gj
nnoremap k gk

vnoremap <           <gv
vnoremap >           >gv

" clean up windows file endings
nnoremap <leader>vl :%s/\r$<CR>

" ,s to show trailing whitespace
set listchars=tab:>-,trail:·,eol:$
nnoremap <silent> <leader>s :set nolist!<CR>

nnoremap <S-h> :bprev<CR>
nnoremap <S-l> :bnext<CR>

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

" strip all trailing whitespace from file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>a :%! astyle --style=attach --indent=spaces=4 --pad-oper --unpad-paren --pad-header --add-brackets --align-pointer=name  --lineend=linux

inoremap jj <ESC>

"nmap <leader>aa :A<cr>
"nmap <leader>as :AS<cr>
"nmap <leader>av :AV<cr>
"nmap <leader>an :AN<cr>
"nmap <leader>ai :AI<cr>

nmap <leader>ac :Tabularize /,\zs/l0l1<cr>
vmap <leader>ac :Tabularize /,\zs/l0l1<cr>

nmap <leader>as :Tabularize / \zs<cr>
vmap <leader>as :Tabularize / \zs<cr>

nmap <leader>a' :Tabularize /^[^']*/l0l1<cr>
vmap <leader>a' :Tabularize /^[^']*/l0l1<cr>

nmap <leader>a& :Tabularize /&/l1l1<cr>
vmap <leader>a& :Tabularize /&/l1l1<cr>

nmap <leader>a= :Tabularize /=<cr>
vmap <leader>a= :Tabularize /=<cr>

nmap <leader>mm :make<cr>
vmap <leader>mm :make<cr>

nnoremap <leader>oo :set guifont=Inconsolata:h14<CR>:set antialias<CR>
nnoremap <leader>ol :set guifont=monaco:h10<CR>:set noantialias<CR>

"map ü <C-]>
"map ö [
"map ä ]
"map Ö {
"map Ä }
"map Ü /

nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

let g:slime_target = "tmux"

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
        exec '!p='.shellescape(vam_install_path).'; mkdir -p "$p" && cd "$p" && git clone --depth 1 git://github.com/MarcWeber/vim-addon-manager.git'
        " VAM run helptags automatically if you install or update plugins
        exec 'helptags '.fnameescape(vam_install_path.'/vim-addon-manager/doc')
    endif
"\       'a',
"\       'yankstack',
    call vam#ActivateAddons([
\       'vimproc',
\       'Mustang2',
\       'Solarized',
\       'Lucius',
\       'vombato-colorscheme',
\       'The_NERD_Commenter',
\       'delimitMate',
\       'vim-addon-local-vimrc',
\       'rainbow_parentheses',
\       'quickfixsigns',
\       'The_NERD_tree',
\       'unite', 'unite-outline',
\       'vimoutliner-colorscheme-fix', 'TVO_The_Vim_Outliner',
\       'vimfiler',
\       'csindent',
\       'YouCompleteMe',
\       'vim-sneak',
\       'UltiSnips',
\       'Tabular', 'fugitive', 'vim-git-log', 'github:epeli/slimux', 'DirDiff',
\       'surround'], {'auto_install' : 1})
"\       'Syntastic',
"\    'The_NERD_tree', 'github:majutsushi/tagbar',
"\    'extradite', 'EasyMotion',
"\    'vim-scala@behaghel', 'vim-addon-sbt',
"\    'github:LaTeX-Box-Team/LaTeX-Box', 'github:tobig/clang_complete',
" , 'DirDiff'
endfun
call SetupVAM()

colorscheme Mustang
"highlight SignColumn ctermbg=Black guibg=#000000
"colorscheme Lucius
"colorscheme vombato

" Folding background
"hi Folded guibg=bg

" au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Unite                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call unite#custom_filters('file,file/new,buffer,file_rec', ['matcher_fuzzy', 'sorter_default', 'converter_default'])
call unite#custom_filters('file', ['matcher_fuzzy', 'sorter_default', 'converter_default'])
 "The prefix key.
nnoremap    [unite]   <Nop>
nmap    <leader>f [unite]

nnoremap <silent> [unite]e  :<C-u>UniteWithCursorWord
\ -buffer-name=ack grep:.<CR>
nnoremap <silent> [unite]a  :<C-u>Unite
\ -buffer-name=ack grep:.<CR>
nnoremap <silent> [unite]c  :<C-u>Unite
\ -buffer-name=file_rec file_rec/async<CR>
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
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
let g:unite_source_grep_recursive_opt = ''


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


"format current line or selected (both command and insert modes)
nnoremap <C-I> :pyf ~/trunk/tools/clang-format/clang-format.py<CR>
vnoremap <C-I> :pyf ~/trunk/tools/clang-format/clang-format.py<CR>
inoremap <C-I> <ESC>:pyf ~/trunk/tools/clang-format/clang-format.py<CR>i

"format all (both command and insert modes)
nnoremap <F6> ggVG :pyf ~/trunk/tools/clang-format/clang-format.py<CR><CR>
imap <F6> ggVG :pyf ~/trunk/tools/clang-format/clang-format.py<CR><CR>i

map <C-c><C-c> :SlimuxREPLSendLine<CR>
vmap <C-c><C-c> :SlimuxREPLSendSelection<CR>

" Integrates UltiSnips tab completion with YouCompleteMe
" See: https://github.com/Valloric/YouCompleteMe/issues/36
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips_JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

" This only works, if a new buffer is opened. And not if vi opens the file
" directly.
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"

" Alternative version to use snippets.
let g:UltiSnipsExpandTrigger = '<c-l>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
"let g:UltiSnipsListSnippets = '<c-m>'
