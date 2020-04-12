#!/usr/bin/env bash

read -p "What do you want to name this installation of firefox? Default [FirefoxESR.app]: " namedfirefox

# Download latest Firefox ESR for macOS
wget -O /tmp/FirefoxSetup.dmg "https://download.mozilla.org/?product=firefox-esr-latest&os=osx&lang=en-GB"

# Open FirefoxSetup.dmg and install to /Applications
/usr/bin/hdiutil attach -verify /tmp/FirefoxSetup.dmg

# Validate code signature
/usr/bin/codesign -v --verify /Volumes/Firefox/Firefox.app

/bin/cp -R /Volumes/Firefox/Firefox.app /Applications/$namedfirefox

/bin/echo 'Bootstraping Mozilla Enterprise policies and hardened userjs prefs'

/bin/rm -vrf /Applications/$namedfirefox/Contents/Resources/browser/features/*
/bin/rm -vrf /Applications/$namedfirefox/Contents/Resources/defaults/*

/bin/mkdir /Applications/$namedfirefox/Contents/Resources/distribution

/bin/cp -v -R Firefox.app/Contents/Resources/defaults/ /Applications/$namedfirefox/Contents/Resources/defaults/

/bin/cp -v -R Firefox.app/Contents/Resources/distribution/ /Applications/$namedfirefox/Contents/Resources/distribution/
/bin/cp -v -R Firefox.app/Contents/Resources/mozilla.cfg /Applications/$namedfirefox/Contents/Resources/mozilla.cfg

/usr/bin/hdiutil detach /Volumes/Firefox
rm -vrf /tmp/FirefoxSetup.dmg

/bin/echo 'DONE!'

exit 0