local function set_augroup()
  vim.api.nvim_command("augroup WrapInMarkdown")
  vim.api.nvim_command("autocmd!")
  vim.api.nvim_command("autocmd FileType markdown setlocal wrap")
  vim.api.nvim_command("augroup END")

  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.dockerfile",
    command = "set ft=dockerfile",
    group = vim.api.nvim_create_augroup("Dockerfile", { clear = true }),
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "*.txt", "*.md", "*.tex", "gitcommit", "gitrebase" },
    command = "setlocal spell",
    group = vim.api.nvim_create_augroup("Spell", { clear = true }),
  })

  -- ensure the parent folder exists, so it gets properly added to the lsp context and everything just works.
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
    callback = function()
      vim.cmd([[
        let save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(save)
      ]])
    end,
    pattern = "*",
    group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true }),
  })

  -- [[ Highlight on yank ]]
  -- See `:help vim.highlight.on_yank()`
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      vim.highlight.on_yank()
    end,
    pattern = "*",
    group = vim.api.nvim_create_augroup("Highlight", { clear = true }),
  })

end

local function disable_clipboard_cleaning()
  vim.api.nvim_command("autocmd VimLeave * call system(\"xsel -ib\", getreg('+'))")
end

local function set_vim_g()
  vim.g.mapleader = ","
  vim.g.netrw_winsize = 15
  vim.g.netrw_keepdir = 0
  vim.g.netrw_banner = 0
  vim.g.netrw_localcopydircmd = 'cp -r'
end

local function set_vim_o()
  local settings = {
    backup = false,
    errorbells = false,
    expandtab = true,
    hidden = true,
    scrolloff = 3,
    softtabstop = 2,
    showmode = false,
    termguicolors = true
  }

  -- Generic vim.o
  for k, v in pairs(settings) do
    vim.o[k] = v
  end

  -- Custom vim.o
  vim.o.clipboard = 'unnamedplus'
  vim.o.shortmess = vim.o.shortmess .. 'c'

  -- Not yet in vim.o
  vim.cmd('set encoding=utf8')
  vim.cmd('set nowritebackup')
  vim.cmd('set shiftwidth=2')
  vim.cmd('set secure')
  vim.cmd('set splitright')
  vim.cmd('set tabstop=2')
  vim.cmd('set updatetime=300')
  vim.cmd('set nobackup')
  vim.cmd('set noswapfile')
  vim.cmd('set colorcolumn=80')
end

local function set_vim_wo()
  vim.wo.number = true
  vim.wo.relativenumber = true
  vim.wo.wrap = false
end

local function set_keymaps()
  local map = vim.api.nvim_set_keymap

  local options = { noremap = false }

  map('n', '<leader>h', '<CMD>wincmd h<CR>', options)
  map('n', '<leader>j', '<CMD>wincmd j<CR>', options)
  map('n', '<leader>k', '<CMD>wincmd k<CR>', options)
  map('n', '<leader>l', '<CMD>wincmd l<CR>', options)
end

local function init()
  set_augroup()
  disable_clipboard_cleaning()
  set_vim_g()
  set_vim_o()
  set_vim_wo()
  set_keymaps()
end

return {
  init = init
}
