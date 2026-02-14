---
name: testing-reducer
description: How to write unit tests for a OneWay Reducer using existing patterns
---

# Testing OneWay Reducer

This skill describes how to write comprehensive unit tests for a OneWay `Reducer`.
Follow these instructions to test all actions defined in the `Reducer.Action` enum.

## 1. Prerequisites

-   Ensure you have the `Reducer` file available.
-   Ensure you have the `BadaTesting` module or similar testing utilities available (e.g., `Store`, `UseCaseContainer`).
-   The test file should be named `<ReducerName>Tests.swift`.

## 2. Test File Structure

Use the following template for your test file. Replace `<ReducerName>` with the actual name of your reducer.

```swift
import BadaCore
import BadaDomain
import BadaTesting
@testable import BadaApp // Or the module containing the Reducer

@Suite
struct <ReducerName>Tests {

    // 1. Setup Dependencies (Mocks)
    init() {
        // Register default mock use cases here
        UseCaseContainer.instance.register { 
             // ...
        }
        UseCaseContainer.instance.register { 
             // ...
        }
    }

    // 2. Test Cases will go here
}
```

## 3. Writing Test Cases

**Rule**: Every case in the `Reducer.Action` enum MUST have a corresponding test function.
**Rule**: The name of the test function MUST match the case name of the action.

### Pattern

For each action case:

1.  **Define the Test Function**:
    ```swift
    @Test
    func <actionCaseName>() async {
        // ...
    }
    ```

2.  **Arrange (Setup State and Dependencies)**:
    -   Use `await UseCaseContainer.$instance.withValue(container) { ... }` to scope the dependencies.
    -   If a specific test needs a different initial state, you can create a new state inside the test.
    -   If a specific test needs a different mock behavior, you can re-register it on the `container` inside the test.
    -   When re-registering, make sure to register all dependencies again.

    ```swift
    let container = UseCaseContainer()
    container.register {
        // ...
    }
    container.register {
        // ...
    }

    await UseCaseContainer.$instance.withValue(container) {
        let sut = Store(
            reducer: <ReducerName>(),
            state: <ReducerName>.State(
                // Set initial state values relevant to the test
            )
        )
        // 3. Act & Assert inside the closure
        await sut.send(.<actionCaseName>(<arguments>))
        await sut.expect(\.someProperty, expectedValue)
    }
    ```

### Example

**Reducer Action**:
```swift
enum Action {
    case setCount(Int)
    case fetchUser
}
```

**Test Implementation**:

```swift
@Suite
struct MyReducerTests {
    init() {
        UseCaseContainer.instance.register {
            GetUserUseCase { .success(User(name: "Default")) }
        }
    }

    @Test
    func setCount() async {
        let sut = Store(
            reducer: MyReducer(), 
            state: MyReducer.State()
        )
        await sut.send(.setCount(10))
        await sut.expect(\.count, 10)
    }

    @Test
    func fetchUser() async {
        // Override mock if needed for this specific test
        let container = UseCaseContainer()
        container.register {
            GetUserUseCase { .success(User(name: "Alice")) }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: MyReducer(),
                state: MyReducer.State()
            )
            await sut.send(.fetchUser)
            await sut.expect(\.user, User(name: "Alice"))
        }
    }
}
```

## 4. Verify the test

- Run the test and verify that it passes.
    - `make test-all`
- If the test fails, fix the test and run it again.

## 5. Checklist

- [ ] Have you created a `@Test` function for every `case` in `Action`?
- [ ] Do the test function names match the `Action` case names exactly?
- [ ] Did you mock necessary dependencies (UseCases) for actions with side effects?
- [ ] Did you verify state changes using `sut.expect`?
