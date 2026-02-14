import BadaCore
import BadaDomain
import BadaTesting
import Testing

@testable import BadaApp

@Suite
struct CertificationAddReducerTests {
    init() {
        UseCaseContainer.instance.register {
            PostCertificationUseCase { _ in .success(()) }
        }
    }

    @Test
    func add() async {
        let container = UseCaseContainer()
        container.register {
            PostCertificationUseCase { _ in .success(()) }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: CertificationAddReducer(),
                state: CertificationAddReducer.State()
            )
            await sut.send(.add)
            await sut.expect(\.shouldDismiss, true)
        }
    }

    @Test
    func dismiss() async {
        let sut = Store(
            reducer: CertificationAddReducer(),
            state: CertificationAddReducer.State()
        )
        await sut.send(.dismiss)
        await sut.expect(\.shouldDismiss, true)
    }

    @Test
    func setAgency() async {
        let sut = Store(
            reducer: CertificationAddReducer(),
            state: CertificationAddReducer.State()
        )
        await sut.send(.setAgency(.ssi))
        await sut.expect(\.agency, .ssi)
    }

    @Test
    func setLevel() async {
        let sut = Store(
            reducer: CertificationAddReducer(),
            state: CertificationAddReducer.State()
        )
        await sut.send(.setLevel(.advancedOpenWater))
        await sut.expect(\.level, .advancedOpenWater)
    }

    @Test
    func setNumber() async {
        let sut = Store(
            reducer: CertificationAddReducer(),
            state: CertificationAddReducer.State()
        )
        await sut.send(.setNumber("123456"))
        await sut.expect(\.number, "123456")
    }

    @Test
    func setDate() async {
        let date = Date(timeIntervalSince1970: 0)
        let sut = Store(
            reducer: CertificationAddReducer(),
            state: CertificationAddReducer.State()
        )
        await sut.send(.setDate(date))
        await sut.expect(\.date, date)
    }

    @Test
    func none() async {
        // No state change expected
        let sut = Store(
            reducer: CertificationAddReducer(),
            state: CertificationAddReducer.State()
        )
        await sut.send(.none)
    }
}
