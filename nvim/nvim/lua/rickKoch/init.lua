local function init()
  require 'rickKoch.vim'.init()
  require 'rickKoch.packer'.init()
end

return {
  init = init,
}
