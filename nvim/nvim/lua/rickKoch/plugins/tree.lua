local function init()
  local map = vim.api.nvim_set_keymap

  local mapOpts = { noremap = true }

  local opts = {
    view = {
      side = "left",
    },
    update_focused_file = {
      enable = true,
      update_root = true,
    }
  }

  require'nvim-tree'.setup(opts)

  map('n', '<leader>tv', '<CMD>NvimTreeToggle<CR>', mapOpts)
end

return {
  init = init
}
