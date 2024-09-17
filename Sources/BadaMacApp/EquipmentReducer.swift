import BadaCore

struct EquipmentReducer: Reducer {
    enum Action: Sendable {
    }

    struct State: Sendable, Equatable {
    }

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
    }
}
