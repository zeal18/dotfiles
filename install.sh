#!/bin/bash

set -euo pipefail

THINGS_TO_STOW=(
	wezterm
	nvim
	git
	rio
	tmux
	lazygit
	k9s
)

for thing in ${THINGS_TO_STOW[@]}; do
	stow -vDt ~ $thing
	stow -vt ~ $thing
done

echo Done.
