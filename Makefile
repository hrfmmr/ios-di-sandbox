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
	@needle generate \
		app/DI/NeedleGenerated.swift \
		.needle/source_list_files.txt \
		--header-doc .needle/copyright_header.txt
