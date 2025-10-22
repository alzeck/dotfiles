---@param parser string
local function check_installed(parser)
  local treesitter = require("nvim-treesitter")
  local parsers = treesitter.get_installed()
  return vim.tbl_contains(parsers, parser)
end

---@param parser string
---@param callback? fun()
local function install(parser, callback)
  local treesitter = require("nvim-treesitter")
  if not check_installed(parser) then
    treesitter.install({ parser }):await(function(err)
      if not err and callback then callback() end
    end)
  end
end

--- Register a filetype with a parser
---@param parser string
local function register_parser(parser)
  local filetypes = vim.treesitter.language.get_filetypes(parser)
  if not vim.tbl_contains(filetypes, parser) then table.insert(filetypes, parser) end
  -- register and start parsers for filetypes
  vim.treesitter.language.register(parser, filetypes)
end

--- Register parsers from opts.ensure_installed
--- @param ensure_installed table<number, string>
local function register(ensure_installed)
  local installed = require("nvim-treesitter").get_installed()
  local not_installed = vim.tbl_filter(
    function(parser) return not vim.tbl_contains(installed, parser) end,
    ensure_installed
  )
  if #not_installed > 0 then
    for _, parser in ipairs(not_installed) do
      install(parser, function() register_parser(parser) end)
    end
  end

  for _, parser in ipairs(ensure_installed) do
    register_parser(parser)
  end
end

--- Install and start parsers for nvim-treesitter.
local function install_and_start()
  -- Auto-install and start treesitter parser for any buffer with a registered filetype
  vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function(event)
      local bufnr = event.buf
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
      -- Skip if no filetype
      if filetype == "" then return end

      -- Get parser name based on filetype
      local parser_name = vim.treesitter.language.get_lang(filetype) -- might return filetype (not helpful)
      if not parser_name then return end
      -- Try to get existing parser (helpful check if filetype was returned above)
      local parser_configs = require("nvim-treesitter.parsers")
      if not parser_configs[parser_name] then
        return -- Parser not available, skip silently
      end

      if not check_installed(parser_name) then
        install(parser_name, function()
          register_parser(parser_name)
          vim.treesitter.start(bufnr)
          vim.bo[bufnr].syntax = "on"
        end)
      else
        -- Start treesitter for this buffer
        vim.treesitter.start(bufnr)
        vim.bo[bufnr].syntax = "on"
      end
    end,
  })
end

return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    ---@type TSContext.Config
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 10, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 20, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = "─",
      zindex = 20, -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      multiwindow = false,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    -- cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    -- event = { "VeryLazy" },
    -- clazy = vim.fn.argc(-1) == 0,
    build = ":TSUpdate",
    dependencies = {},
    config = function()
      local tree_sitter = require("nvim-treesitter")
      tree_sitter.setup()
      register({
        "vimdoc",
        "javascript",
        "typescript",
        "c",
        "python",
        "go",
        "lua",
        "rust",
        "css",
        "ruby",
        -- "elixir",
        -- "eex",
      })

      install_and_start()
    end,
  },
}
