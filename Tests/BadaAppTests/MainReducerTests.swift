import BadaCore
import BadaTesting
import Testing

@testable import BadaApp

@Suite
struct MainReducerTests {
    @Test
    func load() async {
        let sut = Store(
            reducer: MainReducer(),
            state: MainReducer.State()
        )
        await sut.send(.load)
        try? await Task.sleep(for: .seconds(1))
        await sut.expect(\.isLoaded, true)
    }

    @Test
    func setIsLoaded() async {
        let sut = Store(
            reducer: MainReducer(),
            state: MainReducer.State()
        )
        await sut.send(.setIsLoaded(true))
        await sut.expect(\.isLoaded, true)

        await sut.send(.setIsLoaded(false))
        await sut.expect(\.isLoaded, false)
    }
}
