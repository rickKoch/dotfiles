local function init()
  local null_ls = require('null-ls')

  local formatting = null_ls.builtins.formatting

  local sources = {
    formatting.prettier,
    formatting.stylua,
  }

  null_ls.setup({
    sources = sources
  })
end

return {
  init = init
}
