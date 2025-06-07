//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

struct CertificationEditReducer: Reducer {
    enum Action: Sendable {
        case load(CertificationID)
        case save
        case delete
        case dismiss
        case setCertification(Certification)
        case setAgency(CertificationAgency)
        case setLevel(CertificationLevel)
        case setNumber(String)
        case setDate(Date)
        case none
    }

    struct State: Sendable, Equatable {
        var identifier: CertificationID?
        var agency = CertificationAgency.padi
        var level = CertificationLevel.openWater
        var number = ""
        var date = Date.now
        var shouldDismiss = false
    }

    @UseCase private var getCertificationUseCase: GetCertificationUseCase
    @UseCase private var putCertificationUseCase: PutCertificationUseCase
    @UseCase private var deleteCertificationUseCase: DeleteCertificationUseCase

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case let .load(identifier):
            state.identifier = identifier
            return .single {
                await executeGetCertificationUseCase(identifier: identifier)
            }
        case .save:
            return .concat {
                AnyEffect.single { [state] in
                    await executePutCertificationUseCase(state: state)
                }
                AnyEffect.just(.dismiss)
            }
        case .delete:
            return .concat {
                AnyEffect.single { [state] in
                    await executeDeleteCertificationUseCase(state: state)
                }
                AnyEffect.just(.dismiss)
            }
        case .dismiss:
            state.shouldDismiss = true
            return .none
        case let .setCertification(certification):
            return .merge {
                AnyEffect.just(.setAgency(certification.agency))
                AnyEffect.just(.setLevel(certification.level))
                AnyEffect.just(.setNumber(certification.number))
                AnyEffect.just(.setDate(certification.date))
            }
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

    private func executeGetCertificationUseCase(identifier: CertificationID) async -> Action {
        let result = await getCertificationUseCase.execute(id: identifier)
        switch result {
        case let .success(certification):
            return .setCertification(certification)
        case .failure:
            return .none
        }
    }

    private func executePutCertificationUseCase(state: State) async -> Action {
        guard let identifier = state.identifier else { return .none }
        let request = CertificationUpdateRequest(
            identifier: identifier,
            agency: state.agency,
            level: state.level,
            number: state.number,
            date: state.date
        )
        let result = await putCertificationUseCase.execute(for: request)
        switch result {
        case .success:
            return .dismiss
        case .failure:
            return .none
        }
    }

    private func executeDeleteCertificationUseCase(state: State) async -> Action {
        guard let identifier = state.identifier else { return .none }
        let result = await deleteCertificationUseCase.execute(id: identifier)
        switch result {
        case .success:
            return .dismiss
        case .failure:
            return .none
        }
    }
}
