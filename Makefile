SHELL=/bin/bash -o pipefail
APP_NAME := app
DESTINATION := "platform=iOS Simulator,name=iPhone 13"
APP_FEATURES := Alpha Bravo
TEST_SCHEMES := Alpha Bravo

mint-run := mint run

.PHONY: default
default: bootstrap

.PHONY: bootstrap
bootstrap:
	mint bootstrap
	@"$(MAKE)" git-hooks
	@"$(MAKE)" submodules
	@"$(MAKE)" needle
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
	@scripts/gen_di.sh

.PHONY: build
build: build-xcodeproj
	xcodebuild \
		-scheme ${APP_NAME} \
		-sdk iphonesimulator \
		-destination ${DESTINATION} \
		clean \
		build | $(mint-run) xcbeautify

.PHONY: format
format:
	@$(mint-run) swiftformat \
		--exclude "**/NeedleGenerated.swift" \
		--exclude "**/GeneratedMocks.swift" \
		.

.PHONY: lint
lint:
	@$(mint-run) swiftformat \
		--lint \
		--exclude "**/NeedleGenerated.swift" \
		--exclude "**/GeneratedMocks.swift" \
		.

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
			test | $(mint-run) xcbeautify --report junit; \
	done
