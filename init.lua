-- This file bootstraps Lazy.nvim and configures Mason and gopls for Go development.

local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Validate that Lazy.nvim is available
if not pcall(require, "lazy") then
  -- stylua: ignore proposal
  vim.api.nvim_echo(
    { { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } },
    true,
    {}
  )
  vim.fn.getchar()
  vim.cmd.quit()
end

-- Set conceallevel for obsidian.nvim UI features
vim.opt.conceallevel = 2 -- Added this line

require "lazy_setup"
require "polish"

-- Import Mason, Mason-LSPconfig, and Mason-Null-LS
local mason_lspconfig = require "mason-lspconfig"
local mason_null_ls = require "mason-null-ls"
local lspconfig = require "lspconfig"

-- Initialize Mason
require("mason").setup()

-- Setup Mason-LSPconfig for LSP installation
mason_lspconfig.setup {
  ensure_installed = { "gopls" }, -- Ensure gopls is installed
  automatic_installation = true, -- Automatically install LSPs
}

-- Setup Mason-Null-LS for formatters/linters installation
mason_null_ls.setup {
  ensure_installed = {
    "stylua", -- Lua formatter
    "goimports", -- Go imports formatter
    "golines",
    "gofumpt", -- Go stricter formatter
    "goimports-reviser", -- Go imports reviser tool
  },
}

-- Configure gopls (Go LSP)
lspconfig.gopls.setup {
  on_attach = function(client, bufnr)
    -- Enable formatting on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function() vim.lsp.buf.format() end,
    })
  end,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true, -- Enable analysis for unused params
      },
      staticcheck = true, -- Enable static code analysis
    },
  },
}
