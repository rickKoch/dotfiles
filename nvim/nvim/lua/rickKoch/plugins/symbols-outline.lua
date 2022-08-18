local function init()
  require("symbols-outline").setup()
  local map = vim.api.nvim_set_keymap
  local mapOpts = { noremap = true }

  vim.g.symbols_outline = {
    width = 25,
  }

  map('n', '<leader>sd', '<CMD>lua require("auto-session").DeleteSession()<CR>', mapOpts)
end

return {
  init = init
}
