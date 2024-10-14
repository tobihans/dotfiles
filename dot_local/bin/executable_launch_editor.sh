#!/usr/bin/env bash

function launch_editor() {
	filename=$1
	line=${2:-"1"}
	column=${3:-"1"}
	command="<C-\\><C-N>:call v:lua.require'utilities'.open_file('$filename', $line, $column)<CR>"

	if [ -z ${NVIM+x} ]; then
		printf "\e[31mCannot find the neovim process to call. \$NVIM is not set.\e[0m\n"
		printf "\e[31mIs this process running inside a Neovim terminal ?\e[0m\n"
	else
		nvim --server "$NVIM" --remote-send "$command"
	fi
}

launch_editor "$@"
