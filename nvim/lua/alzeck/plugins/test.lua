return {
  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",

      "nvim-neotest/neotest-jest",

      "olimorris/neotest-rspec",
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup({
        adapters = {

          require("rustaceanvim.neotest"),
          require("neotest-rspec"),
          require("neotest-jest")({
            jestCommand = "yarn test --",
            jestArguments = function(defaultArguments, context) return defaultArguments end,
            env = { CI = true },

            jestConfigFile = function(file)
              vim.notify(file)
              if file:find("/lib/") then
                local match = file:match("(.*/[^/]+/)plugin/")

                if match then return match .. "jest.config.ts" end
              end

              return vim.fn.getcwd() .. "/jest.config.ts"
            end,
            cwd = function(file)
              vim.notify(file)
              if file:find("/lib/") then
                local match = file:match("(.*/[^/]+/)plugin/")

                if match then return match end
              end

              return vim.fn.getcwd()
            end,

            isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
          }),
        },
      })
    end,
    keys = {
      { mode = "n", "<leader>tc", function() require("neotest").run.run() end, desc = "Run all files" },
      {
        mode = "n",
        "<leader>tf",
        function() require("neotest").run.run(vim.fn.expand("%")) end,
        desc = "Run current file",
      },
      {
        mode = "n",
        "<leader>ta",
        function() require("neotest").run.run(vim.fn.expand(".")) end,
        desc = "Run current test",
      },
      { mode = "n", "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle summary" },
    },
  },
}
