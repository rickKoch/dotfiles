local cmd = vim.api.nvim_command
local fn = vim.fn
local packer = nil

local function packer_verify()
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
    cmd 'packadd packer.nvim'
  end
end

local function options()
  vim.opt.compatible = false
  vim.opt.clipboard = "unnamedplus"
  vim.opt.hidden = true
  vim.opt.updatetime = 1000 -- faster update times, default 4000
  vim.opt.mouse = "a"
  vim.opt.inccommand = "split"
  vim.opt.splitbelow = true
  vim.opt.splitright = true
  vim.opt.wrap = false
  vim.opt.textwidth = 0
  vim.opt.expandtab = true
  vim.opt.smartindent = true
  vim.opt.shiftwidth = 2
  vim.opt.softtabstop = 2
  vim.opt.tabstop = 2
  -- vim.opt.signcolumn = "yes"
  vim.opt.scrolloff = 10
  vim.opt.sidescrolloff = 10
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.swapfile = false
  vim.opt.backup = false
  vim.opt.undofile = true
  vim.opt.undodir = vim.fn.stdpath("data") .. "undodir"
  vim.opt.hlsearch = true
  vim.opt.ignorecase = true
  vim.opt.incsearch = true
  vim.opt.ruler = true
  vim.opt.wildmenu = true
  vim.opt.autoread = true
  vim.opt.completeopt = { "menu", "menuone", "noselect" }
  vim.opt.colorcolumn = "80"
  vim.opt.backspace = { "indent", "eol", "start" }
  vim.opt.spell = true
  vim.opt.spelllang = { "en_us" }
  vim.opt.laststatus = 3
  vim.opt.cursorline = true
  vim.opt.list = false
  vim.opt.listchars = "eol:↲,tab:» ,trail:·,extends:<,precedes:>,conceal:┊,nbsp:␣"
  vim.opt.grepprg = "rg --vimgrep --smart-case --follow"
  vim.opt.background = "dark"
  -- vim.opt.termguicolors = true
  vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

  vim.opt.shortmess:append("c")
  -- vim.opt.nrformats:append("alpha") -- most of the time I dont want this

  vim.filetype.add({
    extension = {
      tape = "vhs",
    },
  })

  vim.cmd([[
iabbrev descriptoin description
iabbrev fucn func
iabbrev sicne since
iabbrev emtpy empty
]])
end


local function keymaps()
  local opts = { noremap = true, silent = true }

  -- Shorten function name
  local keymap = vim.keymap.set

  --Remap space as leader key
  keymap("", "<Space>", "<Nop>", opts)
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  -- Normal --
  -- disable Ex mode, I always enter in it by mistake
  keymap("n", "Q", "<Nop>", opts)

  -- create and edit new buffer
  keymap("n", "<leader>n", ":enew<CR>", opts)

  -- quicklists
  keymap("n", "<leader>co", ":copen<CR>", opts)
  keymap("n", "<leader>cc", ":cclose<CR>", opts)
  keymap("n", "[q", ":cprevious<CR>zz", opts)
  keymap("n", "]q", ":cnext<CR>zz", opts)

  -- Resize with arrows
  keymap("n", "<C-k>", ":resize +2<CR>", opts)
  keymap("n", "<C-j>", ":resize -2<CR>", opts)
  keymap("n", "<C-h>", ":vertical resize -2<CR>", opts)
  keymap("n", "<C-l>", ":vertical resize +2<CR>", opts)

  -- buffer nav
  keymap("n", "<S-l>", ":bnext<CR>", opts)
  keymap("n", "<S-h>", ":bprevious<CR>", opts)

  -- save and quit
  keymap("n", "<leader>w", ":write<CR>", opts)
  keymap("n", "<leader>q", ":quit<CR>", opts)
  keymap("n", "<leader>e", ":Ex<CR>", opts)

  -- paste over without replacing default register
  keymap("n", "<leader>p", '"_dP', opts)

  -- keep more or less in the same place when going next
  keymap("n", "n", "nzzzv", opts)
  keymap("n", "N", "Nzzzv", opts)

  -- keep more or less in the same place when going up/down
  keymap("n", "<C-u>", "<C-u>zz", opts)
  keymap("n", "<C-d>", "<C-d>zz", opts)
  keymap("n", "<C-o>", "<C-o>zz", opts)
  keymap("n", "<C-i>", "<C-i>zz", opts)

  -- move record macro to Q instead of q
  keymap("n", "Q", "q", opts)
  keymap("n", "q", "<Nop>", opts)

  -- Insert empty blank line above/bellow
  keymap("n", "]<Space>", "m`o<Esc>``", opts)
  keymap("n", "[<Space>", "m`O<Esc>``", opts)

  -- system clipboard integration
  keymap("n", "<leader>y", '"+y', opts)
  keymap("n", "<leader>Y", '"+Y', opts)

  -- delete to blackhole
  keymap("n", "<leader>d", '"_d', opts)
  keymap("n", "<leader>D", '"_D', opts)

  -- Insert --
  -- in insert mode, adds new undo points after , . ! and ?.
  keymap("i", "-", "-<c-g>u", opts)
  keymap("i", "_", "_<c-g>u", opts)
  keymap("i", ",", ",<c-g>u", opts)
  keymap("i", ".", ".<c-g>u", opts)
  keymap("i", "!", "!<c-g>u", opts)
  keymap("i", "?", "?<c-g>u", opts)

  -- alias quick jk/kj to esc
  keymap("i", "jk", "<ESC>", opts)
  keymap("i", "kj", "<ESC>", opts)

  -- Visual --
  -- Stay in indent mode
  keymap("v", "<", "<gv", opts)
  keymap("v", ">", ">gv", opts)

  -- Move text up and down
  keymap("v", "<A-j>", ":m .+1<CR>==", opts)
  keymap("v", "<A-k>", ":m .-2<CR>==", opts)

  -- If I visually select words and paste from clipboard, don't replace my:
  -- clipboard with the selected word, instead keep my old word in the
  -- clipboard
  keymap("v", "p", '"_dP', opts)

  -- system clipboard integration
  keymap("v", "<leader>y", '"+y', opts)
  keymap("v", "<leader>Y", '"+Y', opts)

  -- delete to blackhole
  keymap("v", "<leader>d", '"_d', opts)
  keymap("v", "<leader>D", '"_D', opts)

  -- Visual Block --
  -- Move text up and down
  keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
  keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
  keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
  keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

  -- clear search highlight
  keymap("n", "<Leader>h", ":noh<CR>", opts)
end

local function autocommands()
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.dockerfile",
    callback = function()
      vim.opt_local.ft = "dockerfile"
    end,
    group = vim.api.nvim_create_augroup("Dockerfile", { clear = true }),
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    command = "startinsert",
    group = vim.api.nvim_create_augroup("AutoInsert", { clear = true }),
  })

  -- ensure the parent folder exists, so it gets properly added to the lsp
  -- context and everything just works.
  vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*",
    callback = function()
      local dir = vim.fn.expand("<afile>:p:h")
      if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
        vim.cmd([[ :e % ]])
      end
    end,
    group = vim.api.nvim_create_augroup("Mkdir", { clear = true }),
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
      vim.cmd([[
            let save = winsaveview()
            keeppatterns %s/\s\+$//e
            call winrestview(save)
        ]])
    end,
    group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true }),
  })

  -- Highlight on yank
  -- See `:help vim.highlight.on_yank()`
  vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
      vim.highlight.on_yank()
    end,
    group = vim.api.nvim_create_augroup("Highlight", { clear = true }),
  })

  -- resize splits if window got resized
  vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
      vim.cmd("tabdo wincmd =")
    end,
  })

  -- Open help window in a vertical split to the right.
  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("help_window_right", {}),
    pattern = { "*.txt" },
    callback = function()
      if vim.o.filetype == "help" then
        vim.cmd.wincmd("L")
      end
    end,
  })
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

  use { "ellisonleao/gruvbox.nvim", as = "gruvbox",
    config = function()
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "",  -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })
      vim.cmd.colorscheme("gruvbox")

      vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = 'Plum3', bold = true })
      vim.api.nvim_set_hl(0, 'LineNr', { fg = 'White', bold = true })
      vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = 'Plum2', bold = true })
      -- vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 'LightMagenta', bg = 'LightMagenta' })
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = 'TSUpdate',
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        endwise = {
          enable = true,
        },
        autopairs = {
          enable = true,
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",   -- maps in normal mode to init the node/scope selection with ctrl+space
            node_incremental = "<C-space>", -- increment to the upper named parent
            node_decremental = "<bs>",      -- decrement to the previous node
            scope_incremental = "<noop>",   -- increment to the upper scope (as defined in locals.scm)
          },
        },
        auto_install = false,
        textobjects = {
          enable = true,
          lookahead = true,
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
              ["]a"] = "@parameter.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
              ["]A"] = "@parameter.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
              ["[a"] = "@parameter.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
              ["[A"] = "@parameter.outer",
            },
          },
          select = {
            enable = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",

              ["ac"] = "@conditional.outer",
              ["ic"] = "@conditional.inner",

              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",

              ["av"] = "@variable.outer",
              ["iv"] = "@variable.inner",
            },
          },
        },
      })
    end,
  }

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
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
end

local function init()
  options()
  keymaps()
  autocommands()
  packer_verify()
  packer_startup()
end

init()
