return {
  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({})
    end,
    keys = function()
      local harpoon = require("harpoon")
      local append = function() harpoon:list():add() end
      local toggle_quick_menu = function()
        harpoon.ui:toggle_quick_menu(
          harpoon:list(),
          { border = "rounded", title_pos = "center", title = " Harpoon 󱡀 ", ui_max_width = 80 }
        )
      end
      local pick_window = function(page)
        return function() harpoon:list():select(page) end
      end
      local prev = function() harpoon:list():prev() end
      local next = function() harpoon:list():next() end

      return {
        { "<leader>a", append, desc = "Harpoon append" },
        { "<C-e>", toggle_quick_menu, desc = "Harpoon menu" },
        { "<C-a>", pick_window(1), desc = "Harpoon window 1" },
        { "<C-s>", pick_window(2), desc = "Harpoon window 2" },
        { "<C-d>", pick_window(3), desc = "Harpoon window 3" },
        { "<C-f>", pick_window(4), desc = "Harpoon window 4" },
        { "<C-H>p", prev, desc = "Harpoon previous" },
        { "<C-H>n", next, desc = "Harpoon next" },
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
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
