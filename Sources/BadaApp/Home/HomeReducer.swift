//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

struct HomeReducer: Reducer {
    enum Action: Sendable {
        case load
        case getDiveLogs
        case setLogCount(Int?)
    }

    struct State: Sendable, Equatable {
        var logCount: Int?
    }

    @UseCase private var getDiveLogsUseCase: GetDiveLogsUseCase

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .load:
            return .merge {
                .just(.getDiveLogs)
            }
        case .getDiveLogs:
            return .single {
                let result = await getDiveLogsUseCase.execute()
                switch result {
                case let .success(diveLogs):
                    return .setLogCount(diveLogs.count)
                case .failure:
                    return .setLogCount(nil)
                }
            }
        case let .setLogCount(logCount):
            state.logCount = logCount
            return .none
        }
    }
}
