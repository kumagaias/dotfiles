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
set clipboard=unnamed,autoselect

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
set tabstop=4

" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=4

" 自動インデントでずれる幅
set shiftwidth=4

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

call dein#add('Shougo/neocomplete.vim')
call dein#add('violetyk/neocomplete-php.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('kien/ctrlp.vim')
let g:ctrlp_custom_ignore = '\v[\/](.git|.svn|node_modules|.git|.png|.jpg)$'''
call dein#add('vim-syntastic/syntastic')
let g:syntastic_php_checkers = ['php']
let g:syntastic_coffee_checkers = ['coffeelint']
let g:syntastic_php_phpcs_args='--standard=psr2'
let g:syntastic_javascript_checkers=['eslint']
call dein#add('tpope/vim-fugitive')
call dein#add('airblade/vim-gitgutter')
call dein#add('eshion/vim-sftp-sync')
call dein#add('scrooloose/nerdcommenter')
call dein#add('vim-scripts/PDV--phpDocumentor-for-Vim')
call dein#add('kchmck/vim-coffee-script')
call dein#add('kannokanno/previm')
let g:previm_open_cmd = 'open -a safari'
nnoremap <Space>m :PrevimOpen<CR>

call dein#end()
nnoremap <Space>u <ESC>:call SftpUpload()<CR>
nnoremap <Space>d <ESC>:call SftpDownload()<CR>''

if dein#check_install()
  call dein#install()
endif

"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

let g:syntastic_enable_signs = 1

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

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

" -----for syntastic-----

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" PHPDoc
inoremap <C-l> <Esc>:call PhpDocSingle()<CR>i
nnoremap <C-l> :call PhpDocSingle()<CR>
vnoremap <C-l> :call PhpDocSingle()<CR>

" PHP complete
let g:neocomplete_php_locale = 'ja'

"------- dein end の後に書く必要があるもの -------"

" color
colorscheme apprentice
syntax on
