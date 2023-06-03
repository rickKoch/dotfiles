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
    packer = require 'packer'
    packer.init()
  end

  local use = packer.use
  packer.reset()

  -- Packer
  use 'wbthomason/packer.nvim'

    --
    -- UI
    --
    use { "catppuccin/nvim", as = "catppuccin",
        config = function()
            require("rickKoch.colorscheme")
        end
    }
    use {'nvim-tree/nvim-web-devicons',
        config = function()
            require("nvim-web-devicons").setup()
        end
    }
    use {'rcarriga/nvim-notify',
        config = function()
            require("rickKoch.notify")
        end
    }
    use {
        'akinsho/bufferline.nvim',
        config = function()
            require("rickKoch.bufferline")
        end
    }
    use {
        'nvim-lualine/lualine.nvim',
        config = function()
            require("rickKoch.lualine")
        end
    }
    use {
        'rmagatti/auto-session',
        config = function()
            require("rickKoch.session")
        end
}

    --
    -- BASIC
    --
    use {
      'nvim-treesitter/nvim-treesitter',
      run = 'TSUpdate',
      config = function()
          require("rickKoch.treesitter")
      end,
      -- requires = {
      --   "nvim-treesitter/nvim-treesitter-textobjects",
      --   "nvim-treesitter/nvim-treesitter-context",
      --   "lewis6991/spellsitter.nvim",
      -- },
    }
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("rickKoch.indent")
        end
    }
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require("gitsigns").setup()
        end
    }
    use ({
        'Wansmer/treesj',
        requires = { 'nvim-treesitter' },
        config = function()
            require('treesj').setup({--[[ your config ]]})
        end,
    })
    use {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup({
                highlight = {
                    keyword = "bg",
                },
            })
        end
    }
    use {
        'stevearc/dressing.nvim',
        config = function()
            require("dressing").setup({})
        end
    }
    use {
        'j-hui/fidget.nvim',
        config = function()
            require("fidget").setup({
                text = { spinner = "dots_pulse" },
            })
        end
    }
    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-go",
        },
        config = function()
            require("rickKoch.test")
        end
    }
    use {
        "ThePrimeagen/harpoon",
        config = function()
            require("rickKoch.harpoon")
        end
    }
    use 'theHamsta/nvim-dap-virtual-text'
    use {
        'yriveiro/dap-go.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    use {
        'mfussenegger/nvim-dap',
        config = function()
            require("rickKoch.debug")
        end
    }
    use 'nvim-telescope/telescope-dap.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function()
            require("rickKoch.telescope")
        end
    }
    use {
        'tpope/vim-fugitive',
        config = function()
            require("rickKoch.fugitive")
        end
    }
    use {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require("rickKoch.tree")
        end
    }
    use {
        'famiu/bufdelete.nvim',
        config = function()
            require("rickKoch.bufremove")
        end
    }
    use({
        "asiryk/auto-hlsearch.nvim",
        tag = "1.1.0" ,
        config = function()
            require("auto-hlsearch").setup()
        end
    })

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

    --
    -- CODING
    --
    use 'hrsh7th/nvim-cmp'
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use {'jose-elias-alvarez/null-ls.nvim'}
    use {
        'folke/neodev.nvim',
        config = function()
            require("neodev").setup({})
        end
    }
    use {
        'sar/luasnip.nvim',
        config = function()
            require("luasnip").setup({
            -- see: https://github.com/L3MON4D3/LuaSnip/issues/525
            region_check_events = "InsertEnter",
            delete_check_events = "InsertLeave",
            })
        end
    }

    -- require("luasnip.loaders.from_vscode").lazy_load()
    -- require("nvim-autopairs").setup({ check_ts = true })
    -- require("nvim-ts-autotag").setup({ enable = true })
    use "neovim/nvim-lspconfig"
    use 'hrsh7th/cmp-nvim-lsp'
    use 'lvimuser/lsp-inlayhints.nvim'
    use 'simrat39/symbols-outline.nvim'
    require("rickKoch.lsp")

    require("rickKoch.cmp")
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup()
        end
    })
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use {
        'rgroli/other.nvim',
        config = function()
            require("rickKoch.other")
        end
    }
end

local function init()
  require("rickKoch.options")
  require("rickKoch.keymaps")
  require("rickKoch.autocommands")
  packer_verify()
  packer_startup()
end

return {
  init = init
}
