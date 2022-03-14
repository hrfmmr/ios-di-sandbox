XCODE_PROJ := app.xcodeproj

mint-run := mint run

.PHONY: default
default: bootstrap

.PHONY: bootstrap
bootstrap:
	mint bootstrap
	"$(MAKE)" build-xcodeproj

.PHONY: build-xcodeproj
build-xcodeproj:
	$(mint-run) xcodegen

.PHONY: needle
needle:
	/opt/homebrew/bin/needle generate \
	Features/Alpha/AlphaSandboxApp/NeedleGenerated.swift \
	Features/Alpha \
	--header-doc .needle/copyright_header.txt
