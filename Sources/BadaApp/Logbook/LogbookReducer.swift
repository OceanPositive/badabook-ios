//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

struct LogbookReducer: Reducer {
    enum Action: Sendable {
        case load
    }

    struct State: Sendable, Equatable {
        var items: [LogbookRowItem] = []
    }

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .load:
            state.items = [
                LogbookRowItem(id: UUID(), logNumber: 1, siteName: "Bada1"),
                LogbookRowItem(id: UUID(), logNumber: 2, siteName: "Bada2"),
                LogbookRowItem(id: UUID(), logNumber: 3, siteName: "Bada3"),
                LogbookRowItem(id: UUID(), logNumber: 4, siteName: "Bada4"),
                LogbookRowItem(id: UUID(), logNumber: 5, siteName: "Bada5"),
            ]
            return .none
        }
    }
}
