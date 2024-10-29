#!/usr/bin/env bash

if ! [[ -x "$(command -v rustup)" ]]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	# shellcheck disable=SC1091
	source "$HOME"/.cargo/env
fi

