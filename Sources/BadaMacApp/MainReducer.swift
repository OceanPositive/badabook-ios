import BadaCore

struct MainReducer: Reducer {
    enum Action: Sendable {
        case load
        case setIsLoaded(Bool)
        case setTab(MainTab)
    }

    struct State: Sendable, Equatable {
        var isLoaded: Bool = false
        var tab: MainTab = .home
    }

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .load:
            return .single {
                do {
                    try await Task.sleep(for: .seconds(1))
                    return .setIsLoaded(true)
                } catch {
                    return .setIsLoaded(false)
                }
            }
        case let .setIsLoaded(isLoaded):
            state.isLoaded = isLoaded
            return .none
        case let .setTab(tab):
            state.tab = tab
            return .none
        }
    }
}
