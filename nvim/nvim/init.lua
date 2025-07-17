-- theme & transparency
vim.cmd.colorscheme("unokai")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- Basic settings
vim.opt.number = true                              -- Line numbers
vim.opt.relativenumber = true                      -- Relative line numbers
vim.opt.cursorline = true                          -- Highlight current line
vim.opt.wrap = false                               -- Don't wrap lines
vim.opt.scrolloff = 10                             -- Keep 10 lines above/below cursor 
vim.opt.sidescrolloff = 8                          -- Keep 8 columns left/right of cursor

-- Indentation
vim.opt.tabstop = 2                                -- Tab width
vim.opt.shiftwidth = 2                             -- Indent width
vim.opt.softtabstop = 2                            -- Soft tab stop
vim.opt.expandtab = true                           -- Use spaces instead of tabs
vim.opt.smartindent = true                         -- Smart auto-indenting
vim.opt.autoindent = true                          -- Copy indent from current line

-- Search settings
vim.opt.ignorecase = true                          -- Case insensitive search
vim.opt.smartcase = true                           -- Case sensitive if uppercase in search
vim.opt.hlsearch = false                           -- Don't highlight search results 
vim.opt.incsearch = true                           -- Show matches as you type

-- Visual settings
vim.opt.termguicolors = true                       -- Enable 24-bit colors
vim.opt.signcolumn = "yes"                         -- Always show sign column
vim.opt.colorcolumn = "100"                        -- Show column at 100 characters
vim.opt.showmatch = true                           -- Highlight matching brackets
vim.opt.matchtime = 2                              -- How long to show matching bracket
vim.opt.cmdheight = 1                              -- Command line height
vim.opt.completeopt = "menuone,noinsert,noselect"  -- Completion options 
vim.opt.showmode = false                           -- Don't show mode in command line 
vim.opt.pumheight = 10                             -- Popup menu height 
vim.opt.pumblend = 10                              -- Popup menu transparency 
vim.opt.winblend = 0                               -- Floating window transparency 
vim.opt.conceallevel = 0                           -- Don't hide markup 
vim.opt.concealcursor = ""                         -- Don't hide cursor line markup 
vim.opt.lazyredraw = true                          -- Don't redraw during macros
vim.opt.synmaxcol = 300                            -- Syntax highlighting limit 

-- File handling
vim.opt.backup = false                             -- Don't create backup files
vim.opt.writebackup = false                        -- Don't create backup before writing
vim.opt.swapfile = false                           -- Don't create swap files
vim.opt.undofile = true                            -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")  -- Undo directory
vim.opt.updatetime = 300                           -- Faster completion
vim.opt.timeoutlen = 500                           -- Key timeout duration
vim.opt.ttimeoutlen = 0                            -- Key code timeout
vim.opt.autoread = true                            -- Auto reload files changed outside vim
vim.opt.autowrite = false                          -- Don't auto save

-- Behavior settings
vim.opt.hidden = true                              -- Allow hidden buffers
vim.opt.errorbells = false                         -- No error bells
vim.opt.backspace = "indent,eol,start"             -- Better backspace behavior
vim.opt.autochdir = false                          -- Don't auto change directory
vim.opt.iskeyword:append("-")                      -- Treat dash as part of word
vim.opt.path:append("**")                          -- include subdirectories in search
vim.opt.selection = "exclusive"                    -- Selection behavior
vim.opt.mouse = "a"                                -- Enable mouse support
vim.opt.clipboard:append("unnamedplus")            -- Use system clipboard
vim.opt.modifiable = true                          -- Allow buffer modifications
vim.opt.encoding = "UTF-8"                         -- Set encoding

-- Cursor settings
vim.opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Folding settings
vim.opt.foldmethod = "expr"                        -- Use expression for folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"    -- Use treesitter for folding
vim.opt.foldlevel = 99                             -- Start with all folds open

-- Split behavior
vim.opt.splitbelow = true                          -- Horizontal splits go below
vim.opt.splitright = true                          -- Vertical splits go right


local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

-- Key mappings
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "                              -- Set leader key to space
vim.g.maplocalleader = " "                         -- Set local leader key (NEW)

-- Normal mode mappings
keymap("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- disable Ex mode, I always enter in it by mistake
keymap("n", "Q", "<Nop>", opts)

-- create and edit new buffer
keymap("n", "<leader>n", ":enew<CR>", opts)

-- Y to EOL
keymap("n", "Y", "y$", { desc = "Yank to end of line" })

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

-- Center screen when jumping
keymap("n", "n", "nzzzv", { desc = "Next search result (centered)" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- keep more or less in the same place when going up/down
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-o>", "<C-o>zz", opts)
keymap("n", "<C-i>", "<C-i>zz", opts)

-- paste over without replacing default register
keymap("n", "<leader>p", '"_dP', opts)

-- move record macro to Q instead of q
keymap("n", "Q", "q", opts)
keymap("n", "q", "<Nop>", opts)

-- system clipboard integration
keymap("n", "<leader>y", '"+y', opts)
keymap("n", "<leader>Y", '"+Y', opts)

-- Delete without yanking, delete to blackhole
keymap("n", "<leader>d", '"_d', opts)
keymap("n", "<leader>D", '"_D', opts)

-- Buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Quick file navigation
keymap("n", "<leader>e", ":Explore<CR>", { desc = "Open file explorer" })
keymap("n", "<leader>ff", ":find ", { desc = "Find file" })

-- Quick config editing
keymap("n", "<leader>rc", ":e ~/.config/nvim/init.lua<CR>", { desc = "Edit config" })

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
-- Better indenting in visual mode
keymap("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap("v", ">", ">gv", { desc = "Indent right and reselect" })

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


-- ============================================================================
-- USEFUL FUNCTIONS
-- ============================================================================

-- Copy Full File-Path
vim.keymap.set("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end)

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Set filetype-specific settings
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "lua", "python" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "javascript", "typescript", "json", "html", "css" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- Auto-close terminal when process exits
vim.api.nvim_create_autocmd("TermClose", {
  group = augroup,
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, {})
    end
  end,
})

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- Better diff options
vim.opt.diffopt:append("linematch:60")

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end

-- ============================================================================
-- FLOATING TERMINAL
-- ============================================================================

-- terminal
local terminal_state = {
  buf = nil,
  win = nil,
  is_open = false
}

local function FloatingTerminal()
  -- If terminal is already open, close it (toggle behavior)
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
    return
  end

  -- Create buffer if it doesn't exist or is invalid
  if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
    terminal_state.buf = vim.api.nvim_create_buf(false, true)
    -- Set buffer options for better terminal experience
    vim.api.nvim_buf_set_option(terminal_state.buf, 'bufhidden', 'hide')
  end

  -- Calculate window dimensions
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create the floating window
  terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- Set transparency for the floating window
  vim.api.nvim_win_set_option(terminal_state.win, 'winblend', 0)

  -- Set transparent background for the window
  vim.api.nvim_win_set_option(terminal_state.win, 'winhighlight',
    'Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder')

  -- Define highlight groups for transparency
  vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none", })

  -- Start terminal if not already running
  local has_terminal = false
  local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
  for _, line in ipairs(lines) do
    if line ~= "" then
      has_terminal = true
      break
    end
  end

  if not has_terminal then
    vim.fn.termopen(os.getenv("SHELL"))
  end

  terminal_state.is_open = true
  vim.cmd("startinsert")

  -- Set up auto-close on buffer leave 
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = terminal_state.buf,
    callback = function()
      if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
      end
    end,
    once = true
  })
end

-- Function to explicitly close the terminal
local function CloseFloatingTerminal()
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
  end
end

-- Key mappings
vim.keymap.set("n", "<leader>t", FloatingTerminal, { noremap = true, silent = true, desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc>", function()
  if terminal_state.is_open then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
  end
end, { noremap = true, silent = true, desc = "Close floating terminal from terminal mode" })


-- ============================================================================
-- TABS
-- ============================================================================

-- Tab display settings
vim.opt.showtabline = 1  -- Always show tabline (0=never, 1=when multiple tabs, 2=always)
vim.opt.tabline = ''     -- Use default tabline (empty string uses built-in)

-- Transparent tabline appearance
vim.cmd([[
  hi TabLineFill guibg=NONE ctermfg=242 ctermbg=NONE
]])

-- Alternative navigation (more intuitive)
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', { desc = 'Close tab' })

-- Tab moving
vim.keymap.set('n', '<leader>tm', ':tabmove<CR>', { desc = 'Move tab' })
vim.keymap.set('n', '<leader>t>', ':tabmove +1<CR>', { desc = 'Move tab right' })
vim.keymap.set('n', '<leader>t<', ':tabmove -1<CR>', { desc = 'Move tab left' })

-- Function to open file in new tab
local function open_file_in_tab()
  vim.ui.input({ prompt = 'File to open in new tab: ', completion = 'file' }, function(input)
    if input and input ~= '' then
      vim.cmd('tabnew ' .. input)
    end
  end)
end

-- Function to duplicate current tab
local function duplicate_tab()
  local current_file = vim.fn.expand('%:p')
  if current_file ~= '' then
    vim.cmd('tabnew ' .. current_file)
  else
    vim.cmd('tabnew')
  end
end

-- Function to close tabs to the right
local function close_tabs_right()
  local current_tab = vim.fn.tabpagenr()
  local last_tab = vim.fn.tabpagenr('$')

  for i = last_tab, current_tab + 1, -1 do
    vim.cmd(i .. 'tabclose')
  end
end

-- Function to close tabs to the left
local function close_tabs_left()
  local current_tab = vim.fn.tabpagenr()

  for i = current_tab - 1, 1, -1 do
    vim.cmd('1tabclose')
  end
end

-- Enhanced keybindings
vim.keymap.set('n', '<leader>tO', open_file_in_tab, { desc = 'Open file in new tab' })
vim.keymap.set('n', '<leader>td', duplicate_tab, { desc = 'Duplicate current tab' })
vim.keymap.set('n', '<leader>tr', close_tabs_right, { desc = 'Close tabs to the right' })
vim.keymap.set('n', '<leader>tL', close_tabs_left, { desc = 'Close tabs to the left' })

-- Function to close buffer but keep tab if it's the only buffer in tab
local function smart_close_buffer()
  local buffers_in_tab = #vim.fn.tabpagebuflist()
  if buffers_in_tab > 1 then
    vim.cmd('bdelete')
  else
    -- If it's the only buffer in tab, close the tab
    vim.cmd('tabclose')
  end
end
vim.keymap.set('n', '<leader>bd', smart_close_buffer, { desc = 'Smart close buffer/tab' })

-- ============================================================================
-- STATUSLINE
-- ============================================================================

-- Git branch function
local function git_branch()
  local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
  if branch ~= "" then
    return "  " .. branch .. " "
  end
  return ""
end

-- File type with icon
local function file_type()
  local ft = vim.bo.filetype
  local icons = {
    lua = "[LUA]",
    python = "[PY]",
    javascript = "[JS]",
    html = "[HTML]",
    css = "[CSS]",
    json = "[JSON]",
    markdown = "[MD]",
    vim = "[VIM]",
    sh = "[SH]",
    go = "[GO]",
  }

  if ft == "" then
    return "  "
  end

  return (icons[ft] or ft)
end

-- Word count for text files
local function word_count()
  local ft = vim.bo.filetype
  if ft == "markdown" or ft == "text" or ft == "tex" then
    local words = vim.fn.wordcount().words
    return "  " .. words .. " words "
  end
  return ""
end

-- File size
local function file_size()
  local size = vim.fn.getfsize(vim.fn.expand('%'))
  if size < 0 then return "" end
  if size < 1024 then
    return size .. "B "
  elseif size < 1024 * 1024 then
    return string.format("%.1fK", size / 1024)
  else
    return string.format("%.1fM", size / 1024 / 1024)
  end
end

-- Mode indicators with icons
local function mode_icon()
  local mode = vim.fn.mode()
  local modes = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    ["\22"] = "V-BLOCK",  -- Ctrl-V
    c = "COMMAND",
    s = "SELECT",
    S = "S-LINE",
    ["\19"] = "S-BLOCK",  -- Ctrl-S
    R = "REPLACE",
    r = "REPLACE",
    ["!"] = "SHELL",
    t = "TERMINAL"
  }
  return modes[mode] or "  " .. mode:upper()
end

_G.mode_icon = mode_icon
_G.git_branch = git_branch
_G.file_type = file_type
_G.file_size = file_size

vim.cmd([[
  highlight StatusLineBold gui=bold cterm=bold
]])

-- Function to change statusline based on window focus
local function setup_dynamic_statusline()
  vim.api.nvim_create_autocmd({"WinEnter", "BufEnter"}, {
    callback = function()
    vim.opt_local.statusline = table.concat {
      "  ",
      "%#StatusLineBold#",
      "%{v:lua.mode_icon()}",
      "%#StatusLine#",
      " │ %f %h%m%r",
      "%{v:lua.git_branch()}",
      " │ ",
      "%{v:lua.file_type()}",
      " | ",
      "%{v:lua.file_size()}",
      "%=",                     -- Right-align everything after this
      "%l:%c  %P ",             -- Line:Column and Percentage
    }
    end
  })
  vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

  vim.api.nvim_create_autocmd({"WinLeave", "BufLeave"}, {
    callback = function()
      vim.opt_local.statusline = "  %f %h%m%r │ %{v:lua.file_type()} | %=  %l:%c   %P "
    end
  })
end

setup_dynamic_statusline()

local function packer_verify()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.api.nvim_command 'packadd packer.nvim'
  end
end

packer_verify()

local function packer_startup()
  if packer == nil then
    packer = require 'packer'
    packer.init()
  end

  local use = packer.use
  packer.reset()

  -- Packer
  use 'wbthomason/packer.nvim'

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

  -- use {
  --   "folke/todo-comments.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("todo-comments").setup({
  --       highlight = {
  --         keyword = "bg",
  --       },
  --     })
  --   end
  -- }
  --
  -- use {
  --   'numToStr/Comment.nvim',
  --   config = function()
  --     require('Comment').setup()
  --   end
  -- }
end
