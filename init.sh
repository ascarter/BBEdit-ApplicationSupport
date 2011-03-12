#!/bin/sh

#
# Create all BBEdit support directories if they don't already exist
# Run this after cloning BBEdit-ApplicationSupport to
# ~/Library/Application Support/BBEdit
#

mkdir -p Attachment Scripts
mkdir -p Language Modules
mkdir -p Scripts
mkdir -p Unix Support
mkdir -p Clippings
mkdir -p Menu Scripts
mkdir -p Startup Items
mkdir -p Completion Data
mkdir -p Plug-Ins
mkdir -p Stationery
mkdir -p HTML Templates
mkdir -p Text Factories
mkdir -p Clippings/Universal Items

# Update preferences plist
PREFS_FILE=com.barebones.bbedit.plist

if [ -f ~/Library/Preferences/${PREFS_FILE} ]; then
     mv ~/Library/Preferences/${PREFS_FILE} ~/Library/Preferences/${PREFS_FILE}.old
fi

cp ./${PREFS_FILE} ~/Library/Preferences/${PREFS_FILE}
