local function init()
  local actions = require("telescope.actions")
  require'telescope'.setup{
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<Tab>"] = actions.move_selection_previous,
          ["<S-Tab>"] = actions.move_selection_next,
        },
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git",
      },
      color_devicons = true,
      prompt_prefix = "   ",
      file_ignore_patterns = {
        "node_modules/.*",
        "secret.d/.*",
        "%.pem"
      }
    }
  }

  local map = vim.api.nvim_set_keymap

  local options = { noremap = true }

  -- Builtin
  map('n', '<leader>fg', '<CMD>lua require("telescope.builtin").git_files{}<CR>', options)
  map('n', '<leader>ff', ':Telescope find_files find_command=rg,--hidden,--files,--smart-case,--glob=!.git<CR>', options)
  map('n', '<leader>fl', '<CMD>lua require("telescope.builtin").live_grep()<CR>', options)
  map('n', '<leader>fb', '<CMD>lua require("telescope.builtin").buffers()<CR>', options)
  map('n', '<leader>fh', '<CMD>lua require("telescope.builtin").help_tags()<CR>', options)
  map('n', '<leader>fd', '<CMD>lua require("telescope.builtin").diagnostics()<CR>', options)
  map('n', '<leader>fr', '<CMD>lua require("telescope.builtin").registers()<CR>', options)
  map('n', '<leader>of', '<CMD>lua require("telescope.builtin").oldfiles()<CR>', options)
  map('n', '<leader>ft', '<CMD>lua require("telescope.builtin").treesitter()<CR>', options)
  map('n', '<leader>fc', '<CMD>lua require("telescope.builtin").commands()<CR>', options)
  map('n', '<leader>fr', '<CMD>lua require("telescope.builtin").resume()<CR>', options)
  map('n', '<leader>fq', '<CMD>lua require("telescope.builtin").quickfix()<CR>', options)
  map('n', '<leader>/', '<CMD>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>', options)

  -- Language Servers
  map('n', '<leader>lsd', '<CMD>lua require("telescope.builtin").lsp_definitions{}<CR>', options)
  map('n', '<leader>lsi', '<CMD>lua require("telescope.builtin").lsp_implementations{}<CR>', options)
  map('n', '<leader>lsl', '<CMD>lua require("telescope.builtin").lsp_code_actions{}<CR>', options)
  map('n', '<leader>lst', '<CMD>lua require("telescope.builtin").lsp_type_definitions{}<CR>', options)

  -- Extensions
  -- map('n', '<leader>fs', '<CMD>lua require("telescope").extensions["session-lens"].search_session()<CR>', options)
end

return {
  init = init,
}
