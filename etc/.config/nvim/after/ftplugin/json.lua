local function format()
  vim.cmd("!jq --indent 2 '.' % > %~ && mv %~ %")
end

vim.keymap.set("n", "<space>f", format, { desc = "Format JSON" })
