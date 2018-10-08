"*****************************************************************************
"" Plugins
"*****************************************************************************"
if &compatible
  set nocompatible
endif

" プラグインがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')

" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイルを用意しておく
  let g:rc_dir    = expand("~/.config/nvim/")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on

" -------------------------------
" ctrlp.vim
" -------------------------------
let g:ctrlp_use_caching=0
let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
let mapleader="\<Space>"

set history=1000

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Fix backspace indent
set backspace=indent,eol,start

"" Searching
set incsearch          "インクリメンタルサーチを行う
set hlsearch           "検索結果をハイライトする
set ignorecase         "検索時に文字の大小を区別しない
set smartcase          "検索時に大文字を含んでいたら大小を区別する
set wrapscan           "検索をファイルの先頭へループする
vnoremap <silent> > >gv
vnoremap <silent> < <gv

" 検索後にジャンプした際検索後を画面中央に
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

"" Encoding
set nobomb
set binary
set ttyfast

set fileformats=unix,dos,mac
set showcmd
set shell=/bin/sh

set whichwrap=b,s,h,l,<,>,[,]   "カーソルを行頭、行末で止まらないようにする
set nobackup                    " ファイル保存時にバックアップファイルを作らない
set noswapfile                  " ファイル編集中にスワップファイルを作らな
set autoread                    " 外部でファイルに変更がされた場合は読みなおす

"" 表示行単位で行移動
nnoremap <silent> j gj
nnoremap <silent> k gk

"" JSONのダブルクォーテーションを表示する
let g:vim_json_syntax_conceal=0

"" 改行時に自動でコメントを挿入するのを防ぐ
autocmd FileType * setlocal formatoptions-=ro

" ファイル保存時に行末の空白を自動削除
autocmd BufWritePre * :%s/\s\+$//ge

"" StatusLine
set statusline+=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]


"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax enable
set background=dark

set number
set ruler              "カーソル行が何行目何列目に置かれているか表示
set listchars=eol:¶,tab:_\
set cursorline         "カーソル行ハイライト
set laststatus=2       "ステータス行を常時表示
set title              "編集中のファイル名を表示する
set showmatch          "対応する括弧の強調表示
set matchtime=3        "showmatchの表示時間
set scrolloff=8        "上下の視界確保
set sidescrolloff=16   "左右の視界確保
set nostartofline      "移動コマンド使用時にカーソルを先頭に置かない

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif   "前回終了時のカーソル位置へ移動

" Add jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

"*****************************************************************************
""" Mappings
"*****************************************************************************
"" Copy/Paste/Cut
set clipboard=unnamed


"*****************************************************************************
""" Tag
"*****************************************************************************
" Tag ジャンプ時に新規タブで開く
nnoremap <C-]> :<C-u>tab stj <C-R>=expand('<cword>')<CR><CR>


"*****************************************************************************
" Indent Width
"*****************************************************************************"
set shiftwidth=2       "行頭での<Tab>の幅
set tabstop=2          "行頭以外での<Tab>の幅
set expandtab          "<Tab>の代わりに<Space>を挿入する
set softtabstop=2      "expandtabで<Tab>が対応する<Space>の数
set autoindent
