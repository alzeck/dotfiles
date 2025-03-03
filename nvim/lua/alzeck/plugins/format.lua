local supported = {
  "css",
  "graphql",
  "handlebars",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "less",
  "markdown",
  "markdown.mdx",
  "scss",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}
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
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft
        or {
          lua = { "stylua", lsp_format = "never" },
          python = { "autopep8" },
        }
      for _, ft in ipairs(supported) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "prettier")
      end

      opts.format_on_save = opts.format_on_save or { timeout_ms = 5000 }
      opts.default_format_opts = opts.default_format_opts or {
        lsp_format = "fallback",
      }
      return opts
    end,
  },
}
