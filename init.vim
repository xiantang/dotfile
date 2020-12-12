" <TAB>: completion
let mapleader=" "
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

source ~/.vimrc
" vim-plug stuff call plug#begin('~/.config/nvim/plugged') Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'SirVer/ultisnips'
Plug 'morhetz/gruvbox'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
" Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
" Plug 'deoplete-plugins/deoplete-go', { 'do': 'make' }
call plug#end()
" let g:python3_host_skip_check = 1
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#sources#go#gocode_binary = $GOPATH.'bin/gocode'
" let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeMapOpenInTab='<ENTER>'
set nu
syntax on
" autocmd vimenter * NERDTree

" Go syntax highlighting
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_fmt_command = "goimports"
let g:go_highlight_extra_types = 1
let g:go_doc_keywordprg_enabled = 0
let g:go_auto_sameids = 1


let g:airline#extensions#tabline#enabled = 1
nnoremap <leader>gi :GoImport <C-R><C-W><cr>
inoremap <leader>gi <Esc>:GoImport <C-R><C-W><cr>A.

map <F3> :NERDTreeMirror<CR>
noremap <Leader>t :NERDTreeToggle<CR>
autocmd VimEnter * NERDTree | wincmd p
autocmd BufWinEnter * NERDTreeMirror
noremap K 5kzz
noremap J 5jzz
noremap L 5lzz
noremap H 5hzz


colorscheme gruvbox
set background=dark


" 查找的时候每次输入都会不断查找
set incsearch
" 显示当前的模式
set showmode
set smartcase
set scrolloff=3
set smartindent
set noswapfile 
noremap <Leader>e :vsplit<CR> :e ~/.config/nvim/init.vim<CR>
noremap <Leader>d :vsplit<CR>
noremap <Leader>p :vsplit<CR> :e ~/.bashrc<CR>
noremap <Leader>q :q<CR>
noremap <Leader>Q :tabclose<CR>
noremap <Leader>s :w<CR>
noremap <Leader>r :GoRename<CR>
noremap <leader>/ :Commentary<cr>
noremap gu :GoReferrers<CR>
noremap >  >> 
noremap <  <<
noremap 0   ^
noremap -   $
set clipboard=unnamed


inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap < <><LEFT>

function! RemovePairs()
    let s:line = getline(".")
    let s:previous_char = s:line[col(".")-1]

    if index(["(","[","{"],s:previous_char) != -1
        let l:original_pos = getpos(".")
        execute "normal %"
        let l:new_pos = getpos(".")
        " only right (
        if l:original_pos == l:new_pos
            execute "normal! a\<BS>"
            return
        end

        let l:line2 = getline(".")
        if len(l:line2) == col(".")
            execute "normal! v%xa"
        else
            execute "normal! v%xi"
        end
    else
        execute "normal! a\<BS>"
    end
endfunction

function! RemoveNextDoubleChar(char)
    let l:line = getline(".")
    let l:next_char = l:line[col(".")]

    if a:char == l:next_char
        execute "normal! l"
    else
        execute "normal! i" . a:char . ""
    end
endfunction

inoremap <BS> <ESC>:call RemovePairs()<CR>a
inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a
inoremap > <ESC>:call RemoveNextDoubleChar('>')<CR>a

