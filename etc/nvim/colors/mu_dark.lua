-- Name:    mu dark
-- Author:  Tshaka Lekholoane <mail+git@tshaka.dev>
-- Website: https://github.com/tshakalekholoane/rc.d
-- License: ISC

local groups = {
  -- See group-name.
  Comment              = { fg = "#6b695c" },
  Constant             = {},
  String               = { fg = "#b3d7c3" },
  Character            = { fg = "#b3d7c3" },
  Number               = { fg = "#b3d7c3" },
  Boolean              = { fg = "#b3d7c3" },
  Float                = { fg = "#b3d7c3" },
  Identifier           = { fg = "#f8f5d7" },
  Function             = { bold = true, fg = "#f8f5d7" },
  Statement            = {},
  Conditional          = { fg = "#c1d6de" },
  Repeat               = { fg = "#c1d6de" },
  Label                = { fg = "#c1d6de" },
  Operator             = { fg = "#ffe7a4" },
  Keyword              = { fg = "#c1d6de" },
  Exception            = { fg = "#c1d6de" },
  PreProc              = { fg = "#d79987" },
  Include              = { fg = "#d79987" },
  Define               = { fg = "#d79987" },
  Macro                = { fg = "#d79987" },
  PreCondit            = { fg = "#d79987" },
  Type                 = { fg = "#d79987" },
  StorageClass         = { fg = "#d79987" },
  Structure            = { fg = "#d79987" },
  Typedef              = { fg = "#d79987" },
  Special              = { fg = "#d79987" },
  SpecialChar          = { fg = "#d79987" },
  Tag                  = { bold = true, fg = "#f8f5d7" },
  Delimiter            = { fg = "#6b695c" },

  -- TODO: SpecialComment.
  -- TODO: Debug.

  Underlined           = { fg = "#c1d6de", bold = true },
  Ignore               = { fg = "#403d36" },

  -- TODO: Error.

  Todo                 = { bold = true, fg = "#6b695c" },
  Added                = { bg = "#353933" },
  Removed              = { bg = "#3b302a" },
  Changed              = { bg = "#413b2f" },

  -- See highlight-groups.
  ColorColumn          = { bg = "#221f1c" },
  Cursor               = { bg = "#d79987" },
  CursorLine           = { bg = "#221f1c" },
  Directory            = { bold = true, fg = "#d79987" },
  OkMsg                = { bg = "#b3d7c3", bold = true, fg = "#1f1d1a" },
  WarningMsg           = { bg = "#ffe7a4", bold = true, fg = "#1f1d1a" },
  ErrorMsg             = { bg = "#d79987", bold = true, fg = "#1f1d1a" },
  MatchParen           = { bg = "#3f3c35" },
  MsgArea              = { bg = "#2a2823", fg = "#b0ad98" },
  MoreMsg              = { bold = true, fg = "#b0ad98" },
  EndOfBuffer          = { link = "LineNr" },
  IncSearch            = { bg = "#fff69a", fg = "#1f1d1a", bold = true },
  Substitute           = { bg = "#fff69a", fg = "#1f1d1a", bold = true },
  LineNr               = { fg = "#6b695c" },
  Normal               = { bg = "#1f1d1a", fg = "#f8f5d7" },
  NormalFloat          = { bg = "#2a2823", fg = "#f8f5d7" },
  Pmenu                = { bg = "#2a2823", fg = "#f8f5d7" },
  PmenuSel             = { bg = "#35332d", fg = "#f8f5d7" },
  PmenuThumb           = { bg = "#3c3832" },
  PmenuMatch           = { bold = true, fg = "#d79987" },
  Question             = { bold = true, fg = "#b0ad98" },
  Search               = { bg = "#fff69a", fg = "#1f1d1a", bold = true },
  CursorLineNr         = { bg = "#221f1c", bold = true },
  WinSeparator         = { fg = "#2a2823" },
  StatusLine           = { bg = "#2a2823", fg = "#b0ad98" },
  Visual               = { bg = "#5b453d" },
  Whitespace           = { fg = "#2a2823" },

  -- See gitsigns-highlight-groups.
  GitSignsAdd          = { fg = "#b3d7c3" },
  GitSignsDelete       = { fg = "#d79987" },
  GitSignsChange       = { fg = "#ffe7a4" },

  TelescopeBorder      = { fg = "#2a2823" },
  TelescopeTitle       = { fg = "#b0ad98" },
  TelescopeSelection   = { bg = "#35332d", fg = "#f8f5d7" },

  -- See treesitter-highlight-groups.

  ["@attribute"]       = { link = "Keyword" },
  ["@comment.error"]   = { link = "@comment.todo" },
  ["@comment.note"]    = { link = "@comment.todo" },
  ["@comment.warning"] = { link = "@comment.todo" },
  ["@variable"]        = { link = "Identifier" },
}

vim.cmd.highlight("clear")
vim.cmd.syntax("reset")
vim.g.colors_name = "mu_dark"
vim.opt.background = "dark"

-- TODO: Terminal colours.

for k, v in pairs(groups) do
  vim.api.nvim_set_hl(0, k, v)
end
