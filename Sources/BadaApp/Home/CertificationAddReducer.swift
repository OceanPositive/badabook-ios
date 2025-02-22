//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

struct CertificationAddReducer: Reducer {
    enum Action: Sendable {
        case load
    }

    struct State: Sendable, Equatable {
    }

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .load:
            return .none
        }
    }
}
