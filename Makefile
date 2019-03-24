#!/usr/bin/xcrun make -f

XCUTILITY_TEMPORARY_FOLDER?=/tmp/XCUtility.dst
PREFIX?=/usr/local

OUTPUT_PACKAGE=XCUtility.pkg
FRAMEWORK_NAME=XCUtilityFramework

XCUTILITY_EXECUTABLE=./.build/release/xcutility
BINARIES_FOLDER=/usr/local/bin

# ZSH_COMMAND · run single command in `zsh` shell, ignoring most `zsh` startup files.
ZSH_COMMAND := ZDOTDIR='/var/empty' zsh -o NO_GLOBAL_RCS -c
# RM_SAFELY · `rm -rf` ensuring first and only parameter is non-null, contains more than whitespace, non-root if resolving absolutely.
RM_SAFELY := $(ZSH_COMMAND) '[[ ! $${1:?} =~ "^[[:space:]]+\$$" ]] && [[ $${1:A} != "/" ]] && [[ $${\#} == "1" ]] && noglob rm -rf $${1:A}' --

VERSION_STRING=$(shell git describe --abbrev=0 --tags)

RM=rm -f
MKDIR=mkdir -p
SUDO=sudo
CP=cp

.PHONY: all clean lint test installables package install uninstall xcodeproj xcodetest codecoverage archive release

all: installables

clean:
	swift package clean
	
lint:
	swiftlint --strict 
	
test:
	swift test

installables:
	swift build -c release

package: installables archive
	$(MKDIR) "$(XCUTILITY_TEMPORARY_FOLDER)$(BINARIES_FOLDER)"
	$(CP) "$(XCUTILITY_EXECUTABLE)" "$(XCUTILITY_TEMPORARY_FOLDER)$(BINARIES_FOLDER)"

	pkgbuild \
		--identifier "com.jefflett.xcutility" \
		--install-location "/" \
		--root "$(XCUTILITY_TEMPORARY_FOLDER)" \
		--version "$(VERSION_STRING)" \
		"$(OUTPUT_PACKAGE)"

install: installables
	$(SUDO) $(CP) -f "$(XCUTILITY_EXECUTABLE)" "$(BINARIES_FOLDER)"

uninstall:
	$(RM) "$(BINARIES_FOLDER)/xcutility"

xcodeproj:
	swift package generate-xcodeproj

xcodetest: xcodeproj
	xcodebuild -scheme xcutility build test

codecoverage: xcodeproj
	xcodebuild -scheme xcutility -enableCodeCoverage YES build test -quiet

archive:
	carthage build --no-skip-current --platform mac
	carthage archive $(FRAMEWORK_NAME)

release: | lint test xcodetest archive package install





