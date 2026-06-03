---
name: oneway-reducer-management
description: Guides the creation and testing of Reducers and Stores using the OneWay library and Clean Architecture in the Badabook project. Use this skill when implementing new features or fixing bugs in the App layer that involve state management.
---

# OneWay Reducer Management

This skill provides standardized patterns for implementing and testing Reducers using the [OneWay](https://github.com/DevYeom/OneWay) library within the Badabook project's Clean Architecture.

## Core Concepts

- **State**: A thread-safe, immutable data model representing the UI state.
- **Action**: A set of user intentions or external events that trigger state changes or side effects.
- **Reducer**: A pure logic component that transitions the state based on actions and manages side effects via `AnyEffect`.
- **Store**: The container that holds the state and processes actions.

## Workflows

### 1. Implementing a New Reducer

Follow the patterns in [reducer-pattern.md](references/reducer-pattern.md) to:
1. Define the `Action` enum (Sendable).
2. Define the `State` struct (Equatable, Sendable).
3. Declare dependencies using the `@UseCase` property wrapper.
4. Implement the `reduce(state:action:)` method.
5. (Optional) Implement the `bind()` method for long-running effects.
6. Create private `execute...UseCase` helpers for async operations.

### 2. Testing a Reducer

Follow the patterns in [test-pattern.md](references/test-pattern.md) to:
1. Use `@Suite` and `@Test` from Swift Testing.
2. Initialize dependencies using `UseCaseContainer.instance.register`.
3. Create a `Store` instance with the reducer and initial state.
4. Use `await sut.send(action)` to trigger actions.
5. Use `await sut.expect(\.property, value)` to verify state transitions.
6. Use `UseCaseContainer.$instance.withValue` for scoped dependency injection in tests.

## Key Principles

- **Surgical State Changes**: Only update the necessary properties in `reduce`.
- **Async Safety**: Use `.single` or `.sequence` effects for asynchronous tasks.
- **Dependency Injection**: Always use `@UseCase` and `UseCaseContainer` to ensure testability.
- **Unidirectional Flow**: Actions flow into the Store, and state updates flow out.
