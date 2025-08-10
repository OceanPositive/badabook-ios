//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaTesting

@testable import BadaApp

@Suite
struct AppReducerTests {
    @Test
    func launch() async {
        let sut = Store(
            reducer: AppReducer(),
            state: AppReducer.State()
        )
        await sut.expect(\.scenePhase, .none)
        await sut.expect(\.isLaunched, false)

        await sut.send(.active)
        await sut.expect(\.scenePhase, .active)
        await sut.expect(\.isLaunched, true)
    }

    @Test
    func scenePhase() async {
        let sut = Store(
            reducer: AppReducer(),
            state: AppReducer.State()
        )
        await sut.expect(\.scenePhase, .none)

        await sut.send(.active)
        await sut.expect(\.scenePhase, .active)

        await sut.send(.background)
        await sut.expect(\.scenePhase, .background)

        await sut.send(.inactive)
        await sut.expect(\.scenePhase, .inactive)

        await sut.send(.active)
        await sut.expect(\.scenePhase, .active)
    }

    @Test
    func registerUseCases() async {
        let container = UseCaseContainer()
        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: AppReducer(),
                state: AppReducer.State()
            )
            await sut.expect(\.scenePhase, .none)

            await sut.send(.active)
            await sut.expect(\.scenePhase, .active)

            /// `fatalError` must not occur
            let _ = UseCaseContainer.instance.resolve(GetDiveLogsUseCase.self)
            let _ = UseCaseContainer.instance.resolve(PostDiveLogUseCase.self)
        }
    }
}
