APP_NAME := app
DESTINATION := "platform=iOS Simulator,name=iPhone 13"
APP_FEATURES := Alpha Bravo
TEST_SCHEMES := Alpha

mint-run := mint run
needle := lib/needle/Generator/bin/needle

.PHONY: default
default: bootstrap

.PHONY: bootstrap
bootstrap:
	mint bootstrap
	@"$(MAKE)" git-hooks
	@"$(MAKE)" submodules
	@"$(MAKE)" build-xcodeproj

hooks = $(patsubst .git-hooks/%,.git/hooks/%,$(wildcard .git-hooks/*))
.PHONY: hooks
$(hooks):
	@test -d .git/hooks && ln -fnsv $(patsubst .git/hooks/%,$(PWD)/.git-hooks/%,$@) $@ \
		|| echo "skipping git hook installation: .git/hooks does not exist" >&2 1>/dev/null
.PHONY: git-hooks
git-hooks: $(hooks)

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

.PHONY: build
build: build-xcodeproj
	xcodebuild \
		-scheme ${APP_NAME} \
		-sdk iphonesimulator \
		-destination ${DESTINATION} \
		clean \
		build

.PHONY: format
format:
	@$(mint-run) swiftformat . \
		--exclude lib

.PHONY: lint
lint:
	@$(mint-run) swiftformat . \
		--lint \
		--exclude lib

.PHONY: mocks
mocks:
	@for target in $(APP_FEATURES); do \
		scripts/gen_mock.sh $$target; \
	done

.PHONY: test
test: lint
	for scheme in ${TEST_SCHEMES}; do \
		xcodebuild \
			-scheme $$scheme \
			-sdk iphonesimulator \
			-destination ${DESTINATION} \
			test; \
	done
