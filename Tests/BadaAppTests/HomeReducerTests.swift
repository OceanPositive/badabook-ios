//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaTesting

@testable import BadaApp

struct HomeReducerTests {
    @Test
    func initialize() async {
        let container = UseCaseContainer()
        container.register {
            GetDiveLogsUseCase { .success([]) }
        }
        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: HomeReducer(),
                state: HomeReducer.State()
            )
            await sut.expect(\.logCount, nil)

            await sut.send(.initialize)
            await sut.expect(\.logCount, 0)
        }
    }

    @Test
    func getDiveLogs() async {
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
        let container = UseCaseContainer()
        container.register {
            GetDiveLogsUseCase { .success([diveLog, diveLog, diveLog]) }
        }
        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: HomeReducer(),
                state: HomeReducer.State()
            )
            await sut.send(.getDiveLogs)
            await sut.expect(\.logCount, 3)
        }
    }

    @Test
    func setLogCount() async {
        let container = UseCaseContainer()
        container.register {
            GetDiveLogsUseCase { .success([]) }
        }
        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: HomeReducer(),
                state: HomeReducer.State()
            )
            await sut.send(.setLogCount(10))
            await sut.expect(\.logCount, 10)

            await sut.send(.setLogCount(nil))
            await sut.expect(\.logCount, nil)
        }
    }
}
