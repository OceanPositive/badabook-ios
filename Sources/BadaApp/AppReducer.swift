//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaData
import BadaDomain

public struct AppReducer: Reducer {
    public enum Action: Sendable {
        case background
        case inactive
        case active
        case registerUseCases
    }

    public struct State: Sendable, Equatable {
        var scenePhase: ScenePhase = .none
        var isLaunched: Bool = false

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
            if !state.isLaunched {
                state.isLaunched = true
                return .just(.registerUseCases)
            }
            return .none
        case .registerUseCases:
            registerUseCases()
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
