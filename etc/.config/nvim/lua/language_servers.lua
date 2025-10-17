vim.lsp.config("gopls", {
  settings = {
    gopls = {
      analyses    = { shadow = true, unusedvariable = true },
      gofumpt     = true,
      staticcheck = true,
      vulncheck   = "Imports",
    },
  },
})

vim.lsp.enable({
  "clangd",
  "cssls",
  "golangci_lint_ls",
  "gopls",
  "html",
  "pyright",
  "ruff",
  "rust_analyzer",
  "sourcekit",
})
