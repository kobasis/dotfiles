"========================================
" 設定
"========================================
"ソフトタブ幅
set softtabstop=2
"シフト時のタブ幅
set shiftwidth=2
"スマートインデント 
set smartindent
"バックスペースでタブを消せるように
set backspace=2
"拡張ワイルドメニュー
set wildmenu
"一行のテキスト幅
set textwidth=0
"インクリメントサーチ有効
set incsearch
set hlsearch
set noexpandtab
"行リストを表示
set nu
" 機種依存文字を排除
set ambiwidth=double
" バッファを切替えてもundoの効力を失わない
set hidden
" 起動時のメッセージを表示しない
set shortmess+=I
" 折り返ししない
set wrap
" ベルを鳴らさない
set noerrorbells
" ヴィジュアルベル
set visualbell
" ビジュアルベルで何も出さない
set t_vb=
" バックアップをとらない
set nobackup
" スワップファイルを作らない
set noswapfile
" 改行してもコメントを表示しない
set formatoptions-=ro 
" ステータスライン
set laststatus=2
set statusline=%<%f\ %m%r%h%w[%Y]%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%8p%%(%L)
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set statusline=%<%f\ %=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
" テーマ
set background=light

"カラーシンタックス有効
syntax on

" 補完時のカラー
hi Pmenu ctermbg=5
hi PmenuSel ctermbg=7  ctermfg=0
hi PmenuSbar ctermbg=1
hi PmenuThumb ctermbg=7

" デフォルトのエンコードはutf8.
set fileencodings=utf-8,euc-jp,iso-2022-jp,sjis

"ファイルタイプ別処理
filetype on
filetype indent on
filetype plugin on

" インクリメント時に、0ではじまっている数字を８進数として扱わない
set nrformats=

"========================================
" 環境変数とか
"========================================
if has('win32')
    :set runtimepath+=$HOME/.vim
endif

if has('mac')
  set backupskip=/tmp/*,/private/tmp/*
endif

"========================================
" キーバインド
"========================================

" exキーの設定
noremap ;  :
noremap :  ;

" マーク
nnoremap ` '
nnoremap ' `

" コマンドラインモード
nnoremap q; q:
nnoremap q: q;

" バッファ移動
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" 素早くヘルプを引く
nnoremap <C-h>  :<C-u>help<Space>
nnoremap <C-h><C-h>  :<C-u>help<Space><C-r><C-w><CR>

" 以下スペースPrefix
nnoremap <Space>s. :<C-u>source $MYVIMRC<CR>
nnoremap <Space>.  :<C-u>edit $MYVIMRC<CR>

" 検索を楽ちんにする
cnoremap <expr> / getcmdtype() == '/' ? '¥/' : '/'

" 改行ハック
"nnoremap <silent>  O :<C-u>call append(expand('.'), '')<Cr>j

" レジスタ表示
" nnoremap ,r :reg<CR>

" タグジャンプ周り
nnoremap [Tag]   <Nop>
nmap     t [Tag]
nnoremap [Tag]t  <C-]>
nnoremap <silent> [Tag]n  :<C-u>tag<CR>
nnoremap <silent> [Tag]p  :<C-u>pop<CR>
nnoremap <silent> [Tag]l  :<C-u>tags<CR>

" 最後に編集した箇所を選択
nnoremap gc `[v`]
vnoremap gc :<C-u>normal gc<Enter>
onoremap gc :<C-u>normal gc<Enter>

" merge用
if &diff
    nnoremap ,1 :diffget LOCAL<CR>
    nnoremap ,2 :diffget BASE<CR>
    nnoremap ,3 :diffget REMOTE<CR>
endif

" very magic 検索
nnoremap /  /\v

" 最後のディレクトリに自動で移動
:au BufEnter * execute ":lcd " . expand("%:p:h")

" 日本語の際にカーソル色を赤にする
if has('multi_byte_ime') || has('xim') 
    highlight Cursor guifg=NONE guibg=White
    highlight CursorIM guifg=NONE guibg=Red
endif

" ******************************************************************************
" ファイルタイプ
" ******************************************************************************
" Fsharp
au BufRead,BufNewFile *.fs  set filetype=fsharp
au BufRead,BufNewFile *.clj set filetype=clojure

" config file filetype settings
" au BufRead,BufNewFile .muttatorrc  set filetype=vim

au BufRead,BufNewFile */.ssh/conf.d/**/* set filetype=sshconfig

" ******************************************************************************
" プラグイン
" ******************************************************************************

" Required:
call plug#begin('~/.vim/plugged')

" Go
Plug 'fatih/vim-go'

" 最近開いたファイル
Plug 'vim-scripts/mru.vim'
" sudo vim を行った際に.vimrcを見てくれる
Plug 'vim-scripts/sudo.vim'

" 定番
Plug 'scrooloose/nerdtree'

" Rubyのbegin/endをマッチング
Plug 'vim-scripts/ruby-matchit'

" Rubyのdef/endを自動入力
Plug 'tpope/vim-endwise'

" コードを実行
Plug 'thinca/vim-quickrun'
nnoremap <leader>r :QuickRun -mode n"<CR>
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'runner'    : 'vimproc',
      \ 'runner/vimproc/updatetime' : 60,
      \ 'outputter' : 'error',
      \ 'outputter/error/success' : 'buffer',
      \ 'outputter/error/error'   : 'quickfix',
      \ 'outputter/buffer/split'  : ':rightbelow 8sp',
      \ 'outputter/buffer/close_on_empty' : 1,
      \ }
" 正規表現を許可
Plug 'othree/eregex.vim'

" 位置揃え
Plug 'junegunn/vim-easy-align'

" Scala用
Plug 'derekwyatt/vim-scala'

" サラウンド
Plug 'tpope/vim-surround'

" Type-script
Plug 'leafgarland/typescript-vim'
Plug 'clausreinke/typescript-tools'

" シンタックスチェック
Plug 'scrooloose/syntastic'

" Python自動補完用
Plug 'davidhalter/jedi-vim'
let g:jedi#auto_initialization = 1

" Python 文法チェッカ
let g:syntastic_mode_map = {
            \ 'mode': 'active',
            \ 'active_filetypes': ['php', 'sh', 'vim'],
            \ 'passive_filetypes': ['html', 'haskell', 'python']
            \}

" 自動で閉じるやつ
Plug 'jiangmiao/auto-pairs'

" colorscheme
Plug 'tomasr/molokai'

" 補完
Plug 'Shougo/neocomplete'


" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" " Use smartcase.
let g:neocomplete#enable_smart_case = 1

" fish
Plug 'dag/vim-fish'

" Swift
Plug 'keith/swift'
let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']

" Markdown
Plug 'gabrielelana/vim-markdown'
let g:markdown_include_jekyll_support = 0
let g:markdown_enable_spell_checking = 0

" Marked
Plug 'itspriddle/vim-marked'

" Yankring
Plug 'vim-scripts/YankRing.vim'

" Close tag
Plug 'alvan/vim-closetag'

" Emmet
Plug 'mattn/emmet-vim'
let g:user_emmet_settings = {
\   'lang' : 'ja'
\ }

" Required:
call plug#end()


colorscheme molokai 

hi Comment ctermfg=102
hi Visual  ctermbg=236

" Go
let g:go_fmt_command = "goimports"
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

" powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2
set showtabline=2
set noshowmode

" モードによってカーソルを変更する
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
