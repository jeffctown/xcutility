#!/usr/bin/xcrun make -f

XCODEMISSING_TEMPORARY_FOLDER?=/tmp/XcodeMissing.dst
PREFIX?=/usr/local

INTERNAL_PACKAGE=XcodeMissingApp.pkg
OUTPUT_PACKAGE=XcodeMissing.pkg

XCODEMISSING_EXECUTABLE=./.build/release/xcodemissing
BINARIES_FOLDER=/usr/local/bin

# ZSH_COMMAND · run single command in `zsh` shell, ignoring most `zsh` startup files.
ZSH_COMMAND := ZDOTDIR='/var/empty' zsh -o NO_GLOBAL_RCS -c
# RM_SAFELY · `rm -rf` ensuring first and only parameter is non-null, contains more than whitespace, non-root if resolving absolutely.
RM_SAFELY := $(ZSH_COMMAND) '[[ ! $${1:?} =~ "^[[:space:]]+\$$" ]] && [[ $${1:A} != "/" ]] && [[ $${\#} == "1" ]] && noglob rm -rf $${1:A}' --

VERSION_STRING=$(shell git describe --abbrev=0 --tags)
DISTRIBUTION_PLIST=Source/xcodemissing/Distribution.plist

RM=rm -f
MKDIR=mkdir -p
SUDO=sudo
CP=cp

.PHONY: all clean install package test uninstall xcconfig xcodeproj

all: installables

clean:
	swift package clean

test:
	swift test

installables:
	swift build -c release

package: installables
	$(MKDIR) "$(XCODEMISSING_TEMPORARY_FOLDER)$(BINARIES_FOLDER)"
	$(CP) "$(XCODEMISSING_EXECUTABLE)" "$(XCODEMISSING_TEMPORARY_FOLDER)$(BINARIES_FOLDER)"

	pkgbuild \
		--identifier "com.jefflett.xcodemissing" \
		--install-location "/" \
		--root "$(XCODEMISSING_TEMPORARY_FOLDER)" \
		--version "$(VERSION_STRING)" \
		"$(INTERNAL_PACKAGE)"

	productbuild \
	  	--distribution "$(DISTRIBUTION_PLIST)" \
	  	--package-path "$(INTERNAL_PACKAGE)" \
	   	"$(OUTPUT_PACKAGE)"

install: installables
	$(SUDO) $(CP) -f "$(XCODEMISSING_EXECUTABLE)" "$(BINARIES_FOLDER)"

uninstall:
	$(RM) "$(BINARIES_FOLDER)/xcodemissing"

xcodeproj:
	 swift package generate-xcodeproj
