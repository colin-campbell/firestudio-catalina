#! /bin/bash

# Remove any existing FC app
rm -rf '/Applications/FireControl.app'
mkdir -p /tmp/fscatalina

# Extract installer package
tar -C /tmp/fscatalina/ -zxf '/tmp/PreSonus FireControl 2626/PreSonus FireControl 2626.pkg/Contents/Archive.pax.gz'
# Unmount DG
hdiutil detach '/tmp/PreSonus FireControl 2626/'
# Copy new FC app into place
cp -a '/tmp/fscatalina/Applications/FireControl.app' '/Applications/'
# Fix permissions on FC App
chown -R root:admin '/Applications/FireControl.app'
# FireControl is so old it isn't even signed at all .
codesign -s - --force --deep --timestamp '/Applications/FireControl.app'
# Create directory for audio HAL devices, copy into place, and fix permissions
mkdir -p '/Library/Application Support/Presonus/Devices'
cp -a  '/tmp/fscatalina/Library/Application Support/Presonus/Devices/firestudiodevice.bundle' '/Library/Application Support/Presonus/Devices/'
chown -R root:wheel '/Library/Application Support/Presonus/Devices'
codesign -s - --force --deep --timestamp '/Library/Application Support/Presonus/Devices/firestudiodevice.bundle'
