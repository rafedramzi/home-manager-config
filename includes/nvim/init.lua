require('plugins.packer')
require('plugins.config.rafed')
require('plugins.config.shortcuts')

-- TODO: Lazy loading module nvchad l ike
-- require('gitsigns').setup()
-- TODO: move mve to config file,
require('feline').setup()
require('keymap')


-- vim.g.colors_name = "challenger_deep"
--
-- vim.cmd([[set mouse=a]]) -- doesn't feel good on kitty
vim.g.tokyonight_style = "night"
vim.g.tokyonight_lualine_bold = true
vim.g.catppuccin_flavour = "mocha"
require("catppuccin").setup()
vim.cmd([[
colorscheme catppuccin

autocmd VimEnter * set guifont=Noto\ Sans\ Mono:h9:w300 | au! VimResized

" the c and o int hsi font looks a simlar, hard to distingush in small font
" autocmd VimEnter * set guifont=SpaceMono\ Nerd\ Font\ Mono:h10:w300 | au! VimResized

" slow with cascadia code"
" autocmd VimEnter * set guifont=Cascadia\ Code:h10 | au! VimResized

" from: https://stackoverflow.com/questions/62100785/auto-reload-file-and-in-neovim-and-auto-reload-nerbtree
" trigger `autoread` when files changes on disk
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" notification after file change
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
]])
-- vim.cmd([[set winbar=%=%m%h%w\ %f]]) -- wait fot  vim 0.8.0
-- For auto reload file to buffer
-- vim.cmd([[set autoread | au CursorHold * checktime | call feedkeys("lh")]])


-- TODO: create your own when you have the time
-- originally from: https://github.com/golang/tools/blob/6e9046bfcd34178dc116189817430a2ad1ee7b43/gopls/doc/vim.md#imports
-- there's a lot of config from goalng/tools pagea, check it if you ahve the time
-- https://neovim.io/doc/user/lsp.html
--
function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        -- local client = vim.lsp.get_client_by_id(ctx.client_id)
        -- vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-16")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.cmd([[
  augroup GO_LSP
    " autocmd!
    " autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting()
    autocmd BufWritePre *.go lua OrgImports(1000)
  augroup END
  autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc
  " To make background transparent
  "highlight Normal ctermbg=none guibg=none
]])

-- YAML
vim.cmd([[
  autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 ruler
  set expandtab
  let g:indentLine_char = '⦙'
]])

