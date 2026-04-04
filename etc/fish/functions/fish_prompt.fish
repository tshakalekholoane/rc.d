set --global __fish_git_prompt_char_dirtystate "+"
set --global __fish_git_prompt_char_stagedstate ""
set --global __fish_git_prompt_char_stateseparator ""
set --global __fish_git_prompt_color_branch normal
set --global __fish_git_prompt_color_dirtystate brred
set --global __fish_git_prompt_show_informative_status 0
set --global __fish_git_prompt_showcolorhints 0
set --global __fish_git_prompt_showdirtystate 1
set --global __fish_git_prompt_showstashstate 0
set --global __fish_git_prompt_showuntrackedfiles 0
set --global __fish_git_prompt_showupstream none

function fish_prompt -d "Writes prompt."
    echo -n "% "
end

function fish_right_prompt -d "Writes right prompt."
    fish_git_prompt "%s"
end
