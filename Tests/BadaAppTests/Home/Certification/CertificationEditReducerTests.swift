import BadaCore
import BadaDomain
import BadaTesting
import Testing

@testable import BadaApp

@Suite
struct CertificationEditReducerTests {
    init() {
        UseCaseContainer.instance.register {
            GetCertificationUseCase { _ in
                .success(
                    Certification(
                        identifier: UUID(),
                        agency: .padi,
                        level: .openWater,
                        number: "123",
                        date: Date()
                    ))
            }
        }
        UseCaseContainer.instance.register {
            PutCertificationUseCase { _ in .success(()) }
        }
        UseCaseContainer.instance.register {
            DeleteCertificationUseCase { _ in .success(()) }
        }
    }

    @Test
    func load() async {
        let identifier = UUID()
        let certification = Certification(
            identifier: identifier,
            agency: .ssi,
            level: .advancedOpenWater,
            number: "987",
            date: Date()
        )
        let container = UseCaseContainer()
        container.register {
            GetCertificationUseCase { _ in .success(certification) }
        }
        container.register {
            PutCertificationUseCase { _ in .success(()) }
        }
        container.register {
            DeleteCertificationUseCase { _ in .success(()) }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: CertificationEditReducer(),
                state: CertificationEditReducer.State()
            )
            await sut.send(.load(identifier))
            await sut.expect(\.identifier, identifier)
            // The load action triggers executeGetCertificationUseCase which dispatches setCertification
            // setCertification then dispatches setAgency, setLevel, etc.
            // We verify the state changes
            await sut.expect(\.agency, .ssi)
            await sut.expect(\.level, .advancedOpenWater)
            await sut.expect(\.number, "987")
        }
    }

    @Test
    func save() async {
        let container = UseCaseContainer()
        container.register {
            GetCertificationUseCase { _ in
                .success(
                    Certification(
                        identifier: UUID(),
                        agency: .padi,
                        level: .openWater,
                        number: "123",
                        date: Date()
                    ))
            }
        }
        container.register {
            PutCertificationUseCase { _ in .success(()) }
        }
        container.register {
            DeleteCertificationUseCase { _ in .success(()) }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: CertificationEditReducer(),
                state: CertificationEditReducer.State(identifier: UUID())
            )
            await sut.send(.save)
            await sut.expect(\.shouldDismiss, true)
        }
    }

    @Test
    func delete() async {
        let container = UseCaseContainer()
        container.register {
            GetCertificationUseCase { _ in
                .success(
                    Certification(
                        identifier: UUID(),
                        agency: .padi,
                        level: .openWater,
                        number: "123",
                        date: Date()
                    ))
            }
        }
        container.register {
            PutCertificationUseCase { _ in .success(()) }
        }
        container.register {
            DeleteCertificationUseCase { _ in .success(()) }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: CertificationEditReducer(),
                state: CertificationEditReducer.State(identifier: UUID())
            )
            await sut.send(.delete)
            await sut.expect(\.shouldDismiss, true)
        }
    }

    @Test
    func dismiss() async {
        let sut = Store(
            reducer: CertificationEditReducer(),
            state: CertificationEditReducer.State()
        )
        await sut.send(.dismiss)
        await sut.expect(\.shouldDismiss, true)
    }

    @Test
    func setCertification() async {
        let certification = Certification(
            identifier: UUID(),
            agency: .naui,
            level: .rescueDiver,
            number: "456",
            date: Date()
        )

        // This action triggers other actions, so we check the resulting state
        let sut = Store(
            reducer: CertificationEditReducer(),
            state: CertificationEditReducer.State()
        )
        await sut.send(.setCertification(certification))
        await sut.expect(\.agency, .naui)
        await sut.expect(\.level, .rescueDiver)
        await sut.expect(\.number, "456")
    }

    @Test
    func setAgency() async {
        let sut = Store(
            reducer: CertificationEditReducer(),
            state: CertificationEditReducer.State()
        )
        await sut.send(.setAgency(.ssi))
        await sut.expect(\.agency, .ssi)
    }

    @Test
    func setLevel() async {
        let sut = Store(
            reducer: CertificationEditReducer(),
            state: CertificationEditReducer.State()
        )
        await sut.send(.setLevel(.diveMaster))
        await sut.expect(\.level, .diveMaster)
    }

    @Test
    func setNumber() async {
        let sut = Store(
            reducer: CertificationEditReducer(),
            state: CertificationEditReducer.State()
        )
        await sut.send(.setNumber("112233"))
        await sut.expect(\.number, "112233")
    }

    @Test
    func setDate() async {
        let date = Date(timeIntervalSince1970: 1000)
        let sut = Store(
            reducer: CertificationEditReducer(),
            state: CertificationEditReducer.State()
        )
        await sut.send(.setDate(date))
        await sut.expect(\.date, date)
    }

    @Test
    func none() async {
        let sut = Store(
            reducer: CertificationEditReducer(),
            state: CertificationEditReducer.State()
        )
        await sut.send(.none)
    }
}
