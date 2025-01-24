local config = function()
  -- Set up lualine with custom configuration
  require("lualine").setup {
    options = {
      globalstatus = true, -- Enable global status line
      section_separators = { left = "", right = "" }, -- No separators on the sides
      component_separators = "", -- No separator for components
      theme = "auto", -- Automatically adapt to the colorscheme
    },
    sections = {
      lualine_a = { "mode" }, -- Display current mode
      lualine_b = {
        "filename", -- Show current file name
        "branch", -- Show Git branch
      },
      lualine_c = {
        "%=", -- Center section placeholder
        { function() return os.date "%H:%M:%S - %d %b %Y" end }, -- Show current time and date
        {
          "diff", -- Git diff
          symbols = { added = " ", modified = "󰝤 ", removed = " " },
        },
      },
      lualine_x = {
        {
          "diagnostics", -- Diagnostics info
          sources = { "nvim_diagnostic" },
          sections = { "error", "warn", "info", "hint" },
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
        },
        {
          function()
            local msg = "No Active LSP"
            local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
            local clients = vim.lsp.get_active_clients()
            for _, client in pairs(clients) do
              if vim.fn.index(client.config.filetypes or {}, buf_ft) ~= -1 then return client.name end
            end
            return msg
          end,
          icon = " LSP:",
        },
      },
      lualine_y = {
        "encoding", -- File encoding (e.g., UTF-8)
        "fileformat", -- File format (e.g., UNIX, DOS)
        "progress", -- Progress through the file
      },
      lualine_z = { "location" }, -- Current line/column
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
