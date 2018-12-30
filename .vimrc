let OS = system('uname')

" copy
if OS != 'mac'
  nnoremap <silent> <Space>y :.w !win32yank.exe -i<CR><CR>
  vnoremap <silent> <Space>y :w !win32yank.exe -i<CR><CR>
  nnoremap <silent> <Space>p :r !win32yank.exe -o<CR>
  vnoremap <silent> <Space>p :r !win32yank.exe -o<CR>
endif

" file
set encoding=utf-8
set fileencodings=utf-8,sjis,iso-2022-jp,cp932,euc-jp
set fileformats=unix,dos,mac
set noswapfile

" mouse
set mouse=a
set clipboard=unnamed

" display
set t_Co=256

" key
set backspace=indent,eol,start

"「※」などの記号がずれるのを直す
set ambiwidth=double

" tab
nnoremap <silent><C-m> :tabe %<CR>
nnoremap <silent><C-n> :tabe new<CR>

" move
noremap <S-h> ^
noremap <S-l> $
inoremap <silent> jj <ESC>

" buffer
set hidden

" leader
let mapleader = ','

" prevent cron edit error
set backupskip=/tmp/*,/private/tmp/*

" indent
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" file type
filetype plugin on
augroup fileTypeIndent
autocmd!
autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.vim* setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.sh setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.coffee setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.js setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.json setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.yml setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.vue setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.{html,htm,vue*} set filetype=html
au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
augroup END

" status bar
set laststatus=2
set showcmd
set statusline+=%<%F
set statusline+=%m
set statusline+=[%{&fileformat}]
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
set statusline+=%r

" tab
set showtabline=2

" ruluer and line number
set ruler
set colorcolumn=120
set number

" white space
set list
set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%

" surround
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

" highlight
set showmatch

" search and highlight
set hlsearch
set ignorecase
nnoremap <F3> :noh<CR>
nnoremap nn :noh<CR>

" replace
set inccommand=split

" ctags
set tags=tags,ctags
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <C-]> g<C-]>
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>

" vimgrep
:set wildignore=tags,*.jpg,*.jpeg,*.png,*.gif,.svn/**,.git/**,node_modules/**,tmp/**,cache/**
autocmd QuickfixCmdPost vimgrep copen
autocmd QuickfixCmdPost grep copen
nnoremap <expr> <Space>g ':vimgrep /\<' . expand('<cword>') . '\>/j **/*.' . expand('%:e')
nnoremap <expr> <Space>G ':sil grep! ' . expand('<cword>') . ' *'

" quickfix
nnoremap [q :cprevious<CR>   " 前へ
nnoremap ]q :cnext<CR>       " 次へ
nnoremap [Q :<C-u>cfirst<CR> " 最初へ
nnoremap ]Q :<C-u>clast<CR>  " 最後へ

" file edit
command! -nargs=1 -complete=file Copy f %:h/<args> | :w
command! -nargs=1 -complete=file Rename f %:h/<args> | call delete(expand('#')) | :w
command! -nargs=0 -complete=file Delete call delete(expand('%'))

" plugin
runtime! conf/*.vim

" dein
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

call dein#add('airblade/vim-gitgutter')
call dein#add('eshion/vim-sftp-sync')
call dein#add('kannokanno/previm')
call dein#add('kchmck/vim-coffee-script')
call dein#add('kien/ctrlp.vim')
call dein#add('jelera/vim-javascript-syntax')
call dein#add('posva/vim-vue')
call dein#add('romainl/Apprentice')
call dein#add('scrooloose/nerdtree')
call dein#add('scrooloose/nerdcommenter')
call dein#add('thinca/vim-quickrun')
call dein#add('tpope/vim-fugitive')
if ((has ('nvim')))
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
  call dein#add('Shougo/deoplete.nvim')
else
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/neocomplete.vim')
endif
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('vim-scripts/surround.vim')
call dein#add('vim-scripts/PDV--phpDocumentor-for-Vim')
call dein#add('vim-scripts/HTML-AutoCloseTag')
call dein#add('w0rp/ale')

call dein#end()

" ale
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1

" ctrlp
let g:ctrlp_custom_ignore = '\v[\/](.git|.svn|node_modules|.git|.png|.jpg)$'

" deoplete
let g:deoplete#enable_at_startup = 1
imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"

" previm
let g:previm_open_cmd = 'open -a safari'
nnoremap <Space>m :PrevimOpen<CR>

" sftp
nnoremap <Space>u <ESC>:call SftpUpload()<CR>
nnoremap <Space>d <ESC>:call SftpDownload()<CR>''

" NERDTree
nnoremap <C-e> :NERDTreeToggle<CR>

if dein#check_install()
  call dein#install()
endif

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" comment out
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle

" PHPDoc
inoremap <C-l> <Esc>:call PhpDocSingle()<CR>i
nnoremap <C-l> :call PhpDocSingle()<CR>
vnoremap <C-l> :call PhpDocSingle()<CR>

" color
syntax on
colorscheme apprentice
