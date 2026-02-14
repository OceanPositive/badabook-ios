import BadaCore
import BadaDomain
import BadaTesting
import Testing

@testable import BadaApp

@Suite
struct ProfileReducerTests {
    init() {
        UseCaseContainer.instance.register {
            GetUserUseCase {
                .success(
                    User(
                        identifier: UUID(),
                        name: "Test User",
                        dateOfBirth: Date(),
                        insertDate: Date(),
                        updateDate: Date()
                    ))
            }
        }
        UseCaseContainer.instance.register {
            PostUserUseCase { _ in .success(()) }
        }
        UseCaseContainer.instance.register {
            PutUserUseCase { _ in .success(()) }
        }
        UseCaseContainer.instance.register {
            GetCertificationsUseCase { .success([]) }
        }
        UseCaseContainer.instance.register {
            DeleteCertificationUseCase { _ in .success(()) }
        }
    }

    @Test
    func load() async {
        let user = User(
            identifier: UUID(),
            name: "John Doe",
            dateOfBirth: Date(timeIntervalSince1970: 0),
            insertDate: Date(),
            updateDate: Date()
        )
        let certifications = [
            Certification(
                identifier: UUID(),
                agency: .padi,
                level: .openWater,
                number: "111",
                date: Date()
            )
        ]

        let container = UseCaseContainer()
        container.register {
            GetUserUseCase { .success(user) }
        }
        container.register {
            PostUserUseCase { _ in .success(()) }
        }
        container.register {
            PutUserUseCase { _ in .success(()) }
        }
        container.register {
            GetCertificationsUseCase { .success(certifications) }
        }
        container.register {
            DeleteCertificationUseCase { _ in .success(()) }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: ProfileReducer(),
                state: ProfileReducer.State()
            )
            await sut.send(.load)

            // Checking the side effects of load -> setUser -> setName, setDateOfBirth
            await sut.expect(\.user, user)
            await sut.expect(\.name, "John Doe")
            await sut.expect(\.dateOfBirth, Date(timeIntervalSince1970: 0))
            await sut.expect(\.certifications, certifications)
        }
    }

    @Test
    func savePost() async {
        // User doesn't exist, so it should call PostUserUseCase
        let container = UseCaseContainer()
        container.register {
            GetUserUseCase {
                .success(
                    User(
                        identifier: UUID(),
                        name: "Test User",
                        dateOfBirth: Date(),
                        insertDate: Date(),
                        updateDate: Date()
                    ))
            }
        }
        container.register {
            PostUserUseCase { _ in .success(()) }
        }
        container.register {
            PutUserUseCase { _ in .success(()) }
        }
        container.register {
            GetCertificationsUseCase { .success([]) }
        }
        container.register {
            DeleteCertificationUseCase { _ in .success(()) }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: ProfileReducer(),
                state: ProfileReducer.State(user: nil, name: "New User")
            )
            await sut.send(.save)
            await sut.expect(\.shouldDismiss, true)
        }
    }

    @Test
    func savePut() async {
        // User exists, so it should call PutUserUseCase
        let user = User(
            identifier: UUID(),
            name: "Old",
            dateOfBirth: Date(),
            insertDate: Date(),
            updateDate: Date()
        )
        let container = UseCaseContainer()
        container.register {
            GetUserUseCase {
                .success(
                    User(
                        identifier: UUID(),
                        name: "Test User",
                        dateOfBirth: Date(),
                        insertDate: Date(),
                        updateDate: Date()
                    ))
            }
        }
        container.register {
            PostUserUseCase { _ in .success(()) }
        }
        container.register {
            PutUserUseCase { _ in .success(()) }
        }
        container.register {
            GetCertificationsUseCase { .success([]) }
        }
        container.register {
            DeleteCertificationUseCase { _ in .success(()) }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: ProfileReducer(),
                state: ProfileReducer.State(user: user, name: "Updated User")
            )
            await sut.send(.save)
            await sut.expect(\.shouldDismiss, true)
        }
    }

    @Test
    func delete() async {
        let certification = Certification(
            identifier: UUID(),
            agency: .ssi,
            level: .advancedOpenWater,
            number: "222",
            date: Date()
        )
        // Should delete and then reload or update certifications
        let container = UseCaseContainer()
        container.register {
            GetUserUseCase {
                .success(
                    User(
                        identifier: UUID(),
                        name: "Test User",
                        dateOfBirth: Date(),
                        insertDate: Date(),
                        updateDate: Date()
                    ))
            }
        }
        container.register {
            PostUserUseCase { _ in .success(()) }
        }
        container.register {
            PutUserUseCase { _ in .success(()) }
        }
        container.register {
            GetCertificationsUseCase { .success([]) }
        }
        container.register {
            DeleteCertificationUseCase { _ in .success(()) }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: ProfileReducer(),
                state: ProfileReducer.State(certifications: [certification])
            )
            await sut.send(.delete(certification))
            await sut.expect(\.certifications, [])
        }
    }

    @Test
    func dismiss() async {
        let sut = Store(
            reducer: ProfileReducer(),
            state: ProfileReducer.State()
        )
        await sut.send(.dismiss)
        await sut.expect(\.shouldDismiss, true)
    }

    @Test
    func setUser() async {
        let user = User(
            identifier: UUID(),
            name: "Jane",
            dateOfBirth: Date(timeIntervalSince1970: 100),
            insertDate: Date(),
            updateDate: Date()
        )
        let sut = Store(
            reducer: ProfileReducer(),
            state: ProfileReducer.State()
        )
        await sut.send(.setUser(user))
        await sut.expect(\.user, user)
        await sut.expect(\.name, "Jane")
        await sut.expect(\.dateOfBirth, Date(timeIntervalSince1970: 100))
    }

    @Test
    func setName() async {
        let sut = Store(
            reducer: ProfileReducer(),
            state: ProfileReducer.State()
        )
        await sut.send(.setName("New Name"))
        await sut.expect(\.name, "New Name")
    }

    @Test
    func setDateOfBirth() async {
        let date = Date(timeIntervalSince1970: 200)
        let sut = Store(
            reducer: ProfileReducer(),
            state: ProfileReducer.State()
        )
        await sut.send(.setDateOfBirth(date))
        await sut.expect(\.dateOfBirth, date)
    }

    @Test
    func setCertifications() async {
        let certifications = [
            Certification(
                identifier: UUID(),
                agency: .padi,
                level: .diveMaster,
                number: "333",
                date: Date()
            )
        ]
        let sut = Store(
            reducer: ProfileReducer(),
            state: ProfileReducer.State()
        )
        await sut.send(.setCertifications(certifications))
        await sut.expect(\.certifications, certifications)
    }

    @Test
    func setIsCertificationAddSheetPresenting() async {
        let sut = Store(
            reducer: ProfileReducer(),
            state: ProfileReducer.State()
        )
        await sut.send(.setIsCertificationAddSheetPresenting(true))
        await sut.expect(\.isCertificationAddSheetPresenting, true)
    }

    @Test
    func setSheet() async {
        let sut = Store(
            reducer: ProfileReducer(),
            state: ProfileReducer.State()
        )
        await sut.send(.setSheet(.certificationAdd))
        await sut.expect(\.sheet, .certificationAdd)
    }

    @Test
    func none() async {
        let sut = Store(
            reducer: ProfileReducer(),
            state: ProfileReducer.State()
        )
        await sut.send(.none)
    }
}
