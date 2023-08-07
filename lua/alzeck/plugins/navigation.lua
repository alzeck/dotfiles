return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    -- or                            , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
      vim.keymap.set('n', '<C-p>', builtin.git_files, {})
      vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
      vim.keymap.set("n", "<leader>gr", builtin.lsp_references, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    end
  },
  {
    "theprimeagen/harpoon",
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>a", mark.add_file)
      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

      vim.keymap.set("n", "<C-a>", function() ui.nav_file(1) end)
      vim.keymap.set("n", "<C-s>", function() ui.nav_file(2) end)
      vim.keymap.set("n", "<C-d>", function() ui.nav_file(3) end)
      vim.keymap.set("n", "<C-f>", function() ui.nav_file(4) end)
    end
  }
}
