return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    require("tokyonight").setup {
      style = "night", -- Options: storm, night, day, moon
      transparent = false,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
    }
    vim.cmd "colorscheme tokyonight"
  end,
}
