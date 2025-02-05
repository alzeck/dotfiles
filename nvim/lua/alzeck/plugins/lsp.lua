return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "lazy.nvim",
        "snacks.nvim",
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  {
    "williamboman/mason.nvim",
    lazy = false,
    build = ":MasonUpdate",
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
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] =
          vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

      local lspconfig_defaults = require("lspconfig").util.default_config
      lspconfig_defaults.capabilities =
          vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
          vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
          vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
          vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
          vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
          vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
          vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
        end,
      })

      vim.diagnostic.config({
        virtual_text = true,
        underline = true,
        update_in_insert = false,
        severity_sort = false,
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

      require("mason-lspconfig").setup({
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
          elixirls = noop,
          rust_analyzer = noop,
          tailwindcss = function()
            require("lspconfig").tailwindcss.setup({
              settings = {
                tailwindCSS = {
                  classAttributes = { "class", "className", "classNames", "class:list" },
                  experimental = {
                    classRegex = {
                      { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                      { "cn\\(([^)]*)\\)",  "[\"'`]([^\"'`]*).*?[\"'`]" },
                    },
                  },
                },
              },
            })
          end,
          ts_ls = function()
            local function organize_imports()
              local params = {
                command = "_typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(0) },
              }
              vim.lsp.buf.execute_command(params)
            end
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
              commands = {
                OrganizeImports = {
                  organize_imports,
                  description = "Organize Imports",
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
    version = "^4", -- Recommended
    lazy = false,   -- This plugin is already lazy
    config = function()
      vim.g.rustaceanvim = {
        server = {
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
          cmd = function()
            local mason_registry = require("mason-registry")
            local ra_binary = mason_registry.is_installed("rust-analyzer")
                -- This may need to be tweaked, depending on the operating system.
                and mason_registry.get_package("rust-analyzer"):get_install_path() ..
                "/rust-analyzer-aarch64-apple-darwin"
                or "rust-analyzer"
            return { ra_binary } -- You can add args to the list, such as '--log-file'
          end,
        },
      }
    end,
  },
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup({
        nextls = { enable = true },
        elixirls = {
          enable = true,
          settings = elixirls.settings({
            dialyzerEnabled = false,
            enableTestLenses = false,
          }),
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        },
        projectionist = {
          enable = true,
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      -- Create the configuration for metals
      ---
      local metals_config = require("metals").bare_config()
      metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      ---
      -- Autocmd that will actually be in charging of starting metals
      ---
      local metals_augroup = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = metals_augroup,
        pattern = { "scala", "sbt", "java" },
        callback = function() require("metals").initialize_or_attach(metals_config) end,
      })
    end,
  },
}
