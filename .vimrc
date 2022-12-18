"-----------------------------------------------------------------------------
" base
"-----------------------------------------------------------------------------
" 语法高亮度显示
syntax on
set hlsearch

"set cuc
set cul

" 设置行号
set nu

" language encoding
set langmenu=zh_CN.UTF-8 " set langmenu encode utf-8
set helplang=cn          " set helplang Chinese
set termencoding=utf-8   " set term encode
set encoding=utf8        " set encode
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030 " set detect encode of file

"设置字体
set guifont=Monospace\ 14

" 设置tab4个空格
set tabstop=4
set expandtab

" 真彩色
set t_Co=256

"程序自动缩进时候空格数
set shiftwidth=4

"退格键一次删除4个空格
set softtabstop=4
autocmd FileType make set noexpandtab

" 在编辑过程中，在右下角显示光标位置的状态行
set ruler

" 搜索忽略大小写 
set ignorecase 

" vim使用自动对起，也就是把当前行的对起格式应用到下一行
set autoindent

" 依据上面的对起格式，智能的选择对起方式，对于类似C语言编写上很有用
set smartindent

" smart delete
set backspace=indent,eol,start

" 在状态列显示目前所执行的指令
set showcmd
set autochdir

" 菜单乱码问题
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" mapleader
let mapleader = ","

" 去除VI一致性,必须
set nocompatible              

" detect file type
filetype on              
filetype plugin on

" keyboard map
imap jj <ESC> 
" buffer jump
map <leader> j :bnext <CR> 
map <leader> k :bpre <CR>
" 使用系统剪贴板进行复制粘贴 
vnoremap <C-y> "+y
nnoremap <C-p> "+p

" 重新加载.vimrc
nnoremap <leader><leader><space> :source $MYVIMRC <CR>

" open in closed line
if has("autocmd")
    au BufReadPost * if line ("'\"") > 0 && line ("'\"") <= line("$")
		\| exe "normal! g'\"" | endif
endif


if (has("gui_running"))
    set lines=999 columns=999
    " 消除gui边框
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions-=m
endif

" set terminal 256 color, it must set for tmux
if has("termguicolors")
    set termguicolors
endif
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

"-----------------------------------------------------------------------------
"  vim-plug
"-----------------------------------------------------------------------------
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'git://github.com/scrooloose/nerdtree.git'
Plug 'git://github.com/w0rp/ale.git'
Plug 'git://github.com/bling/vim-airline'
Plug 'git://github.com/honza/vim-snippets'
Plug 'rakr/vim-one'
Plug 'git://github.com/junegunn/vim-easy-align'
Plug 'ghifarit53/tokyonight-vim'
Plug 'mbbill/undotree'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'yggdroot/LeaderF'
Plug 'kshenoy/vim-signature'
Plug 'itchyny/vim-cursorword'
Plug 'preservim/nerdcommenter'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-autoformat/vim-autoformat'
Plug 'lervag/vimtex'
Plug 'instant-markdown/vim-instant-markdown'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting


"-----------------------------------------------------------------------------
"  coc config 
"-----------------------------------------------------------------------------
" auto install global extensions
let g:coc_global_extensions = [
	    \ 'coc-json',
	    \ 'coc-clangd',
	    \ 'coc-vimlsp',
	    \ 'coc-pyright',
	    \ 'coc-snippets',
        \ 'coc-texlab',
        \ 'coc-markdownlint',
        \ 'coc-sh',
        \ 'coc-cmake',
        \ 'coc-yank',
	    \ ]

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" 剩下的需要配置format server
" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"-----------------------------------------------------------------------------
" NERDTree
"-----------------------------------------------------------------------------
map <leader>ne :NERDTreeToggle<CR>
" 目录树窗口尺寸
let g:NERDTreeWinSize = 25
" 关闭nerd帮助
" let g:NERDTreeMinimalUI = 1
" 忽略以下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 显示书签列表
let NERDTreeShowBookmarks=1
" 显示隐藏文件
let NERDTreeShowHidden=1
" 修改默认箭头符号
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

map <F2> :NERDTreeMirror<CR>
map <F2> :NERDTreeToggle<CR>

if (has("gui_running"))
    " open nerdtree when gvim open
    augroup NERDTree
        au!
        autocmd vimenter * NERDTree     " vim启动时自动打开NERDTree
        " vim启动打开目录时自动打开NERDTree
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
        autocmd vimenter * NERDTreeFind 
        " 文件全部关闭时退出NERDTree
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    augroup END

    wincmd w
    autocmd VimEnter * wincmd w
endif

"-----------------------------------------------------------------------------
"   undotree
"-----------------------------------------------------------------------------
nnoremap <leader><leader>u :UndotreeToggle<CR>

"-----------------------------------------------------------------------------
"	autopair
"-----------------------------------------------------------------------------
let g:AutoPairsMapCh = 0

"-----------------------------------------------------------------------------
" ale.vim
"-----------------------------------------------------------------------------
"keep the sign gutter open
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:airline#extensions#ale#enabled = 1
" self-define statusline
" use quickfix list instead of the loclist
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
" only enable these linters
let g:ale_linters = {
\    'verilog': ['verilator']
\}
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-J> <Plug>(ale_next_wrap)
" run lint only on saving a file
" let g:ale_lint_on_text_changed = 'never'
" dont run lint on opening a file
" let g:ale_lint_on_enter = 0

"-----------------------------------------------------------------------------
" airline 
"-----------------------------------------------------------------------------
let laststatus = 2
let g:airline_theme = 'one'
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
let g:airline_extensions = ['tabline', 'coc']
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''

"-----------------------------------------------------------------------------
" easyalign
"-----------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"-----------------------------------------------------------------------------
" verilog_inst_gen
"-----------------------------------------------------------------------------
so ~/.vim/bundle/vlog_inst_gen.vim
let g:vlog_inst_gen_mode=1 "copy to clipboard and echo inst in split window

"-----------------------------------------------------------------------------
" vim_surround
"-----------------------------------------------------------------------------
" delete surroundings: ds, eg. ds( for delete ()
" change surroundings: cs, eg. cs([ change () to []

"-----------------------------------------------------------------------------
" vim_signature
"-----------------------------------------------------------------------------
" signature the mark for number or characters 
" mx set mark, 'x jump to mark
" dmx delete mark, m<Space> delete all marks

"-----------------------------------------------------------------------------
"     nerdcommenter
"-----------------------------------------------------------------------------
let g:NERDCreateDefaultMapping = 1
" <leader> cc : comment select line or current line 
" <leader> c<space> : toggle the comment for select line 

"-----------------------------------------------------------------------------
"     leaderf
"-----------------------------------------------------------------------------
nnoremap <space><space>f   :LeaderfFile<CR>
nnoremap <space><space>b   :LeaderfBuffer<CR>
nnoremap <space><space>fun :LeaderfFunction<CR>
nnoremap <space><space>h   :LeaderfHelp<CR>
" set leaderf options
" let g:Lf_WorkingDirectoryMode = 'ac'
let g:Lf_HideHelp = 1
let g:Lf_WindowPosition = 'popup'
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewHorizontalPosition = 'rigth'
let g:Lf_PreviewResult = {'Function': 1,'Rg': 1,'Line': 1,'BufTag': 1}
let g:Lf_CommandMap = {'<C-J>':['<C-J>','<C-N>'],'<C-K>':['<C-P>','<C-K>'],'<C-P>':['<C-L>'],'<C-]>':['<CR>'],'<C-X>':['<C-CR>']}
let g:Lf_WildIgnore = {
	    \ 'dir': ['.svn','.git','.hg','.vscode','.wine','.deepinwine','.oh-my-zsh'],
	    \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
	    \}
let g:Lf_UseCache = 1
let g:Lf_CaheDirectory = $HOME
let g:Lf_TabpagePosition = 2
let g:Lf_StlColorscheme = 'one'
let g:Lf_PopupColorscheme = 'solarized'
let g:Lf_ShowDevIcons = 0


"<C-C>, <ESC> : quit from LeaderF.
"<C-R> : switch between fuzzy search mode and regex mode.
"<C-F> : switch between full path search mode and name only search mode.
"<Tab> : switch to normal mode.
"<C-V>, <S-Insert> : paste from clipboard.
"<C-U> : clear the prompt.
"<C-W> : delete the word before the cursor in the prompt.
"<C-J>, <C-K> : navigate the result list.
"<Up>, <Down> : recall last/next input pattern from history.
"<2-LeftMouse> or <CR> : open the file under cursor or selected(whenmultiple files are selected).
"<C-X> : open in horizontal split window.
"<C-]> : open in vertical split window.
"<C-T> : open in new tabpage.
"<F5>  : refresh the cache.

"-----------------------------------------------------------------------------
"    cpp-enhanced-highlight
"-----------------------------------------------------------------------------
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_hightlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
let c_no_curly_error=1

"-----------------------------------------------------------------------------
" vim-tex
"-----------------------------------------------------------------------------
" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexmk'

" latexmk config
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : '',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

"这里是LaTeX编译引擎的设置，这里默认LaTeX编译方式为-pdf(pdfLaTeX),
"vimtex提供了magic comments来为文件设置编译方式
"例如，我在tex文件开头输入 % !TEX program = xelatex   即指定-xelatex （xelatex）编译文件
let g:vimtex_compiler_latexmk_engines = {
    \ '_'                : '-pdf',
    \ 'pdflatex'         : '-pdf',
    \ 'dvipdfex'         : '-pdfdvi',
    \ 'lualatex'         : '-lualatex',
    \ 'xelatex'          : '-xelatex',
    \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
    \ 'context (luatex)' : '-pdf -pdflatex=context',
    \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
    \}

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
" 保存修改之后可以实时输出
let g:vimtex_view_automatic = 1

"LaTeX配置
let g:tex_flavor='latex'
let g:vimtex_texcount_custom_arg=' -ch -total'
"映射VimtexCountWords！\lw 在命令模式下enter此命令可统计中英文字符的个数
au FileType tex map <buffer> <silent>  <leader>lw :VimtexCountWords!  <CR><CR>
let g:Tex_ViewRule_pdf = 'zathura -reuse-instance -inverse-search "vim -c \":RemoteOpen +\%l \%f\""'

" 阅读器相关的配置 包含正反向查找功能 仅供参考
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
let g:vimtex_view_general_options
     \ = ' -reuse-instance -forward-search @tex @line @pdf'
     \ . ' -inverse-search "' . 'cmd /c start /min \"\" '  . exepath(v:progpath)
     \ . ' -v --not-a-term -T dumb -c  \"VimtexInverseSearch %l ''%f''\""'

"编译过程中忽略警告信息
let g:vimtex_quickfix_open_on_warning=0

" key bind
nnoremap <leader>vc :VimtexCompile<CR>
nnoremap <leader>vs :VimtexStop<CR>

"-----------------------------------------------------------------------------
"  markdown instant preview
"-----------------------------------------------------------------------------
" defualt setting
"let g:instant_markdown_slow = 1
"let g:instant_markdown_autostart = 0
"let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_mathjax = 1
"let g:instant_markdown_mermaid = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_autoscroll = 0
"let g:instant_markdown_port = 8888
"let g:instant_markdown_python = 1
nnoremap <leader>imp :InstantMarkdownPreview <CR>
nnoremap <leader>ims :InstantMarkdownStop <CR>


"-----------------------------------------------------------------------------
" Autoformat
"-----------------------------------------------------------------------------
" let g:formatterpath = ['']
" 如果没有formmater，这个插件只会删除最前面的空格
noremap <C-q> :Autoformat<CR>

"-----------------------------------------------------------------------------
"vtag
"-----------------------------------------------------------------------------
source /home/edas/.vim/vtags-3.01/vtags_vim_api.vim
" vtags 针对当前目录建立database
" gi 进入子模块
" gu 回到上一级目录
" mt 顶层到当前模块调用结构

"-----------------------------------------------------------------------------
" ctags
"-----------------------------------------------------------------------------
set tags=tags;

"-----------------------------------------------------------------------------
" Add File Header
"-----------------------------------------------------------------------------
autocmd BufNewFile *.v,*.sv,*.cpp,*.c,*.h exec ":call AddHeader()"
autocmd BufWrite *.v,*.sv,*.cpp,*.c,*.h call UpdateLastModifyTime()

function s:GetUserName() 
    let user_name = "Zeyang peng"
    return user_name
endfunction 

function AddHeader() 
	let line = getline(1)
  	let filename = expand("%")
	call append(0,  "// +FHDR----------------------------------------------------------------------------")
	call append(1,  "//                 Copyright (c) ".strftime("%Y ") )
	call append(2,  "//                       ALL RIGHTS RESERVED")
	call append(3,  "// ---------------------------------------------------------------------------------")
	call append(4,  "// Filename      : ".filename)
	call append(5,  "// Author        : ".s:GetUserName())
	call append(6,  "// Created On    : ".strftime("%Y-%m-%d %H:%M"))
	call append(7,  "// Last Modified : ")
	call append(8,  "// ---------------------------------------------------------------------------------")
	call append(9,  "// Description   : ")
	call append(10, "//")
	call append(11, "//")
	call append(12, "// -FHDR----------------------------------------------------------------------------")
endfunction 


"-----------------------------------------------------------------------------
" ModifyTime
"-----------------------------------------------------------------------------
function UpdateLastModifyTime() 
	let line = getline(8)
	if line =~ '// Last Modified'
		call setline(8,"// Last Modified : " . strftime("%Y-%m-%d %H:%M"))
	endif
endfunction 

"-----------------------------------------------------------------------------
" Add Python File Header
"-----------------------------------------------------------------------------
autocmd BufNewFile *.py exec ":call AddPyHeader()"
autocmd BufWrite *.py call PyUpdateLastModifyTime()

function AddPyHeader() 
	let line = getline(1)
  	let filename = expand("%")
	call append(0 ,  "#!/usr/bin/env python3")
    call append(1 ,  "# -*- coding:utf-8 -*-")
	call append(2 ,  "# +FHDR----------------------------------------------------------------------------")
	call append(3 ,  "#                 Copyright (c) ".strftime("%Y ") )
	call append(4 ,  "#                       ALL RIGHTS RESERVED")
	call append(5 ,  "# ---------------------------------------------------------------------------------")
	call append(6 ,  "# Filename      : ".filename)
	call append(7 ,  "# Author        : ".s:GetUserName())
	call append(8 ,  "# Created On    : ".strftime("%Y-%m-%d %H:%M"))
	call append(9 ,  "# Last Modified : ")
	call append(10,  "# ---------------------------------------------------------------------------------")
	call append(11,  "# Description   : ")
	call append(12,  "#")
	call append(13,  "#")
	call append(14,  "# -FHDR----------------------------------------------------------------------------")
endfunction 

"-----------------------------------------------------------------------------
" Python ModifyTime
"-----------------------------------------------------------------------------
function PyUpdateLastModifyTime() 
	let line = getline(10)
	if line =~ '# Last Modified'
		call setline(10,"# Last Modified : " . strftime("%Y-%m-%d %H:%M"))
	endif
endfunction 



"-----------------------------------------------------------------------------
" 设置颜色主题，在plug之后设置避免出现问题，不需要colors文件夹
"-----------------------------------------------------------------------------
" set one colorscheme
colorscheme one
set background=dark

" set tokyonight colorscheme
"let g:tokyonight_style = 'storm' " available: night, storm
"let g:tokyonight_enable_italic = 1
"colorscheme tokyonight


