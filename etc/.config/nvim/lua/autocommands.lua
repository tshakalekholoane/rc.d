vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight on yank",
  group = vim.api.nvim_create_augroup("highlight-on-yank", { clear = true }),
  pattern = "*",
})
