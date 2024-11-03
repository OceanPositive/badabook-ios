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
        case setMainTab(State.MainTab)
        case setHomePaths([State.HomePath])
        case setEquipmentPaths([State.EquipmentPath])
        case setLogbookPaths([State.LogbookPath])
        case home(Home)
        case equipment(Equipment)
        case logbook(Logbook)
    }

    struct State: Sendable, Equatable {
        var mainTab = MainTab.home
        var homePaths: [HomePath] = []
        var equipmentPaths: [EquipmentPath] = []
        var logbookPaths: [LogbookPath] = []
    }

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case let .setMainTab(mainTab):
            // FIXME: Update NavigationAuthority bound path tried to update multiple times per frame.
            state.mainTab = mainTab
            return .none
        case let .setHomePaths(paths):
            state.homePaths = paths
            return .none
        case let .setEquipmentPaths(paths):
            state.equipmentPaths = paths
            return .none
        case let .setLogbookPaths(paths):
            state.logbookPaths = paths
            return .none
        case let .home(home):
            return .none
        case let .equipment(equipment):
            return .none
        case let .logbook(logbook):
            switch logbook {
            case let .detail(id):
                state.logbookPaths = [.logDetail(id: id)]
                return .none
            }
        }
    }
}

extension NavigationReducer.Action {
    enum Home {
    }

    enum Equipment {
    }

    enum Logbook {
        case detail(id: LogID)
    }
}

extension NavigationReducer.State {
    enum MainTab {
        case home
        case equipment
        case logbook
    }

    enum HomePath: Hashable {
    }

    enum EquipmentPath: Hashable {
    }

    enum LogbookPath: Hashable {
        case logDetail(id: LogID)
    }
}
