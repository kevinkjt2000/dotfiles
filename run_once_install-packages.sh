#!/bin/sh

/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew_packages=(
	bash-completion
	bitwarden-cli
	coreutils
	diff-so-fancy
	direnv
	docker
	docker-compose
	findutils
	fish
	git
	git-gui
	gnupg
	neovim
	ripgrep
	thefuck
	tmux
)
# TODO: put this list of packages into a .Brewfile template instead and
# include reatttach-to-user-namespace and pinentry-mac for darwin os
# include xclip on linux os
# TODO: fix ripgrep building from source and failing
brew install "${brew_packages[@]}" || true
