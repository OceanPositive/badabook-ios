# Reducer Test Pattern

This reference provides a template and common patterns for testing Reducers in the Badabook project.

## Template

```swift
import BadaCore
import BadaDomain
import BadaTesting
import Foundation
import Testing

@testable import BadaApp

@Suite
struct FeatureReducerTests {
    init() {
        // Register default mocks for the suite
        UseCaseContainer.instance.register {
            SomeUseCase { .success([]) }
        }
    }

    @Test
    func initialState() async {
        let sut = Store(
            reducer: FeatureReducer(),
            state: FeatureReducer.State()
        )

        await sut.expect(\.items, [])
        await sut.expect(\.isLoading, false)
    }

    @Test
    func loadSuccess() async {
        let container = UseCaseContainer()
        container.register {
            SomeUseCase { .success([Item(id: 1)]) }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: FeatureReducer(),
                state: FeatureReducer.State()
            )

            await sut.send(.load)
            
            await sut.expect(\.isLoading, true)
            await sut.expect(\.items.count, 1)
            await sut.expect(\.isLoading, false)
        }
    }
}
```

## Tips

- **Order of Expectations**: `sut.expect` waits for state changes. Ensure you check transient states (like `isLoading = true`) before checking final states.
- **Mocking Errors**: Register a UseCase that returns `.failure(error)` to test error handling logic.
- **Scoped Containers**: Use `UseCaseContainer.$instance.withValue(container)` to isolate dependency overrides for specific tests.
