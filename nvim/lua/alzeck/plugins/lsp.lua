return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "lazy.nvim",
        "snacks.nvim",
        "todo-comments.nvim",
        "nvim-treesitter",
        "nvim-treesitter-context",
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  {
    "mason-org/mason.nvim",
    lazy = false,
    build = ":MasonUpdate",
    ---@module 'mason'
    ---@type MasonSettings
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason-lspconfig.nvim" },
    },
    config = function()
      local lspconfig_defaults = require("lspconfig").util.default_config
      local lsp_capabilities = vim.tbl_deep_extend("force", require("blink.cmp").get_lsp_capabilities({}, false), {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      })

      lspconfig_defaults.capabilities = vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, lsp_capabilities)

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
          vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
        end,
      })

      vim.diagnostic.config({
        virtual_text = true,
        underline = true,
        update_in_insert = false,
        severity_sort = false,
        virtual_lines = { current_line = true },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»",
          },
        },
      })

      local noop = function() end

      vim.g.rustaceanvim = {
        server = {
          capabilities = require("blink.cmp").get_lsp_capabilities(),
          cmd = function()
            local mason_registry = require("mason-registry")
            local ra_binary = mason_registry.is_installed("rust-analyzer") and vim.fn.exepath("rust-analyzer")
              or "rust-analyzer"
            return { ra_binary } -- You can add args to the list, such as '--log-file'
          end,
        },
      }

      require("mason-lspconfig").setup({
        automatic_enable = true,
        automatic_installation = false,
        ensure_installed = {
          "ts_ls",
          "rust_analyzer",
          "tailwindcss",
          "jsonls",
          "basedpyright",
          "astro",
        },
        handlers = {
          function(server_name) require("lspconfig")[server_name].setup({}) end,
          rust_analyzer = noop,
          tailwindcss = function()
            require("lspconfig").tailwindcss.setup({
              settings = {
                tailwindCSS = {
                  classAttributes = { "class", "className", "classNames", "class:list" },
                  experimental = {
                    classRegex = {
                      { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                      { "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                    },
                  },
                },
              },
            })
          end,
          ts_ls = function()
            local inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            }

            require("lspconfig").ts_ls.setup({
              settings = {
                typescript = {
                  inlayHints = inlayHints,
                },
                javascript = {
                  inlayHints = inlayHints,
                },
              },
            })
          end,
          gopls = function()
            require("lspconfig").gopls.setup({
              settings = {
                gopls = {
                  hints = {
                    rangeVariableTypes = true,
                    parameterNames = true,
                    constantValues = true,
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    functionTypeParameters = true,
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
}
