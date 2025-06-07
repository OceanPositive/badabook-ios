//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

struct EquipmentReducer: Reducer {
    enum Action: Sendable {
    }

    struct State: Sendable, Equatable {
    }

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
    }
}
