set --local arch (uname -m)
set --local kernel (uname)

if not test $kernel = Darwin
    printf "fish/config: sourcing Darwin script on %s\n" $kernel >&2
    exit 1
end

abbr --add --global homebrew_sync "brew bundle install --cleanup --no-lock"
abbr --add --global make          "gmake"

set --export HOMEBREW_BUNDLE_FILE ~/conf.d/etc/.Brewfile

if test $arch = arm64
    # See the following for details:
    # - https://go.dev/wiki/MinimumRequirements#arm64
    # - https://developer.apple.com/documentation/apple-silicon/cpu-optimization-guide
    set --export GOARM64 v8.5,crypto,lse

    set --export EDITOR /opt/homebrew/bin/nvim
end

if test $arch = arm64
    fish_add_path --global /opt/homebrew/bin /opt/homebrew/sbin
end
