//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

struct HomeReducer: Reducer {
    @UseCase private var getDiveLogsUseCase: GetDiveLogsUseCase

    enum Action: Sendable {
        case initialize
        case getDiveLogs
        case setLogCount(Int?)
    }

    struct State: Sendable, Equatable {
        var logCount: Int?
    }

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .initialize:
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
