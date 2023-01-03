#!/usr/bin/env bash

set -u

VERSION="$1"

CERT="$CERT_NAME"

DMG="firestudio-catalina-sur-ventura-${VERSION}.dmg"

## Increment build number.
OLD_BUILD_NUMBER=$(/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" Firestudio\ Catalina.app/Contents/Info.plist)
NEW_BUILD_NUMBER=$((OLD_BUILD_NUMBER+1))
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion '${NEW_BUILD_NUMBER}'" Firestudio\ Catalina.app/Contents/Info.plist

## Set version
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString '${VERSION}'" Firestudio\ Catalina.app/Contents/Info.plist

## Remove stale attributes.
sudo xattr -rc Firestudio\ Catalina.app/
## Force codesign the app
codesign --force --timestamp --options runtime --deep --sign "${CERT}" Firestudio\ Catalina.app

mkdir -p ./tmp
cp -a Firestudio\ Catalina.app README.md CHANGELOG.txt ./tmp/
## Create DMG
hdiutil create -volname "Firestudio Catalina $VERSION" -srcfolder ./tmp -ov -format UDZO "$DMG"

## Submit DMG for notarization
xcrun notarytool submit --keychain-profile "DGDeveloperID" --wait --progress "$DMG"
xcrun stapler staple "$DMG"
