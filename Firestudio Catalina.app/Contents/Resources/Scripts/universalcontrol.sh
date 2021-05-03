#! /bin/bash

# Remove any existing UC app
rm -rf "/Applications/Universal Control.app"
# Extract installer package
pkgutil --expand-full '/tmp/Presonus Universal Control/PreSonus Universal Control.pkg' /tmp/fscatalina 
# Unmount DG
hdiutil detach '/tmp/Presonus Universal Control/'
# Copy new UC app into place
cp -a '/tmp/fscatalina/UCInstaller.pkg/Payload/Applications/Universal Control.app' /Applications/
# Fix permissions on UC App
chown -R root:admin '/Applications/Universal Control.app'
# Create directory for audio HAL devices, copy into place, and fix permissions
mkdir -p '/Library/Application Support/Presonus/Devices'
cp -a  '/tmp/fscatalina/UCInstaller.pkg/Payload/Library/Application Support/Presonus/Devices' '/Library/Application Support/Presonus/'
chown -R root:wheel '/Library/Application Support/Presonus'