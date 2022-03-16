XCODE_PROJ := app.xcodeproj

mint-run := mint run
needle := lib/needle/Generator/bin/needle

.PHONY: default
default: bootstrap

.PHONY: bootstrap
bootstrap:
	mint bootstrap
	@"$(MAKE)" submodules
	@"$(MAKE)" build-xcodeproj

.PHONY: build-xcodeproj
build-xcodeproj:
	$(mint-run) xcodegen

.PHONY: submodules
submodules:
	@git submodule update --init --recursive

.PHONY: needle
needle:
	@$(needle) generate \
		app/DI/NeedleGenerated.swift \
		.needle/source_list_files.txt \
		--header-doc .needle/copyright_header.txt
