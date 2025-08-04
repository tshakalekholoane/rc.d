set --local kernel (uname)

if not test $kernel = Linux
    printf "fish/config: sourcing Linux script on %s\n" $kernel >&2
    exit 1
end

if test $XDG_CURRENT_DESKTOP = GNOME
    abbr --add --global can "gio trash"
end
