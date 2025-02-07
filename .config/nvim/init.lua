require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end


dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)

require "plugins"


vim.cmd [[
  " Make Normal and NonText transparent
  highlight Normal guibg=none ctermbg=none
  highlight NonText guibg=none ctermbg=none

  " Make StatusLine and its related groups transparent
  highlight StatusLine guibg=none ctermbg=none
  highlight StatusLineNC guibg=none ctermbg=none

  " Make TabLine and its variants transparent
  highlight TabLine guibg=none ctermbg=none
  highlight TabLineSel guibg=none ctermbg=none
  highlight TabLineFill guibg=none ctermbg=none
]]
