#!/usr/bin/env bash
set -euo pipefail

pactl load-module module-null-sink \
	sink_name=audiorelay-mic-sink \
	sink_properties=device.description=AudioRelay-Sink

pactl load-module module-remap-source \
	master=audiorelay-mic-sink.monitor \
	source_name=audiorelay-mic-sink \
	source_properties=device.description=AudioRelay-Microphone
