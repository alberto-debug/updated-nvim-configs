local config = function()
  require("lualine").setup {
    options = {
      globalstatus = true, -- Enable global status line
      section_separators = { left = "", right = "" }, -- Stylish separators
      component_separators = { left = "", right = "" }, -- Stylish component separators
      theme = "auto", -- Automatically adapt to the colorscheme
    },
    sections = {
      lualine_a = {
        { "mode", separator = { left = "", right = "" }, right_padding = 2 }, -- Mode with separators
      },
      lualine_b = {
        { "filename", symbols = { modified = " ", readonly = " ", unnamed = "" } }, -- Show file status
        { "branch", icon = "" }, -- Show Git branch
      },
      lualine_c = {
        "%=", -- Center section placeholder
        {
          function()
            return os.date "%H:%M:%S" -- Display only the time
          end,
          color = { fg = "#01BAEF", gui = "bold" }, -- Time in blue color
        },
        {
          "diff", -- Git diff with symbols
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
        {
          function()
            local current_line = vim.fn.line "."
            local total_lines = vim.fn.line "$"
            local chars = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
            local line_ratio = current_line / total_lines
            local index = math.ceil(line_ratio * #chars)
            return chars[index]
          end,
          color = { fg = "#A9FF68", gui = "bold" }, -- Animated status bar
        },
        "encoding", -- File encoding
        "fileformat", -- File format
      },
      lualine_z = {
        { "location", separator = { left = "", right = "" } }, -- Location with separators
      },
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
