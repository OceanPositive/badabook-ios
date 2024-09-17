import BadaCore

struct LogbookReducer: Reducer {
    enum Action: Sendable {
    }

    struct State: Sendable, Equatable {
    }

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
    }
}
