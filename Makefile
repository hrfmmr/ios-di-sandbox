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
