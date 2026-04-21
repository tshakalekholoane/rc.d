local git = require "utilities.git"

function _G.status_line_git_branch()
  local name = git.branch()

  if name ~= "" then
    name = "\u{f418} " .. name
  end

  return name 
end

vim.opt.statusline = "%-F %m %-r %= %{%v:lua.status_line_git_branch()%}  %l:%c %p%%  %y"
