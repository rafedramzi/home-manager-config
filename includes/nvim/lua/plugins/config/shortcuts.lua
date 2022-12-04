local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")

-- # Auto Completion
-- # Fuzzy Finder
--
-- ## Telescope
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>tegf', [[<Cmd>lua require('telescope.builtin').git_files()<CR>]],
  { noremap = true, silent = true })

-- # NvimTree
vim.api.nvim_set_keymap('n', '<leader>nf', ':NvimTreeFindFile<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>nt', ':NvimTreeToggle<cr>', { noremap = true, silent = true })

-- Telescope File Browser
--vim.api.nvim_set_keymap('n', '<leader>nf', ':Telescope file_browser<cr>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>nt', ':NvimTreeToggle<cr>', { noremap = true, silent = true })



-- # DAP
vim.api.nvim_set_keymap('n', '<F5>', [[:lua require'dap'.continue()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F10>', [[:lua require'dap'.step_over()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F11>', [[:lua require'dap'.step_into()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', [[:lua require'dap'.step_out()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', [[:lua require'dap'.toggle_breakpoint()<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>B',
  [[:lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lp',
  [[:lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dr', [[:lua require'dap'.repl.open()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dl', [[:lua require'dap'.run_last()<CR>]], { noremap = true, silent = true })



-- # Trouble
-- With telescope

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
}

-- Lua
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>",
  { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })

vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Qa", "qa", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})
-- scroll
-- vim.api.nvim_set_keymap("n", "<ScrollWheelUp>", "k", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap("n", "<ScrollWheelDown>", "j", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>pp', ':Telescope projects<CR>', { noremap = true, silent = true, })
vim.api.nvim_set_keymap('n', '<leader>tm', ':Telescope keymaps<CR>', { noremap = true, silent = true, })
-- buffer nav (only works on non termial due to tab registered as ctrl key)
vim.api.nvim_set_keymap("n", "<C-Tab>", "<cmd>BufferNext<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<C-S-Tab>", "<cmd>BufferPrevious<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<C-x>", "<cmd>BufferClose<cr>", { silent = true, noremap = true })
--
