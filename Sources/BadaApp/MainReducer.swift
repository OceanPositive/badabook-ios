//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

struct MainReducer: Reducer {
    enum Action: Sendable {
        case load
        case setIsLoaded(Bool)
    }

    struct State: Sendable, Equatable {
        var isLoaded: Bool = false
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
        }
    }
}
