abbr --add --global f format
abbr --add --global less "less -FIRX"
abbr --add --global ll "ls -lhAF"
abbr --add --global ls "ls -F"
abbr --add --global m mkdir_and_cd
abbr --add --global p python3
abbr --add --global t tiny
abbr --add --global v nvim
abbr --add --global vf "nvim (fzf --scheme path)"

set --export CLICOLOR 1
set --export FZF_DEFAULT_COMMAND "fd --type file --follow --hidden --exclude .git"
set --export GNUPGHOME ~/.config/gnupg
set --export GPG_TTY (tty)
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

fish_hybrid_key_bindings

gpgconf --launch gpg-agent
umask 0002
