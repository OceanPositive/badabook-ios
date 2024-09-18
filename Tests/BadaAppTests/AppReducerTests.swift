//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import Testing

@testable import BadaApp

struct AppReducerTests {
    @Test
    func launch() async {
        let sut = Store(
            reducer: AppReducer(),
            state: AppReducer.State()
        )

        do {
            let scenePhase = await sut.state.scenePhase
            let isLaunched = await sut.state.isLaunched
            #expect(scenePhase == .none)
            #expect(isLaunched == false)
        }

        await sut.send(.active)
        await Task.megaYield()

        do {
            let scenePhase = await sut.state.scenePhase
            let isLaunched = await sut.state.isLaunched
            #expect(scenePhase == .active)
            #expect(isLaunched == true)
        }
    }

    @Test
    func scenePhase() async {
        let sut = Store(
            reducer: AppReducer(),
            state: AppReducer.State()
        )

        do {
            let scenePhase = await sut.state.scenePhase
            #expect(scenePhase == .none)
        }

        await sut.send(.active)
        await Task.megaYield()

        do {
            let scenePhase = await sut.state.scenePhase
            #expect(scenePhase == .active)
        }

        await sut.send(.background)
        await Task.megaYield()

        do {
            let scenePhase = await sut.state.scenePhase
            #expect(scenePhase == .background)
        }

        await sut.send(.inactive)
        await Task.megaYield()

        do {
            let scenePhase = await sut.state.scenePhase
            #expect(scenePhase == .inactive)
        }

        await sut.send(.active)
        await Task.megaYield()

        do {
            let scenePhase = await sut.state.scenePhase
            #expect(scenePhase == .active)
        }
    }

    @Test
    func registerUseCases() async {
        let container = UseCaseContainer()
        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: AppReducer(),
                state: AppReducer.State()
            )

            do {
                let scenePhase = await sut.state.scenePhase
                #expect(scenePhase == .none)
            }

            await sut.send(.active)
            await Task.megaYield()

            let _ = UseCaseContainer.instance.resolve(GetDiveLogsUseCase.self)
            let _ = UseCaseContainer.instance.resolve(PostDiveLogUseCase.self)
            do {
                let scenePhase = await sut.state.scenePhase
                #expect(scenePhase == .active)
            }
        }
    }
}
