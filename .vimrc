let OS = system('uname')
"----基本設定-----

" 文字コード
set encoding=utf-8
set fileencodings=utf-8,sjis,iso-2022-jp,cp932,euc-jp

" 改行コード
set fileformats=unix,dos,mac

"ターミナルで256色表示を使う
set t_Co=256

"マウスを使えるようにする
set mouse=a

"バックスペースキーで行頭を削除する
set backspace=indent,eol,start

"マウスで選択した部分をクリップボードにコピーする
set clipboard=unnamed

if OS != 'mac'
  nnoremap <silent> <Space>y :.w !win32yank.exe -i<CR><CR>
  vnoremap <silent> <Space>y :w !win32yank.exe -i<CR><CR>
  nnoremap <silent> <Space>p :r !win32yank.exe -o<CR>
  vnoremap <silent> <Space>p :r !win32yank.exe -o<CR>
endif

"「※」などの記号がずれるのを直す
set ambiwidth=double

" swap ファイル作らない
set noswapfile

" tab
nnoremap <silent><C-m> :tabe %<CR>
nnoremap <silent><C-n> :tabe new<CR>

" buffer
" 編集中ファイルを切り替える時に保存しなくても良くなる
set hidden

" move
noremap <S-h> ^
noremap <S-l> $

set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tag jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

" タグジャンプ
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>

" 120 文字に縦線"
set colorcolumn=120

" 拡張子に応じてファイルを開く
filetype plugin on

" <Leader> キー設定
let mapleader = ','

" cron 編集する時にエラーになるのを防ぐ
set backupskip=/tmp/*,/private/tmp/*

"-----ctags-----

set tags=tags,ctags
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

"-------style--------

" 自動補完
inoremap { {}<LEFT>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [ []<LEFT>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap ( ()<LEFT>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

"改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set autoindent

"画面上でタブ文字が占める幅
set tabstop=2

" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=2

" 自動インデントでずれる幅
set shiftwidth=2

" 言語別
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
autocmd BufNewFile,BufRead *.vue setlocal filetype=vue.html.javascript.css
augroup END

"タブ入力を複数の空白入力に置き換える (既存のタブには影響しない)
set expandtab

"括弧の対応をハイライト
set showmatch

"ルーラー,行番号を表示
set ruler
set number

"タブ、空白、改行の可視化
set list
set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%

" ペースト切り替え
:imap <F11> <nop>
:set pastetoggle=<F11>

"-------search-----

"検索結果をハイライトする
set hlsearch

" vimgrep の除外設定
:set wildignore=tags,*.jpg,*.jpeg,*.png,*.gif

"大文字小文字を区別しない
set ignorecase

" ハイライト表示切替
nnoremap <F3> :noh<CR>

" 関数ジャンプで複数ある時は一覧を表示
nnoremap <C-]> g<C-]>

" vimgrep
set grepprg=grep\ -rnIH\ --exclude-dir=.svn\ --exclude-dir=.git
autocmd QuickfixCmdPost vimgrep copen
autocmd QuickfixCmdPost grep copen
nnoremap <expr> <Space>g ':vimgrep /\<' . expand('<cword>') . '\>/j **/*.' . expand('%:e')
nnoremap <expr> <Space>G ':sil grep! ' . expand('<cword>') . ' *'

" quickfix
nnoremap [q :cprevious<CR>   " 前へ
nnoremap ]q :cnext<CR>       " 次へ
nnoremap [Q :<C-u>cfirst<CR> " 最初へ
nnoremap ]Q :<C-u>clast<CR>  " 最後へ

"-------status line-------

" ステータスラインを常に表示
set laststatus=2

" ステータスラインにコマンドを表示
set showcmd

" ファイル名表示
set statusline+=%<%F

" 変更のチェック表示
set statusline+=%m

" ファイルフォーマット表示
set statusline+=[%{&fileformat}]

" 文字コード表示
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]

" 読み込み専用かどうか表示
set statusline+=%r

"-------file operation-----

" カレントファイルをコピー
command! -nargs=1 -complete=file Copy f %:h/<args> | :w

" カレントファイルをリネーム
command! -nargs=1 -complete=file Rename f %:h/<args> | call delete(expand('#')) | :w

" カレントファイルをデリート
command! -nargs=0 -complete=file Delete call delete(expand('%'))

"------- plugin -------

" 個別の config がある場合はロード
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
  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neocomplete.vim')
endif
call dein#add('vim-scripts/surround.vim')
call dein#add('vim-scripts/PDV--phpDocumentor-for-Vim')
call dein#add('vim-scripts/HTML-AutoCloseTag')
call dein#add('w0rp/ale')

call dein#end()

" ale
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1

let g:ale_linters = {
\ 'html': [],
\ 'css': ['stylelint'],
\ 'javascript': ['eslint'],
\ 'vue': ['eslint']
\ }

" ctrlp
let g:ctrlp_custom_ignore = '\v[\/](.git|.svn|node_modules|.git|.png|.jpg)$'

" deoplete
let g:deoplete#enable_at_startup = 1

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

"------- コメントアウトプラグイン用 -------
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle

" coffee script
au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee

" PHPDoc
inoremap <C-l> <Esc>:call PhpDocSingle()<CR>i
nnoremap <C-l> :call PhpDocSingle()<CR>
vnoremap <C-l> :call PhpDocSingle()<CR>

"------- dein end の後に書く必要があるもの -------"

" color
syntax on
colorscheme apprentice
