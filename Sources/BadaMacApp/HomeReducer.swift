import BadaCore

struct HomeReducer: Reducer {
    enum Action: Sendable {
    }

    struct State: Sendable, Equatable {
    }

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
    }
}
