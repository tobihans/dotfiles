#!/bin/nu -l

def --wrapped main [...args] -> nothing {
    ~/.local/share/bob/nvim-bin/nvim ...$args
}
