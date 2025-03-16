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
        case add
        case dismiss
        case setAgency(CertificationAgency)
        case setLevel(CertificationLevel)
        case setNumber(String)
        case setDate(Date)
        case none
    }

    struct State: Sendable, Equatable {
        var agency = CertificationAgency.padi
        var level = CertificationLevel.openWater
        var number = ""
        var date = Date.now
        var shouldDismiss = false
    }

    @UseCase private var postCertificationUseCase: PostCertificationUseCase

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .load:
            return .none
        case .add:
            return .single { [state] in
                await executePostCertificationUseCase(state: state)
            }
        case .dismiss:
            state.shouldDismiss = true
            return .none
        case let .setAgency(agency):
            state.agency = agency
            return .none
        case let .setLevel(level):
            state.level = level
            return .none
        case let .setNumber(number):
            state.number = number
            return .none
        case let .setDate(date):
            state.date = date
            return .none
        case .none:
            return .none
        }
    }

    private func executePostCertificationUseCase(state: State) async -> Action {
        let request = CertificationInsertRequest(
            agency: state.agency,
            level: state.level,
            number: state.number,
            date: state.date
        )
        let result = await postCertificationUseCase.execute(for: request)
        switch result {
        case .success:
            return .dismiss
        case .failure:
            return .none
        }
    }
}
