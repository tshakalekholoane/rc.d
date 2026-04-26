-- Bootstrap package manager.
local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(path) then
  local output = vim.fn.system({
    "git",
    "clone",
    "--branch=stable",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    path,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo(
      {
        { "Could not clone folke/lazy.nvim\n", "ErrorMsg" },
        { output,                              "WarningMsg" },
        { "\nPress any key to continuel" },
      },
      true,
      {}
    )
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(path)

local lazy = require "lazy"

lazy.setup({
  spec = {
    { import = "plugin" },
  },
  install = {
    colorscheme = { "mu" },
  },
})
