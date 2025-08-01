-- Bootstrap.
local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(path) then
  vim.fn.system({
    "git",
    "clone",
    "--branch=stable",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    path,
  })
end
vim.opt.rtp:prepend(path)

local plugins = {
  { "bezhermoso/tree-sitter-ghostty", build = "make nvim_install", ft = "ghostty" },
  { "lewis6991/gitsigns.nvim",        opts = {} },
  { "mrcjkb/rustaceanvim",            version = "^6",              ft = { "rust" } },
  "neovim/nvim-lspconfig",
  {
    "nvim-telescope/telescope.nvim",
    branch       = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond  = function()
          return vim.fn.executable "make" == 1
        end,
      },
    },
    event        = "VimEnter",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build        = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  },
  "nvim-treesitter/nvim-treesitter-context",
  "tpope/vim-commentary",
  "tpope/vim-sleuth",
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
}

local lazy = require "lazy"
lazy.setup(plugins, {})
