-- LSP Config: check https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#gopls for full configuration
-- Standard nvim-lsp config
local nvim_lsp = require('lspconfig')
local util = nvim_lsp.util

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set('n', '<space>go', vim.diagnostic.open_float, bufopts)


  -- just like kickstart nvim
  -- https://github.com/nvim-lua/kickstart.nvim/blob/c73aefcb210125677aea9e62366c24beb0211b79/init.lua#L310
  vim.keymap.set('n', 'ws', ':Telescope lsp_dynamic_workspace_symbols<cr>', bufopts)
  vim.keymap.set('n', 'ds', ':Telescope lsp_document_symbols<cr>', bufopts)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = {
  -- 'denols',
  'bufls',
  'jsonls',
  'golangci_lint_ls',
  'graphql',
  'prismals',
  -- 'rome',
  -- 'stylelint_lsp',
  'pyright',
  'rnix',
  'rust_analyzer',
  'cssmodules_ls',
  'tailwindcss',
  -- 'tsserver',
  'vuels',
  'zls',
}

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end


nvim_lsp["clangd"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
}

nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  log_level = 2,
  root_dir = util.root_pattern("init.lua") or util.root_pattern(".git") or bufdir,
  settings = {
    Lua = {
      telemetry = {
        enable = false,
      }
    }
  },
  single_file_support = true,
}


-- -- NOTE: we're disabling eslint, too annoying for me, use git pre-commit instead
-- nvim_lsp["eslint"].setup {
--   on_attach = on_attach,
--   flags = lsp_flags,
--   settings = {
--     codeAction = {
--       disableRuleComment = {
--         enable = true,
--         location = "separateLine"
--       },
--       showDocumentation = {
--         enable = true
--       }
--     },
--     codeActionOnSave = {
--       enable = true,
--       mode = "all"
--     },
--     format = true,
--     nodePath = "",
--     onIgnoredFiles = "off",
--     packageManager = "npm",
--     quiet = false,
--     rulesCustomizations = {},
--     run = "onType",
--     useESLintClass = false,
--     validate = "on",
--     workingDirectory = {
--       mode = "location"
--     }
--   }
-- }

nvim_lsp["jsonls"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
  cmd = { "/usr/bin/vscode-json-languageserver", '--stdio' },
}

nvim_lsp["gopls"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls", "-mode=stdio", "-remote=auto" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
  -- why? this annoying issue
  -- disussion
  -- - https://www.reddit.com/r/neovim/comments/mm1h0t/lsp_diagnostics_remain_stuck_can_someone_please/
  flags = vim.tbl_deep_extend("force", lsp_flags, {
    allow_incremental_sync = false,
    debounce_text_changes = 300,
  }),
}


-- typescript.nvim
local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

nvim_lsp["tsserver"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities, commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports"
    }
  }
}

-- require("typescript").setup({
--     -- disable_commands = false, -- prevent the plugin from creating Vim commands
--     -- debug = false, -- enable debug logging for commands
--     server = { -- pass options to lspconfig's setup method
--       on_attach = on_attach,
--       flags = lsp_flags,
--     },
-- })
--
