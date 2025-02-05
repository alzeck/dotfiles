return {
  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
      {
        "mrcjkb/rustaceanvim",
        version = "^4", -- Recommended
        lazy = false, -- This plugin is already lazy
      },
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup({
        adapters = {
          require("neotest-vitest"),
          require("rustaceanvim.neotest"),
        },
      })
      vim.keymap.set("n", "<leader>tc", neotest.run.run)
      vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end)
      vim.keymap.set("n", "<leader>ta", function() neotest.run.run(vim.fn.expand(".")) end)

      vim.keymap.set("n", "<leader>ts", neotest.summary.toggle)
    end,
  },
}
