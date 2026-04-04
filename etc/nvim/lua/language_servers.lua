vim.lsp.config("gopls", {
  -- Override default settings.
  settings = {
    gopls = {
      analyses    = { shadow = true, unusedvariable = true },
      gofumpt     = true,
      staticcheck = true,
      vulncheck   = "Imports",
    },
  },
})

vim.lsp.config("sourcekit", {
  -- Disable SourceKit for C and C++.
  filetypes = { "swift", "objc", "objcpp" },
})

vim.lsp.enable({
  "asm_lsp",
  "clangd",
  "cssls",
  "denols",
  "golangci_lint_ls",
  "gopls",
  "html",
  "lua_ls",
  "pyright",
  "ruff",
  "ruff_lsp",
  "rust_analyzer",
  "sourcekit",
  "tombi",
  "ty",
})
