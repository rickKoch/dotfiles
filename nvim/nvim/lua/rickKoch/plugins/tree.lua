local function init()
  local map = vim.api.nvim_set_keymap

  local mapOpts = { noremap = true }

  local opts = {
    view = {
      side = "left",
    },
  }

  require'nvim-tree'.setup(opts)

  map('n', '<leader>tv', '<CMD>NvimTreeToggle<CR>', mapOpts)
end

return {
  init = init
}
