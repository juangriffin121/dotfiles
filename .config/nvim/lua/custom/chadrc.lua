---@type ChadrcConfig 
 local M = {}
 M.ui = {
  theme = 'catppuccin',
  transparency = true,
  hl_override = require "custom.highlights".override,
  -- hl_override = {
  --     StatusLine = { bg = "none" },
  --     StatusLineNC = { bg = "none" },
  --     TabLine = { bg = "none" },
  --     TabLineSel = { bg = "none" },
  --     TabLineFill = { bg = "none" },
  --   },
  }
 M.plugins = "custom.plugins"
 M.mappings = require "custom.mappings"
 return M
