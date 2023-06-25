function ColorMyPencils(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)
  
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()

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
