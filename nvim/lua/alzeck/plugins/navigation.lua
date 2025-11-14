-- Disable default mappings to make it work in terminal mode
vim.g.tmux_navigator_no_mappings = 1
return {
  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("harpoon"):setup({}) end,
    keys = function()
      local append = function() require("harpoon"):list():add() end
      local toggle_quick_menu = function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(
          harpoon:list(),
          { border = "rounded", title_pos = "center", title = " Harpoon 󱡀 ", ui_max_width = 80 }
        )
      end
      local pick_window = function(page)
        return function() require("harpoon"):list():select(page) end
      end
      local prev = function() require("harpoon"):list():prev() end
      local next = function() require("harpoon"):list():next() end

      return {
        { "<leader>a", append, desc = "Harpoon append" },
        { "<C-e>", toggle_quick_menu, desc = "Harpoon menu" },
        { "<C-a>", pick_window(1), desc = "Harpoon window 1" },
        { "<C-s>", pick_window(2), desc = "Harpoon window 2" },
        { "<C-d>", pick_window(3), desc = "Harpoon window 3" },
        { "<C-f>", pick_window(4), desc = "Harpoon window 4" },
        -- { "<C-H>p", prev, desc = "Harpoon previous" },
        -- { "<C-H>n", next, desc = "Harpoon next" },
      }
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys =  {
        { mode = "n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>" },
        { mode = "n", "<c-j>", "<cmd>TmuxNavigateDown<cr>" },
        { mode = "n", "<c-k>", "<cmd>TmuxNavigateUp<cr>" },
        { mode = "n", "<c-l>", "<cmd>TmuxNavigateRight<cr>" },
        { mode = "n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
        { mode = "t", "<c-h>", "<C-w><cmd>TmuxNavigateLeft<cr>" },
        { mode = "t", "<c-j>", "<C-w><cmd>TmuxNavigateDown<cr>" },
        { mode = "t", "<c-k>", "<C-w><cmd>TmuxNavigateUp<cr>" },
        { mode = "t", "<c-l>", "<C-w><cmd>TmuxNavigateRight<cr>" },
        { mode = "t", "<c-\\>", "<C-w><cmd>TmuxNavigatePrevious<cr>" },
    }
  },
}
