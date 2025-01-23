local config = function()
  -- Set up lualine with custom configuration
  require("lualine").setup {
    options = {
      globalstatus = true, -- Enable global status line
      section_separators = { left = "", right = "" }, -- No separators on the sides
      component_separators = "", -- No separator for components
    },
    sections = {
      lualine_a = { "mode" }, -- Display current mode
      lualine_b = { "filename", "branch" }, -- Display file name and Git branch
      lualine_c = {
        "%=", -- Center section placeholder
        { function() return os.date "%H:%M:%S" end, separator = { left = "", right = "" } }, -- Display current time at center
      },
      lualine_x = { "diagnostics" }, -- Display diagnostics info
      lualine_y = { "filetype", "progress" }, -- Display filetype and progress
      lualine_z = { "location" }, -- Display current location (line/column)
    },
    inactive_sections = {
      lualine_a = { "filename" }, -- Show filename in inactive mode
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { "location" }, -- Show location in inactive mode
    },
  }
end

return {
  "nvim-lualine/lualine.nvim", -- Plugin specification
  lazy = false, -- Don't lazy load the plugin
  config = config, -- Use the above configuration function
}
