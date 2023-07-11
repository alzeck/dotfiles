function ColorMyPencils(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()

local auto_dark_mode = require('auto-dark-mode')

auto_dark_mode.setup({
  update_interval = 1000,
  set_dark_mode = function()
    vim.api.nvim_set_option('background', 'dark')
    ColorMyPencils('rose-pine-moon')
  end,
  set_light_mode = function()
    vim.api.nvim_set_option('background', 'light')
    ColorMyPencils('rose-pine-dawn')
  end,
})
auto_dark_mode.init()


require("colorizer").setup {
  filetypes = { "*" },
  user_default_options = {
    css = true,
    mode = "background",
    tailwind = true,
    virtualtext = "■",
    always_update = true
  },
}
