local cmd = vim.api.nvim_command
local fn = vim.fn
local packer = nil

local function packer_verify()
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
    cmd 'packadd packer.nvim'
  end
end

local function packer_startup()
  if packer == nil then
    packer = require'packer'
    packer.init()
  end

  local use = packer.use
  packer.reset()

  -- Packer
  use 'wbthomason/packer.nvim'

  -- nvim-tree
  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require 'rickKoch.plugins.tree'.init()
    end,
  }

  -- the whole lsp, luasnip and cmp gang
  use {
    'williamboman/mason.nvim',
    requires = {
      -- lsp
      "williamboman/mason-lspconfig.nvim",
      "onsails/lspkind-nvim",
      "neovim/nvim-lspconfig",
      "jose-elias-alvarez/null-ls.nvim",
      "nvim-lua/lsp-status.nvim",
      "simrat39/symbols-outline.nvim",

      -- cmp
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-calc",
      {
        'tzachar/cmp-tabnine',
        run = "./install.sh",
      },

      -- cmp x lsp
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",

      -- snip x cmp
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("lspkind").init()
      require("luasnip.loaders.from_vscode").load()
      require("rickKoch.plugins.lsp")
      require('rickKoch.plugins.symbols-outline').init()
      require("rickKoch.plugins.cmp")
      require'rickKoch.plugins.cmp_tabnine'.init()
    end,
  }

  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  })
  --use {
  --'lspcontainers/lspcontainers.nvim',
  --requires = {
  --'neovim/nvim-lspconfig',
  --'nvim-lua/lsp_extensions.nvim',
  --},
  --config = function ()
  --require'lspcontainers'.setup({
  --ensure_installed = {
  --"bashls",
  --"dockerls",
  --"gopls",
  --"html",
  --"pylsp",
  --"rust_analyzer",
  --"sumneko_lua",
  --"terraformls",
  --"tsserver",
  --"yamlls"
  --}
  --})

  --require'rickKoch.plugins.lspconfig'.init()
  --end
  --}


  --use {
  --'jose-elias-alvarez/null-ls.nvim',
  --config = function ()
  --require'rickKoch.plugins.null-ls'.init()
  --end
  --}

  use 'hashivim/vim-terraform'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = 'TSUpdate',
    config = function()
      require 'rickKoch.plugins.treesitter'.init()
    end,
  }

  -- Completion
  --use {
  --'hrsh7th/nvim-cmp',
  --requires = {
  --'hrsh7th/cmp-buffer',
  --'hrsh7th/cmp-cmdline',
  --'hrsh7th/cmp-path',
  --'hrsh7th/cmp-nvim-lsp',
  --'hrsh7th/cmp-vsnip',
  --'hrsh7th/vim-vsnip',
  --'ray-x/cmp-treesitter',
  --{
  --'tzachar/cmp-tabnine',
  --run = "./install.sh",
  --},
  --'onsails/lspkind-nvim'
  --},
  --config = function ()
  --require'rickKoch.plugins.cmp'.init()
  --require'rickKoch.plugins.cmp_tabnine'.init()
  --require'rickKoch.plugins.lspkind'.init()
  --end
  --}

  -- Telescope
  use 'nvim-lua/popup.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    -- requires = 'rmagatti/session-lens',
    config = function()
      require 'rickKoch.plugins.telescope'.init()
    end
  }

  -- Themes
  use {
    'folke/tokyonight.nvim',
    config = function()
      require 'rickKoch.plugins.tokyonight'.init()
    end
  }

  -- Git Support
  -- use 'rhysd/git-messenger.vim'

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require 'rickKoch.plugins.gitsigns'.init()
    end
  }

  -- Sessions
  --use {
    --'rmagatti/auto-session',
    --config = function ()
      --require'rickKoch.plugins.auto_session'.init()
    --end
  --}

  -- Utilities
  -- use 'unblevable/quick-scope' -- promote use of f<key>

  use 'lukas-reineke/indent-blankline.nvim'

  use {
    'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require 'rickKoch.plugins.lualine'.init()
    end
  }

  use 'preservim/nerdcommenter'

  use 'romgrk/nvim-treesitter-context'

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require "trouble".setup()
    end
  }

  use {
    'folke/lsp-colors.nvim',
    config = function()
      require("lsp-colors").setup()
    end
  }

  use {
    'voldikss/vim-floaterm',
    config = function()
      require 'rickKoch.plugins.floaterm'.init()
    end
  }

  -- VimWiki + Zettelkasten
  use {
    'michal-h21/vim-zettel',
    requires = {
      {
        'junegunn/fzf',
        run = function() vim.fn['fzf#install']() end
      },
      'junegunn/fzf.vim',
      'vimwiki/vimwiki'
    },
    config = function()
      require 'rickKoch.plugins.zettel'.init()
    end
  }

  use {
    'weilbith/nvim-code-action-menu',
    requires = {
      'kosayoda/nvim-lightbulb'
    },
    cmd = 'CodeActionMenu',
    config = function()
      require 'rickKoch.plugins.code_action_menu'.init()
    end
  }
end

local function init()
  packer_verify()
  packer_startup()
end

return {
  init = init
}
