abbr --add --global less "less -FINRX"
abbr --add --global ll "ls -lhAF"
abbr --add --global ls "ls -F"
abbr --add --global m mkdir_and_cd
abbr --add --global p python3
abbr --add --global s snip
abbr --add --global ss site_search
abbr --add --global v nvim
abbr --add --global vf "nvim (fzf --scheme path)"
abbr --add --global vs "nvim -c \"setlocal buftype=nofile bufhidden=hide noswapfile filetype=markdown\""

set --export CLICOLOR 1
set --export FZF_DEFAULT_COMMAND "fd --color never  --exclude .git --follow --hidden --type file"
set --export GOPRIVATE "tshaka.dev/{bucket,notifications}"
set --unexport fish_greeting

set --local fish_config_dir (status dirname)
switch (uname)
    case Darwin
        source "$fish_config_dir/config_darwin.fish"
    case Linux
        source "$fish_config_dir/config_linux.fish"
end
if test $status != 0
    exit 1
end

fish_add_path --global ~/.cargo/bin ~/bin ~/go/bin
fish_config theme choose mu
fish_hybrid_key_bindings
umask 0002
