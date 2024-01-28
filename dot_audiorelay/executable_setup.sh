#!/usr/bin/env bash
# NOTE: https://www.cyberciti.biz/howto/how-to-install-and-edit-desktop-files-on-linux-desktop-entries/
# NOTE: https://askubuntu.com/questions/1352515/how-to-add-a-folder-with-desktop-files
# TODO: Add version check for upgrade later
set -euo pipefail

VERSION=0.27.5
DOWNLOAD_URL="https://dl.audiorelay.net/setups/linux/audiorelay-$VERSION.tar.gz"
DESKTOP_FILE_NAME="audiorelay-$VERSION.desktop"
DESKTOP_FILE_PATH="$HOME/.local/share/applications/$DESKTOP_FILE_NAME"

# Ensure location is correct
if ! [[ $PWD == "$HOME/.audiorelay" ]]; then
	echo "Please run this script from the .audiorelay directory"
	exit 1
fi

# Download AudioRelay if not already installed
if ! [[ -x "$HOME/.audiorelay/bin/AudioRelay" ]]; then
	echo "Downloading AudioRelay..."
	wget -qO- $DOWNLOAD_URL | tar xvz
else
	echo "AudioRelay already installed"
fi

# Create desktop entry
if ! [[ -f "$DESKTOP_FILE_PATH" ]]; then
	echo "Creating desktop entry..."
	rm -rf "$DESKTOP_FILE_NAME" >/dev/null 2>&1
	touch "$DESKTOP_FILE_NAME"
	desktop-file-edit \
		--set-name="AudioRelay" --copy-name-to-generic-name \
		--set-comment="AudioRelay $VERSION - Stream audio from your PC to your Android device" \
		--set-icon="$PWD/lib/AudioRelay.png" \
		--add-category="AudioVideo;Audio" \
		--set-key="Type" --set-value="Application" \
		--set-key="Exec" --set-value="$PWD/bin/AudioRelay" \
		--set-key="Terminal" --set-value="false" \
		--set-key="StartupWMClass" --set-value="audiorelay" \
		--set-key="StartupNotify" --set-value="true" \
		"$DESKTOP_FILE_NAME"
	desktop-file-install --dir="$HOME/.local/share/applications" "$DESKTOP_FILE_NAME"
	update-desktop-database "$HOME/.local/share/applications"
else
	echo "Desktop entry already exists"
fi
