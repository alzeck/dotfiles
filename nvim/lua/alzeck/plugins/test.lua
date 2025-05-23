return {
  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup({
        adapters = {
          require("neotest-vitest"),
          require("rustaceanvim.neotest"),
        },
      })
    end,
    keymap = {
      { "n", "<leader>tc", function() require("neotest").run.run() end, desc = "Run all files" },
      { "n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run current file" },
      { "n", "<leader>ta", function() require("neotest").run.run(vim.fn.expand(".")) end, desc = "Run current test" },
      { "n", "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle summary" },
    },
  },
}
