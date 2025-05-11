return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    require("tokyonight").setup {
      style = "night", -- Use the "night" style as a base
      transparent = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
    }
    -- Apply the theme
    vim.cmd "colorscheme tokyonight"

    -- Override colors with vibrant, non-grey tones
    vim.api.nvim_set_hl(0, "Normal", { fg = "#80D4FF" }) -- Bright sky blue foreground, new background color
    vim.api.nvim_set_hl(0, "Comment", { fg = "#6272A4", italic = true }) -- New color for comments
    vim.api.nvim_set_hl(0, "Keyword", { fg = "#FF79C6", italic = true }) -- Vibrant pink for keywords
    vim.api.nvim_set_hl(0, "String", { fg = "#FF5555" }) -- Bright red for strings (made more vibrant)
    vim.api.nvim_set_hl(0, "Function", { fg = "#F1FA8C" }) -- Bright yellow for functions
    vim.api.nvim_set_hl(0, "Type", { fg = "#50FA7B" }) -- Vibrant green for types
    vim.api.nvim_set_hl(0, "Constant", { fg = "#BD93F9" }) -- Vibrant purple for constants
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#8BE9FD", bg = "#282A36" }) -- Bright cyan for line numbers
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#44475A" }) -- Slightly lighter teal for cursor line
  end,
}
