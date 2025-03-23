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
        case delete(Certification)
        case setName(String)
        case setDateOfBirth(Date)
        case setCertifications([Certification])
        case setIsCertificationAddSheetPresenting(Bool)
        case setSheet(State.Sheet?)
        case none
    }

    struct State: Sendable, Equatable {
        var name: String = ""
        var dateOfBirth: Date = Date(timeIntervalSince1970: 0)
        var certifications: [Certification] = []
        var isCertificationAddSheetPresenting: Bool = false
        var sheet: Sheet?
        enum Sheet: Identifiable, Hashable {
            var id: Self { self }
            case certificationAdd
            case certificationEdit(identifier: CertificationID)
        }
    }

    @UseCase private var getCertificationsUseCase: GetCertificationsUseCase
    @UseCase private var deleteCertificationUseCase: DeleteCertificationUseCase

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .load:
            return .single { await executeGetCertificationsUseCase() }
        case .save:
            return .none
        case let .delete(certification):
            return .single { [state] in
                await executeDeleteCertificationUseCase(
                    state: state,
                    with: certification.identifier
                )
            }
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
        case let .setSheet(sheet):
            state.sheet = sheet
            return .none
        case .none:
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

    private func executeDeleteCertificationUseCase(
        state: State,
        with identifier: CertificationID
    ) async -> Action {
        let result = await deleteCertificationUseCase.execute(id: identifier)
        switch result {
        case .success:
            let certifications = state.certifications
                .filter { $0.identifier != identifier }
                .sorted(by: { $0.date > $1.date })
            return .setCertifications(certifications)
        case .failure:
            return .load
        }
    }
}
