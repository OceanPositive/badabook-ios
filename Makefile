PLATFORM_IOS = iOS Simulator,name=iPhone 15
PLATFORM_IPADOS = iOS Simulator,name=iPad (10th generation)
PLATFORM_MACOS = macOS

PROJECT = App/BadaBook.xcodeproj
TEST_SCHEME = AppTests
TEST_PLAN = AppTests
MAC_TEST_SCHEME = MacAppTests
MAC_TEST_PLAN = MacAppTests
CONFIG = debug

default: test-all

test-ios:
	xcodebuild test \
		-project $(PROJECT) \
		-scheme $(TEST_SCHEME) \
		-testPlan $(TEST_PLAN) \
		-configuration $(CONFIG) \
		-destination platform="$(PLATFORM_IOS)" || exit 1;

test-ipados:
	xcodebuild test \
		-project $(PROJECT) \
		-scheme $(TEST_SCHEME) \
		-testPlan $(TEST_PLAN) \
		-configuration $(CONFIG) \
		-destination platform="$(PLATFORM_IPADOS)" || exit 1;

test-macos:
	xcodebuild test \
		-project $(PROJECT) \
		-scheme $(MAC_TEST_SCHEME) \
		-testPlan $(MAC_TEST_PLAN) \
		-configuration $(CONFIG) \
		-destination platform="$(PLATFORM_MACOS)" || exit 1;

test-all: test-ios test-ipados test-macos

.PHONY: test-ios test-ipados test-macos test-all
