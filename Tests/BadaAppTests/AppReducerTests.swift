//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import XCTest

@testable import BadaApp

final class AppReducerTests: XCTestCase {
    var sut: Store<AppReducer>!

    override func setUp() {
        sut = Store(
            reducer: AppReducer(),
            state: AppReducer.State()
        )
    }

    func test_launch() async {
        do {
            let scenePhase = await sut.state.scenePhase
            let isLaunched = await sut.state.isLaunched
            XCTAssertEqual(scenePhase, .none)
            XCTAssertEqual(isLaunched, false)
        }

        await sut.send(.active)

        do {
            let scenePhase = await sut.state.scenePhase
            let isLaunched = await sut.state.isLaunched
            XCTAssertEqual(scenePhase, .active)
            XCTAssertEqual(isLaunched, true)
        }
    }

    func test_scenePhase() async {
        do {
            let scenePhase = await sut.state.scenePhase
            XCTAssertEqual(scenePhase, .none)
        }

        await sut.send(.active)

        do {
            let scenePhase = await sut.state.scenePhase
            XCTAssertEqual(scenePhase, .active)
        }

        await sut.send(.background)

        do {
            let scenePhase = await sut.state.scenePhase
            XCTAssertEqual(scenePhase, .background)
        }

        await sut.send(.inactive)

        do {
            let scenePhase = await sut.state.scenePhase
            XCTAssertEqual(scenePhase, .inactive)
        }

        await sut.send(.active)

        do {
            let scenePhase = await sut.state.scenePhase
            XCTAssertEqual(scenePhase, .active)
        }
    }

    func test_registerUseCases() async {
//        UseCaseContainer.shared.reset()
//
//        do {
//            let scenePhase = await sut.state.scenePhase
//            XCTAssertEqual(scenePhase, .none)
//        }
//
//        await sut.send(.active)
//        await Task.megaYield()
//
//        let _ = UseCaseContainer.shared.resolve(GetDiveLogsUseCase.self)
//        let _ = UseCaseContainer.shared.resolve(PostDiveLogUseCase.self)
//        do {
//            let scenePhase = await sut.state.scenePhase
//            XCTAssertEqual(scenePhase, .active)
//        }
    }
}
