#!/usr/bin/env bash

set -u

VERSION="$1"
USERNAME="$ASC_USERNAME"
PASSWORD="$ASC_PASSWORD"
CERT="$CERT_NAME"

DMG="firestudio-catalina-sur-${VERSION}.dmg"
# create temporary log files
NOTARIZE_APP_LOG=$(mktemp -t notarize-app)
NOTARIZE_INFO_LOG=$(mktemp -t notarize-info)


# Delete temporary files on exit
function finish {
	rm "$NOTARIZE_APP_LOG" "$NOTARIZE_INFO_LOG"
  rm -rf tmp
}
trap finish EXIT

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
if xcrun altool --notarize-app --primary-bundle-id se.digitalist.fscatalina -u "$USERNAME" -p "$PASSWORD"  -f "$DMG" > "$NOTARIZE_APP_LOG" 2>&1; then
  cat "$NOTARIZE_APP_LOG"
	RequestUUID=$(awk -F ' = ' '/RequestUUID/ {print $2}' "$NOTARIZE_APP_LOG")

# check status periodically
	while sleep 60 && date; do
		# check notarization status
		if xcrun altool --notarization-info "$RequestUUID"  -u "$USERNAME" -p "$PASSWORD" > "$NOTARIZE_INFO_LOG" 2>&1; then
			cat "$NOTARIZE_INFO_LOG"

			# once notarization is complete, run stapler and exit
			if ! grep -q "Status: in progress" "$NOTARIZE_INFO_LOG"; then
				xcrun stapler staple "$DMG"
				exit $?
			fi
		else
			cat "$NOTARIZE_INFO_LOG" 1>&2
			exit 1
		fi
	done

else
	cat "$NOTARIZE_APP_LOG" 1>&2
	exit 1
fi  
