local git = require "utilities.git"

function _G.status_line_git_branch()
  return git.branch()
end

vim.opt.statusline = "%-F %m %-r %= \u{f418} %{%v:lua.status_line_git_branch()%}  %l:%c %p%%  %y"
