# Reducer Pattern

This reference provides a template and common patterns for Reducers in the Badabook project.

## Template

```swift
import BadaCore
import BadaDomain

struct FeatureReducer: Reducer {
    enum Action: Sendable {
        case load
        case updateText(String)
        case setItems([Item])
        case none
    }

    struct State: Sendable, Equatable {
        var items: [Item] = []
        var text: String = ""
        var isLoading: Bool = false
    }

    @UseCase private var someUseCase: SomeUseCase

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .load:
            state.isLoading = true
            return .single { await executeSomeUseCase() }
        case let .updateText(text):
            state.text = text
            return .none
        case let .setItems(items):
            state.items = items
            state.isLoading = false
            return .none
        case .none:
            return .none
        }
    }

    // Helper for async UseCase execution
    private func executeSomeUseCase() async -> Action {
        let result = await someUseCase.execute()
        switch result {
        case let .success(items):
            return .setItems(items)
        case .failure:
            return .setItems([])
        }
    }
}
```

## Common Effect Patterns

### Debouncing Search
```swift
case let .search(text):
    return .single {
        return .setSearchText(text)
    }
    .debounce(id: DebounceID.search, for: .milliseconds(500))
```

### Binding to External Streams
```swift
func bind() -> AnyEffect<Action> {
    .sequence { send in
        let stream = await someUseCase.stream()
        for await event in stream {
            send(.handleEvent(event))
        }
    }
}
```
