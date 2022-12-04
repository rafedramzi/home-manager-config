local cmd = vim.cmd
local g = vim.g
g.mapleader = ' '
-- NOTE: don't use vim.lsp.buf.formatting() because it's async, will introduce dirty buffer problem
-- cmd[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 100)]]
cmd [[
autocmd BufWritePre *.go lua vim.lsp.buf.format({ asnyc = false })
autocmd BufWritePre *.ts lua vim.lsp.buf.format({ asnyc = false })
autocmd BufWritePre *.js lua vim.lsp.buf.format({ asnyc = false })
" Source: https://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
autocmd BufWritePre * if !&binary | call TrimWhitespace() | endif
]]

-- Vim Command
cmd([[
  " Settings
  "set autochdir "set listchars=nbsp:␣,eol:↲,tab:»\ ,extends:›,precedes:‹,trail:•
  set autoread " Auto Refresh set completeopt=menuone,noselect
  set expandtab
  set foldlevel=99
  set foldmethod=syntax
  set guifont="JetBrains\ Mono:h10"
  set ignorecase
  set incsearch
  set list
  set noerrorbells
  set nofoldenable "Disable folding
  set noswapfile
  set number relativenumber
  set shiftwidth=2
  set signcolumn=yes
  set smartcase
  set smartcase
  set smartindent
  set softtabstop=2
  set tabstop=2
  set timeoutlen=1000 ttimeoutlen=0
  set undodir=~/.vim/undodir
  set undofile
  set hidden

  " FROM :help restore-cursor
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif


  " TODO: move to nvim
  if has('nvim') || has('termguicolors')
    set termguicolors
  endif


  " Tree-sitter based folding. (Technically not a module because it's per windows and not per buffer.)
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  if has('termguicolors')
    set termguicolors
  endif
]])

-- Neovide settings
vim.cmd([[
  if exists("g:neovide")
    " Put anything you want to happen only in Neovide here
    let g:neovide_refresh_rate=60
    let g:neovide_cursor_antialiasing=v:true
    let g:neovide_no_idle=v:true
    let g:neovide_cursor_animation_length=0
    let g:neovide_transparency=1
  endif

  "Ctrl+v system clipboard
  let &showbreak='↳ '
  set cpoptions-=n
  set cursorline
  "set cursorcolumn
]])
-- Sortcuts


vim.opt.list = true
vim.opt.listchars = {
  -- space = "⋅",
  -- ·‌
  space = ".",
  eol = "↴",
  tab = "»\\ ",
  -- leadmultispace = ".",
  nbsp = ".",
}
-- TODO: evaluat this this vim options
-- filetype plugin indent on
-- syntax enable


-- custom user command
vim.api.nvim_create_user_command(
  'LspDiagnosticsReset',
  function(opts)
    vim.diagnostic.reset()
  end,
  {}
)
