#!/usr/bin/env bash
set -euo pipefail

pactl unload-module module-remap-source
pactl unload-module module-null-sink
pulseaudio -k
