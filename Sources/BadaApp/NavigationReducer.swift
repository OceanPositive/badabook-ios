//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

typealias NavigationState = NavigationReducer.State

enum NavigationStore {
    @MainActor
    static let shared = ViewStore(
        reducer: NavigationReducer(),
        state: NavigationReducer.State()
    )
}

struct NavigationReducer: Reducer {
    enum Action: Sendable {
        case setHomePaths([State.HomePath])
        case setEquipmentPaths([State.EquipmentPath])
        case setLogbookPaths([State.LogbookPath])
        case logDetail(id: LogID)
    }

    struct State: Sendable, Equatable {
        var mainTab = MainTab.home
        var homePaths: [HomePath] = []
        var equipmentPaths: [EquipmentPath] = []
        var logbookPaths: [LogbookPath] = []
    }

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case let .setHomePaths(paths):
            state.homePaths = paths
            return .none
        case let .setEquipmentPaths(paths):
            state.equipmentPaths = paths
            return .none
        case let .setLogbookPaths(paths):
            state.logbookPaths = paths
            return .none
        case let .logDetail(id):
            state.logbookPaths = [.logDetail(id: id)]
            return .none
        }
    }
}

extension NavigationReducer.State {
    enum HomePath: Hashable {
    }

    enum EquipmentPath: Hashable {
    }

    enum LogbookPath: Hashable {
        case logDetail(id: LogID)
    }
}
