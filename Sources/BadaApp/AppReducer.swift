//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaData
import BadaDomain

public struct AppReducer: Reducer {
    public enum Action: Sendable {
        case background
        case inactive
        case active
        case load
        case registerUseCases
        case setIsLoaded(Bool)
    }

    public struct State: Sendable, Equatable {
        var scenePhase: ScenePhase = .none
        var isLaunched: Bool = false
        var isLoaded: Bool = false

        public init() {}
    }

    public init() {}

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
            if !state.isLaunched || !state.isLoaded {
                state.isLaunched = true
                return .just(.load)
            }
            return .none
        case .load:
            return .concat {
                AnyEffect.just(.registerUseCases)
                AnyEffect.just(.setIsLoaded(true))
            }
        case .registerUseCases:
            registerUseCases()
            return .none
        case let .setIsLoaded(isLoaded):
            state.isLoaded = isLoaded
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
