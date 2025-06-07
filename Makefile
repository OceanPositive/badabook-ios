PLATFORM_IOS = iOS Simulator,name=iPhone 16
PLATFORM_IPADOS = iOS Simulator,name=iPad (10th generation)
PLATFORM_MACOS = macOS

PROJECT = App/Badabook.xcodeproj
TEST_SCHEME = AppTests
TEST_PLAN = AppTests
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
		-scheme $(TEST_SCHEME) \
		-testPlan $(TEST_PLAN) \
		-configuration $(CONFIG) \
		-destination platform="$(PLATFORM_MACOS)" || exit 1;

test-all: test-ios test-ipados test-macos

install:
	@./Tools/install.sh

lint: install
# recursive
	@./swift-format lint -r App Sources Tests
# in place, recursive, parallel
	@./swift-format format -irp App Sources Tests
	@echo "swift-format completed."

.PHONY: test-ios test-ipados test-macos test-all install lint
