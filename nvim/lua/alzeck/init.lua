require("alzeck.remap")
require("alzeck.lazy")
require("alzeck.set")

function ColorMyPencils(color)
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "none" })
  vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", {
    bg = "none",
  })
end

ColorMyPencils("catppuccin-latte")

vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
  },
})
