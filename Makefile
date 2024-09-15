PLATFORM_IOS = iOS Simulator,name=iPhone 15
PLATFORM_IPADOS = iOS Simulator,name=iPad (10th generation)
PLATFORM_MACOS = macOS

PROJECT = App/BadaBook.xcodeproj
TEST_SCHEME = AppTests
TEST_PLAN = AppTests
CONFIG = debug

default: test

test:
	for platform in \
		"$(PLATFORM_IOS)" \
		"$(PLATFORM_IPADOS)" \
		"$(PLATFORM_MACOS)"; \
	do \
		xcodebuild test \
			-project $(PROJECT) \
			-scheme $(TEST_SCHEME) \
			-testPlan $(TEST_PLAN) \
			-configuration $(CONFIG) \
			-destination platform="$$platform" || exit 1; \
	done;

.PHONY: test
