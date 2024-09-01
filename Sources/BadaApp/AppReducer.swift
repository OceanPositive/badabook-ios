import BadaCore

public struct AppReducer: Reducer {
    public enum Action: Sendable {
        case background
        case inactive
        case active
    }

    public struct State: Sendable, Equatable {
        var scenePhase: ScenePhase = .none
        public init() { }
    }

    public init() { }

    public func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .background:
            state.scenePhase = .background
            return .none
        case .inactive:
            state.scenePhase = .inactive
            return .none
        case .active:
            state.scenePhase = .active
            return .none
        }
    }
}

extension AppReducer.State {
    enum ScenePhase: Sendable {
        case none
        case background
        case inactive
        case active
    }
}
