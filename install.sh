#!/bin/bash

set -euo pipefail

THINGS_TO_STOW=(
	wezterm
	nvim
	git
	rio
)

for thing in ${THINGS_TO_STOW[@]}; do
	stow -vDt ~ $thing
	stow -vt ~ $thing
done

echo Done.
