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
        case setName(String)
        case setDateOfBirth(Date)
        case setIsCertificationAddSheetPresenting(Bool)
    }

    struct State: Sendable, Equatable {
        var name: String = ""
        var dateOfBirth: Date = Date(timeIntervalSince1970: 0)
        var certifications: [Certification] = []
        var isCertificationAddSheetPresenting: Bool = false
    }

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .load:
            return .none
        case .save:
            return .none
        case let .setName(name):
            state.name = name
            return .none
        case let .setDateOfBirth(dateOfBirth):
            state.dateOfBirth = dateOfBirth
            return .none
        case let .setIsCertificationAddSheetPresenting(isCertificationAddSheetPresenting):
            state.isCertificationAddSheetPresenting = isCertificationAddSheetPresenting
            return .none
        }
    }
}
