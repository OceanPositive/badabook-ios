//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

typealias NavigationStore = ViewStore<NavigationReducer>
typealias NavigationState = NavigationReducer.State

extension NavigationStore {
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
            state.mainTab = .home
            switch home {
            case .root:
                state.homePaths = []
                return .none
            case .profile:
                state.homePaths = [.profile]
                return .none
            }
        case let .equipment(equipment):
            state.mainTab = .equipment
            switch equipment {
            case .root:
                state.equipmentPaths = []
                return .none
            }
        case let .logbook(logbook):
            state.mainTab = .logbook
            switch logbook {
            case .root:
                state.logbookPaths = []
                return .none
            case let .logDetail(id):
                state.logbookPaths = [.logDetail(id: id)]
                return .none
            }
        }
    }
}

extension NavigationReducer.Action {
    enum Home {
        case root
        case profile
    }

    enum Equipment {
        case root
    }

    enum Logbook {
        case root
        case logDetail(id: DiveLogID)
    }
}

extension NavigationReducer.State {
    enum MainTab {
        case home
        case equipment
        case logbook
    }

    enum HomePath: Hashable {
        case profile
    }

    enum EquipmentPath: Hashable {
    }

    enum LogbookPath: Hashable {
        case logDetail(id: DiveLogID)
    }
}
