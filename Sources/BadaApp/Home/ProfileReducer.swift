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
        case setCertifications([Certification])
        case setIsCertificationAddSheetPresenting(Bool)
    }

    struct State: Sendable, Equatable {
        var name: String = ""
        var dateOfBirth: Date = Date(timeIntervalSince1970: 0)
        var certifications: [Certification] = []
        var isCertificationAddSheetPresenting: Bool = false
    }

    @UseCase private var getCertificationsUseCase: GetCertificationsUseCase

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .load:
            return .single { await executeGetCertificationsUseCase() }
        case .save:
            return .none
        case let .setName(name):
            state.name = name
            return .none
        case let .setDateOfBirth(dateOfBirth):
            state.dateOfBirth = dateOfBirth
            return .none
        case let .setCertifications(certifications):
            state.certifications = certifications
            return .none
        case let .setIsCertificationAddSheetPresenting(isCertificationAddSheetPresenting):
            state.isCertificationAddSheetPresenting = isCertificationAddSheetPresenting
            return .none
        }
    }

    private func executeGetCertificationsUseCase() async -> Action {
        let result = await getCertificationsUseCase.execute()
        switch result {
        case let .success(certifications):
            let sorted = certifications.sorted(by: { $0.date > $1.date })
            return .setCertifications(sorted)
        case .failure:
            return .setCertifications([])
        }
    }
}
