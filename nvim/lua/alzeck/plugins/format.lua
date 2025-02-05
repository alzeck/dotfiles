return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>f",
        function() require("conform").format({ async = true }) end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua", lsp_format = "never" },
        -- elixir = { "mix" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        python = { "autopep8" },
      },
      format_on_save = {
        timeout_ms = 5000,
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
    },
  },
}
