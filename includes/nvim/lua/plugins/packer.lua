local fn = vim.fn
vim = vim
use = use
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd 'packadd packer.nvim'
end

-- -- --- --
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()

return require('packer').startup(function()
  -- you know, for reloading packer
  vim.cmd([[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost packer.lua source <afile> | PackerCompile
    augroup end
  ]])

  use {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('plugins.config.tree-sitter')
    end
  }
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
    "williamboman/mason.nvim",
    requires = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      -- "fatih/vim-go",
    },
    config = function()
      require('plugins.config.lsp')
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "all" }
      })
      --
      -- vim-go related
      -- disabling vim-go due to shortcut colision, need more setup
      -- vim.g.go_gopls_enabled = "0"
      -- vim.g.go_fmt_autosave = "0"
      -- vim.g.go_imports_autosave = "0"
    end,
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    },
  }

  -- Note: vim-closer is plugin disabled due to always appending
  -- braces after the new line, pretty annoying, left here for future reference
  -- use '9mm/vim-closer'

  -- Lazy loading:
  -- Load on specific commands
  use { 'tpope/vim-surround' }



  -- Post-install/update hook with neovim command
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- # Splash Screen
  -- use { 'mhinz/vim-startify' } -- splash screen, cowsay
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require 'alpha'.setup(require 'alpha.themes.startify'.config)
    end
  }
  use {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = 'info',
        auto_session_suppress_dirs = { '~/', '~/Projects' },
        auto_session_enable_last_session = true,
      }
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
      require('session-lens').setup({
        --[[your custom config--]]
      })
    end,
    requires = {
      'nvim-telescope/telescope.nvim',
      'rmagatti/session-lens',
    },
  }

  -- Others
  use { 'rcarriga/nvim-notify' }

  -- Fuzzy Finder
  use { 'nvim-lua/popup.nvim' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
    config = function()
      require('plugins.config.telescope')
      require('telescope').load_extension('projects')
    end
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  -- Snippet
  use { "rafamadriz/friendly-snippets" }

  -- LSP
  use { 'neovim/nvim-lspconfig' }
  use { 'simrat39/rust-tools.nvim' }
  use {
    'jose-elias-alvarez/typescript.nvim',
    -- the setup is put in lsp.lua
  }

  -- Auto Complete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require('plugins.config.cmp')
      -- require("luasnip.loaders.from_lua").lazy_load({ include = { "all", "go" } })
    end
  }
  use 'mattn/emmet-vim'

  -- Airline
  -- use {
  --   'glepnir/galaxyline.nvim',
  --     branch = 'main',
  --     -- your statusline
  --     config = function() require'plugins.config.galaxyline' end,
  --     -- some optional icons
  --     requires = {'kyazdani42/nvim-web-devicons', opt = true}
  -- }
  use 'feline-nvim/feline.nvim'
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }


  -- # Tree File Explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', },
    tag = 'nightly', -- optional, updated every week
    config = function()
      require 'nvim-tree'.setup {
        diagnostics = {
          enable = true,
          show_on_dirs = true,
        },
        renderer = {
          indent_markers = {
            enable = false,
          },
        },
        git = {
          enable = false,
        },
        respect_buf_cwd = true,
        hijack_netrw = true,
        update_cwd = false,
        update_focused_file = {
          enable = false,
          update_cwd = true
        },
        filters = {
          custom = { "^.git$" }
        },
        view = {
          side = "right"
        },
      }
    end
  }
  use { 'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- Debugging
  use { 'nvim-telescope/telescope-dap.nvim' }
  use {
    'mfussenegger/nvim-dap',
    config = function()
      require('plugins.config.dap-go')
    end
  }

  -- Below general vim plugin
  use('editorconfig/editorconfig-vim')

  -- Themes
  -- " Theme
  -- "use ('rakr/vim-one')
  -- "use ('bluz71/vim-nightfly-guicolors')
  use { 'NLKNguyen/papercolor-theme' }
  use { 'rafedramzi/panda-vim' } -- forked from markvincze/panda-vim
  use { 'challenger-deep-theme/vim' }
  use {'navarasu/onedark.nvim',
    config = function ()
     require('onedark').setup {
          style = 'deep'
      }
      -- require('onedark').load()
    end
  }
  use { 'catppuccin/nvim', as = "catppuccin" }
  use { 'dracula/vim', as = 'dracula' }
  use { 'tomasr/molokai' }
  use { 'nanotech/jellybeans.vim' }
  use { 'pangloss/vim-javascript' }
  use { 'embark-theme/vim', as = 'embark' }
  use { 'cideM/yui' }
  use {
    'sainnhe/sonokai',
    config = function()
      -- vim.g.sonokai_style = 'shusia' -- see :help sonokai for the available themes
      vim.g.sonokai_better_performance = 1
    end
  }
  use { 'haishanh/night-owl.vim' }
  use {
    'ayu-theme/ayu-vim',
    config = function()
      vim.g.ayucolor = "mirage"
    end
  }
  use { 'lifepillar/vim-gruvbox8' }
  use { 'sainnhe/everforest' }
  use { 'rigellute/rigel' }
  use { 'bluz71/vim-nightfly-guicolors' }
  use {
    'folke/tokyonight.nvim',
    config = function()
      vim.g.tokyonight_style = "night"
    end
  }
  use { 'arzg/vim-colors-xcode' }

  use { 'EdenEast/nightfox.nvim' } -- Packer
  use { 'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = true,
        indent_blankline_use_treesitter = true,
        indent_blankline_show_trailing_blankline_indent = false,
      }
    end
  } -- add vertical line



  -- Others
  use {
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      vim.api.nvim_create_autocmd('BufWinEnter', {
        pattern = '*',
        callback = function()
          if vim.bo.filetype == 'NvimTree' then
            require 'bufferline.api'.set_offset(31, 'FileTree')
          end
        end
      })

      vim.api.nvim_create_autocmd('BufWinLeave', {
        pattern = '*',
        callback = function()
          if vim.fn.expand('<afile>'):match('NvimTree') then
            require 'bufferline.api'.set_offset(0)
          end
        end
      })
    end
  }
  use {
    'windwp/nvim-spectre',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('spectre').setup()
    end
  }

  use { 'junegunn/vim-easy-align' }
  use { "nathom/filetype.nvim",
    config = function()
      -- In init.lua or filetype.nvim's config file
      -- TODO: move your autocommand to here https://www.reddit.com/r/neovim/comments/rvwsl3/introducing_filetypelua_and_a_call_for_help/
      require("filetype").setup({})
    end
  }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use {
    'kosayoda/nvim-lightbulb',
    requires = 'antoinemadec/FixCursorHold.nvim',
    config = function()
      require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
    end
  }

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
  }
  -- Buffer
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, tag = 'release' }

  --- Project Manager
  use { "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        manual_mode = false,
        silent_chdir = false,
        show_hidden = true,
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", ".yarn" },
      }
    end
  }
  -- use {"terryma/vim-multiple-cursors"} -- has the smae shortcut as nvimtre

  -- TODO: nvim bookmark
  -- " TODO: This indent-blankline is really cool! if you have the time to rice your nvim, definiitely take alook at this plugin
  -- Text
  use { 'arthurxavierx/vim-caser' }
  use { 'tpope/vim-abolish' }
  --
  --
  -- TODO: nvim tagbar \w tree sitter
  -- TODO: if you have the time,evaluate these
  --"Plug 'roxma/nvim-completion-manager'
  --"Plug 'SirVer/ultisnips'
  --"Plug 'honza/vim-snippets'
  -- snippets & annotatoins
  use {
    "danymat/neogen",
    config = function()
      require('neogen').setup {
        enabled = true
      }
    end,
    requires = "nvim-treesitter/nvim-treesitter"
  }

  -- TERMINAL
  use {
    "akinsho/toggleterm.nvim",
    tag = 'v2.*',
    config = function()
      require("toggleterm").setup()
    end
  }

  -- Visual
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
end)
