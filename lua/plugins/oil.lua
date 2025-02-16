return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- Add these lines to specify when to load
  event = "VeryLazy", -- Load after startup
  cmd = "Oil", -- Load when Oil command is used
  config = function()
    require("oil").setup {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _) return name == ".." or name == ".git" end,
      },
      float = {
        padding = 2,
        max_width = 90,
        max_height = 0,
      },
      win_options = {
        wrap = true,
        winblend = 0,
      },
      keymaps = {
        ["<C-c>"] = false,
        ["q"] = "actions.close",
        ["<Esc>"] = "actions.close",
      },
    }

    -- Add the keybinding to open Oil in float mode
    vim.keymap.set("n", "-", function() require("oil").open_float() end, { desc = "Open Oil in float mode" })
  end,
}
