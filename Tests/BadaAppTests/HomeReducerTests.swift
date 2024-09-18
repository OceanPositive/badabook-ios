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

final class HomeReducerTests: XCTestCase {
    var sut: Store<HomeReducer>!

    override func setUp() {
        sut = Store(
            reducer: HomeReducer(),
            state: HomeReducer.State()
        )
        UseCaseContainer.shared.reset()
        UseCaseContainer.shared.register {
            GetDiveLogsUseCase { .success([]) }
        }
    }

    func test_initialize() async {
        do {
            let logCount = await sut.state.logCount
            XCTAssertEqual(logCount, nil)
        }

        await sut.send(.initialize)
        await Task.megaYield()

        do {
            let logCount = await sut.state.logCount
            XCTAssertEqual(logCount, 0)
        }
    }

    func test_getDiveLogs() async {
        let diveLog = DiveLog(
            location: DiveLog.Location(
                latitude: 1,
                longitude: 2,
                siteName: "siteName1",
                country: "country1"
            ),
            entryTime: Date(timeIntervalSince1970: 100),
            exitTime: Date(timeIntervalSince1970: 200),
            depth: 10,
            duration: 20,
            waterTemperature: 30,
            visibility: 40,
            airConsumption: 50,
            diveBuddy: "diveBuddy1",
            diveType: "diveType1",
            notes: "notes1"
        )
        UseCaseContainer.shared.register {
            GetDiveLogsUseCase { .success([diveLog, diveLog, diveLog]) }
        }

        await sut.send(.getDiveLogs)
        await Task.megaYield()
        let logCount = await sut.state.logCount
        XCTAssertEqual(logCount, 3)
    }

    func test_setLogCount() async {
        do {
            await sut.send(.setLogCount(10))
            let logCount = await sut.state.logCount
            XCTAssertEqual(logCount, 10)
        }

        do {
            await sut.send(.setLogCount(nil))
            let logCount = await sut.state.logCount
            XCTAssertEqual(logCount, nil)
        }
    }
}
