.DEFAULT_GOAL = help
.RECIPEPREFIX = >

MAKEFLAGS += --no-builtin-rules

GFLAGS = -ldflags="-s -w"
GENV   = GOARM64=$(shell go env GOARM64)

TARGET := $(shell uname -s)

CONFIG_DIR     =
CONFIG_DIR_XDG = $(HOME)/.config
CONFIG_DIR_XNU = $(HOME)/Library/Application\ Support

BIN = bin/a/a bin/site_search/site_search bin/snip/snip
ETC =             \
  etc/fish        \
  etc/ghostty     \
  etc/git         \
  etc/login       \
  etc/nvim        \
  etc/site_search \
  etc/snip        \
  etc/sqlite3     \
  etc/yt-dlp      \
  etc/zed
OPT =

ifeq ($(TARGET), Darwin)
  CONFIG_DIR = $(CONFIG_DIR_XNU)

  BIN += bin/apple_remap/apple_remap bin/can/.build/release/can
  ETC += etc/homebrew etc/rectangle
  OPT += opt/dev.tshaka.remap.plist
else ifeq ($(TARGET), Linux)
  CONFIG_DIR = $(CONFIG_DIR_XDG)

  BIN += bin/gnome_remap/gnome_remap
else
 $(error unknown build target "$(TARGET)".)
endif

bin/a/a: bin/a/go.mod bin/a/main.go
> @env $(GENV) go build -C $(@D) $(GFLAGS)

bin/apple_remap/apple_remap: \
  bin/apple_remap/go.mod     \
  bin/apple_remap/main_darwin.go
> @env $(GENV) go build -C $(@D) $(GFLAGS)

bin/can/.build/release/can:                 \
  bin/can/Package.swift                     \
  bin/can/Sources/Optional+Extensions.swift \
  bin/can/Sources/Stderr.swift              \
  bin/can/Sources/main.swift
> @swift build --configuration release --package-path bin/can/

bin/gnome_remap/gnome_remap: \
  bin/gnome_remap/go.mod     \
  bin/gnome_remap/main_linux.go
> @env $(GENV) go build -C $(@D) $(GFLAGS)

bin/site_search/site_search: bin/site_search/go.mod bin/site_search/main.go
> @env $(GENV) go build -C $(@D) $(GFLAGS)

bin/snip/snip: bin/snip/go.mod bin/snip/main.go
> @env $(GENV) go build -C $(@D) $(GFLAGS)

.PHONY: etc/fish
etc/fish:
> @ln -fns $(abspath $@) $(CONFIG_DIR_XDG)/fish

.PHONY: etc/ghostty
etc/ghostty:
> @ln -fns $(abspath $@) $(CONFIG_DIR_XDG)/ghostty

.PHONY: etc/git
etc/git:
> @ln -fns $(abspath $@) $(CONFIG_DIR_XDG)/git

.PHONY: etc/homebrew
etc/homebrew:
> @ln -fns $(abspath $@) $(CONFIG_DIR_XDG)/homebrew

.PHONY: etc/login
etc/login:
> @ln -fns $(abspath $@)/.hushlogin $(HOME)/.hushlogin

.PHONY: etc/nvim
etc/nvim:
> @ln -fns $(abspath $@) $(CONFIG_DIR_XDG)/nvim

.PHONY: etc/rectangle
etc/rectangle:
> @ln -fns $(abspath $@) $(CONFIG_DIR_XNU)/Rectangle

.PHONY: etc/site_search
etc/site_search:
> @ln -fns $(abspath $@) $(CONFIG_DIR)/site_search

.PHONY: etc/snip
etc/snip:
> @ln -fns $(abspath $@) $(CONFIG_DIR)/snip

.PHONY: etc/sqlite3
etc/sqlite3:
> @ln -fns $(abspath $@) $(CONFIG_DIR_XDG)/sqlite3

.PHONY: etc/yt-dlp
etc/yt-dlp:
> @ln -fns $(abspath $@) $(CONFIG_DIR_XDG)/yt-dlp

.PHONY: etc/zed
etc/zed:
> @ln -fns $(abspath $@) $(CONFIG_DIR_XDG)/zed

.PHONY: opt/dev.tshaka.remap.plist
opt/dev.tshaka.remap.plist:
> @ln -fns $(abspath $@) $(HOME)/Library/LaunchAgents/$(notdir $@)

## install: create symbolic links for binaries and configuration files
.PHONY: install
install: $(BIN) $(ETC) $(OPT)
> @mkdir -p $(HOME)/bin/
> @$(foreach bin, $(BIN), \
  ln -fns $(abspath $(bin)) $(HOME)/bin/$(notdir $(bin));)

## help: print this help message (default)
.PHONY: help
help:
> @printf "usage: make <target>\n\ntargets:\n"
> @sed -n 's/^##//p' $(MAKEFILE_LIST) | column -t -s ':' | sed -e 's/^/ /'
