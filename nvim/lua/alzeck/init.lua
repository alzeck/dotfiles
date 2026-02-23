require("alzeck.remap")
require("alzeck.lazy")
require("alzeck.set")
require("alzeck.lsp")

local uv = vim.uv or vim.loop
local theme_state_file = vim.fn.expand("~/.cache/alzeck/theme/mode")
local theme_modes = {
  dark = {
    background = "dark",
    colorscheme = "catppuccin-mocha",
  },
  light = {
    background = "light",
    colorscheme = "catppuccin-latte",
  },
}

local current_theme_mode = nil
local current_theme_mtime = nil

local function set_transparent_highlights()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "none" })
  vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", {
    bg = "none",
  })
end

function ColorMyPencils(color)
  vim.cmd.colorscheme(color)
  set_transparent_highlights()
end

local function read_theme_mode()
  local ok, lines = pcall(vim.fn.readfile, theme_state_file)
  if not ok or #lines == 0 then return "dark" end

  local mode = vim.trim(lines[1] or "")
  if theme_modes[mode] then return mode end

  return "dark"
end

local function get_theme_mtime()
  local stat = uv.fs_stat(theme_state_file)
  if not stat or not stat.mtime then return nil end

  return stat.mtime.sec
end

local function apply_theme_mode(mode)
  local spec = theme_modes[mode] or theme_modes.dark

  vim.o.background = spec.background
  ColorMyPencils(spec.colorscheme)

  current_theme_mode = mode
end

local function refresh_theme_from_state(force)
  local mtime = get_theme_mtime()
  if not force and mtime ~= nil and mtime == current_theme_mtime then return end

  local mode = read_theme_mode()
  if force or mode ~= current_theme_mode then apply_theme_mode(mode) end

  current_theme_mtime = mtime
end

vim.api.nvim_create_user_command("ThemeRefresh", function() refresh_theme_from_state(true) end, {})

vim.api.nvim_create_autocmd({ "FocusGained", "CursorHold" }, {
  group = vim.api.nvim_create_augroup("AlzeckThemeSync", { clear = true }),
  callback = function() refresh_theme_from_state(false) end,
})

refresh_theme_from_state(true)

vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
  },
})
