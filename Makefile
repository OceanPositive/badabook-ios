PLATFORM_IOS = iOS Simulator,name=iPhone 17
PLATFORM_IPADOS = iOS Simulator,name=iPad (A16)

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

test-all: test-ios test-ipados

install:
	@./Tools/install.sh

lint: install
# recursive
	@./swift-format lint -r App Sources Tests
# in place, recursive, parallel
	@./swift-format format -irp App Sources Tests
	@echo "swift-format completed."

.PHONY: test-ios test-ipados test-all install lint
