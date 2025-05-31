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
        case dismiss
        case setUser(User)
        case setName(String)
        case setDateOfBirth(Date)
        case setCertifications([Certification])
        case setIsCertificationAddSheetPresenting(Bool)
        case setSheet(State.Sheet?)
        case none
    }

    struct State: Sendable, Equatable {
        var user: User?
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
        var shouldDismiss = false
    }

    @UseCase private var getUserUseCase: GetUserUseCase
    @UseCase private var postUserUseCase: PostUserUseCase
    @UseCase private var putUserUseCase: PutUserUseCase
    @UseCase private var getCertificationsUseCase: GetCertificationsUseCase
    @UseCase private var deleteCertificationUseCase: DeleteCertificationUseCase

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .load:
            return .merge {
                AnyEffect.single { await executeGetCertificationsUseCase() }
                AnyEffect.single { await executeGetUserUseCase() }
            }
        case .save:
            return .single { [state] in
                if let identifier = state.user?.identifier {
                    await executePutUserUseCase(
                        identifier: identifier,
                        state: state
                    )
                } else {
                    await executePostUserUseCase(state: state)
                }
            }
        case let .delete(certification):
            return .single { [state] in
                await executeDeleteCertificationUseCase(
                    state: state,
                    with: certification.identifier
                )
            }
        case .dismiss:
            state.shouldDismiss = true
            return .none
        case let .setUser(user):
            state.user = user
            return .merge {
                AnyEffect.just(.setName(user.name))
                AnyEffect.just(.setDateOfBirth(user.dateOfBirth))
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

    private func executeGetUserUseCase() async -> Action {
        let result = await getUserUseCase.execute()
        switch result {
        case let .success(user):
            return .setUser(user)
        case .failure:
            return .none
        }
    }

    private func executePostUserUseCase(state: State) async -> Action {
        let request = UserInsertRequest(
            name: state.name,
            dateOfBirth: state.dateOfBirth
        )
        let result = await postUserUseCase.execute(for: request)
        switch result {
        case .success:
            return .dismiss
        case .failure:
            return .none
        }
    }

    private func executePutUserUseCase(
        identifier: UserID,
        state: State
    ) async -> Action {
        let request = UserUpdateRequest(
            identifier: identifier,
            name: state.name,
            dateOfBirth: state.dateOfBirth
        )
        let result = await putUserUseCase.execute(for: request)
        switch result {
        case .success:
            return .dismiss
        case .failure:
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
