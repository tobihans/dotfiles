#!/usr/bin/env bash
set -euo pipefail

function setup_microphone() {
	pactl load-module module-null-sink \
		sink_name=audiorelay-virtual-mic-sink \
		sink_properties=device.description=Virtual-Microphone-Sink

	pactl load-module module-remap-source \
		master=audiorelay-virtual-mic-sink.monitor \
		source_name=audiorelay-virtual-mic-sink \
		source_properties=device.description=Virtual-Microphone
}

function destroy_microphone() {
	pactl unload-module module-remap-source
	pactl unload-module module-null-sink
	pulseaudio -k
}

function main() {
	echo "Starting AudioRelay..."

	setup_microphone
	trap destroy_microphone EXIT

	(cd "$HOME/.audiorelay" && ./bin/AudioRelay)
}

main
