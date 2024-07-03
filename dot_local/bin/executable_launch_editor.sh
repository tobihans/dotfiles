#!/usr/bin/env bash

function launch_editor() {
	filename=$1
	line=${2:-"1"}
	column=${3:-"1"}
	command="<C-\\><C-N>:call v:lua.require'utilities'.open_file('$filename', $line, $column)<CR>"

	if [ -z ${NVIM_SOCK+x} ]; then
		printf "\e[31mCannot find the neovim process to call. NVIM_SOCK is not set.\e[0m\n"
	else
		nvim --server "$NVIM_SOCK" --remote-send "$command"
	fi
}

launch_editor "$@"
