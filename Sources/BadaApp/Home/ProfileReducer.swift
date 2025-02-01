//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

struct ProfileReducer: Reducer {
    enum Action: Sendable {
        case load
        case save
        case setFirstName(String)
        case setLastName(String)
        case setDateOfBirth(Date)
    }

    struct State: Sendable, Equatable {
        var firstName: String = ""
        var lastName: String = ""
        var dateOfBirth: Date = Date(timeIntervalSince1970: 0)
        var certifications: [Certification] = []
    }

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .load:
            return .none
        case .save:
            return .none
        case let .setFirstName(firstName):
            state.firstName = firstName
            return .none
        case let .setLastName(lastName):
            state.lastName = lastName
            return .none
        case let .setDateOfBirth(dateOfBirth):
            state.dateOfBirth = dateOfBirth
            return .none
        }
    }
}
