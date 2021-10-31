let $MYVIMRC="~/.config/nvim/init.vim"                                          " init.vim path

call plug#begin()
"------------------Visuals-----------------"
Plug 'joshdick/onedark.vim'                                                     " theme
" Plug 'ntk148v/vim-horizon'
" Plug 'ayu-theme/ayu-vim'

" Nice statusline/ruler for vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'machakann/vim-highlightedyank'                                            " higlight the yanked text

Plug 'easymotion/vim-easymotion'                                                " navigation
Plug 'bkad/CamelCaseMotion'                                                     " word movement
Plug 'sheerun/vim-polyglot'                                                     " A collection of language packs for vim
Plug 'scrooloose/nerdcommenter'                                                 " Commentinb4b4r07/vim-hclg
Plug 'preservim/nerdtree'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'

" JS and TS
Plug 'pangloss/vim-javascript'                                                  " JavaScript support
Plug 'leafgarland/typescript-vim'                                               " TypeScript syntax
Plug 'jparise/vim-graphql'                                                      " GraphQL syntax
Plug 'prettier/vim-prettier'                                                    " Prettier syntax

" git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" golang
Plug 'fatih/vim-go'

" floating terminal and lazy stuff
Plug 'voldikss/vim-floaterm'

" notes
Plug 'vimwiki/vimwiki'
Plug 'michal-h21/vim-zettel'
Plug 'michal-h21/vimwiki-sync'
call plug#end()


syntax on
let mapleader=','
colorscheme onedark
" silent! colorscheme horizon
" colorscheme ayu
highlight Pmenu ctermbg=111217 guibg=#111217
set splitright
set updatetime=100
set hidden
set nobackup
set nowritebackup
set cmdheight=2                                                                 " Give more space for displaying messages.
set shortmess+=c
set termguicolors
set shortmess+=c
set signcolumn=yes
set encoding=utf-8
set noerrorbells
set expandtab
set nowrap
set number
set noshowmode
set colorcolumn=80
set ignorecase
set smartcase
set clipboard+=unnamedplus
set noswapfile
" set t_Co=256
set tabstop=2
set shiftwidth=2
set guifont=JetBrains\ Mono\ 13

" mkdir, rmdir, files
" set nocp
" filetype plugin on

" enough for line numbers + gutter within 80 standard
set textwidth=72

" wrap around when searching
set wrapscan

" Just the defaults, these are changed per filetype by plugins.
" Most of the utility of all of this has been superceded by the use of
" modern simplified pandoc for capturing knowledge source instead of
" arbitrary raw text files.

set fo-=t   " don't auto-wrap text using text width
set fo+=c   " autowrap comments using textwidth with leader
set fo-=r   " don't auto-insert comment leader on enter in insert
set fo-=o   " don't auto-insert comment leader on o/O in normal
set fo+=q   " allow formatting of comments with gq
set fo-=w   " don't use trailing whitespace for paragraphs
set fo-=a   " disable auto-formatting of paragraph changes
set fo-=n   " don't recognized numbered lists
set fo+=j   " delete comment prefix when joining
set fo-=2   " don't use the indent of second paragraph line
set fo-=v   " don't use broken 'vi-compatible auto-wrapping'
set fo-=b   " don't use broken 'vi-compatible auto-wrapping'
set fo+=l   " long lines not broken in insert mode
set fo+=m   " multi-byte character line break support
set fo+=M   " don't add space before or after multi-byte char
set fo-=B   " don't add space between two multi-byte chars
set fo+=1   " don't break a line after a one-letter word


highlight ColorColumn ctermbg=0 guibg=gray

" vimwiki
" let g:vimwiki_folding = 'expr'
hi VimwikiHeader1 guifg=#98C379
hi VimwikiHeader2 guifg=#C678DD
hi VimwikiHeader3 guifg=#61AFEF

let g:zettel_format = "%y%m%d%H%M"
let g:nv_search_paths = ['~/Repos/github.com/rickKoch/notes/Zettelkasten/']

let zettel = {}
let zettel.path = '~/Repos/github.com/rickKoch/notes/Zettelkasten/'
let zettel.syntax = 'markdown'
let zettel.ext = '.md'

let work = {}
let work.path = '~/Repos/github.com/rickKoch/notes/Work/'
let work.syntax = 'markdown'
let work.ext = '.md'

let personal = {}
let personal.path = '~/Repos/github.com/rickKoch/notes/Personal/'
let personal.syntax = 'markdown'
let personal.ext = '.md'

let g:vimwiki_list = [zettel, work, personal]

nnoremap <leader>zn <CMD>ZettelNew<CR>
nnoremap <leader>zo <CMD>ZettelOpen<CR>
nnoremap <leader>zi <CMD>ZettelInsertNote<CR>
nnoremap <leader>zb <CMD>ZettelBackLinks<CR>
nnoremap <leader>zu <CMD>ZettelInbox<CR>>
nnoremap <leader>zl <CMD>ZettelGenerateLinks<CR>
nnoremap <leader>zt <CMD>ZettelGenerateTags<CR>
nnoremap <leader>zs <CMD>ZettelSearch<CR>
nnoremap <leader>zy <CMD>ZettelYankName<CR>

autocmd VimLeave * call system("xsel -ib", getreg('+'))

" fugitive git
autocmd BufReadPost fugitive://* set bufhidden=delete

" transparent background
hi Normal guibg=NONE ctermbg=NONE

" let g:lightline = {'colorscheme' : 'horizon'}
" let ayucolor="dark"

" airline
let g:airline_theme = "base16_spacemacs"

" fzf.vim
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" camelcasemotion
let g:camelcasemotion_key = '<leader>'

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDTrimTrailingWhitespace = 1

" floaterm
" nnoremap <leader>bb <CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 btm<CR>
" nnoremap <leader>k9 <CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 k9s<CR>
nnoremap <leader>ld <CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 lazydocker<CR>
nnoremap <leader>lg <CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 lazygit<CR>
" nnoremap <leader>nn <CMD>FloatermNew --autoclose=2 --height=0.5 --width=0.5 nnn -Hde<CR>
" nnoremap <leader>tt <CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 zsh<CR>
" nnoremap <leader>tw <CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 taskwarrior-tui<CR>

" go
let g:go_fmt_command = "goimports"
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_chan_whitespace_error = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_auto_sameids = 1

au FileType go nmap <leader>rv <Plug>(go-run-vertical)
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

au FileType vimwiki set noexpandtab
au FileType vimwiki set shiftwidth=2
au FileType vimwiki set softtabstop=2
au FileType vimwiki set tabstop=2

au FileType scss set noexpandtab
au FileType scss set shiftwidth=2
au FileType scss set softtabstop=2
au FileType scss set tabstop=2

au FileType js set noexpandtab
au FileType js set shiftwidth=2
au FileType js set softtabstop=2
au FileType js set tabstop=2


" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDTrimTrailingWhitespace = 1

" prettier
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

" graphql
au BufNewFile,BufRead *.prisma setfiletype graphql

" vim-jsx
autocmd BufRead,BufNewFile *.tsx setlocal syntax=javascript.jsx


" ======= Basic remaps.  This is where the magic of vim happens
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>
" nmap <leader>h :wincmd h<CR>
" nmap <leader>j :wincmd j<CR>
" nmap <leader>k :wincmd k<CR>
" nmap <leader>l :wincmd l<CR>

vnoremap < <gv
vnoremap > >gv

nmap <Leader>ev :tabedit $MYVIMRC<cr>
"Add simple highlight removal.
nmap <C-n> :noh<cr>

" nerdtree
map <M-1> :NERDTreeToggle<CR>

" toggle comment ctrl+/
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

" nmap <Leader>u :UndotreeShow<CR>
nmap <C-p> :Files<CR>
nmap <C-b> :Buffers<CR>

imap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
imap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Prettier
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

nmap <M-F> :Format<CR>

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
