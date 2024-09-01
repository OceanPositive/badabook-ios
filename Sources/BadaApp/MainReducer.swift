import BadaCore

struct MainReducer: Reducer {
    enum Action: Sendable {
        case load
    }

    struct State: Sendable, Equatable {
        var isLoaded: Bool = false
        init() { }
    }

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .load:
            state.isLoaded = true
            return .none
        }
    }
}
