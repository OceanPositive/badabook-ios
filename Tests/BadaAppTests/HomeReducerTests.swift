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
        let diveLogs: [DiveLog] = [
            DiveLog(logNumber: 0, logDate: Date(timeIntervalSince1970: 0)),
            DiveLog(logNumber: 1, logDate: Date(timeIntervalSince1970: 0)),
            DiveLog(logNumber: 2, logDate: Date(timeIntervalSince1970: 0)),
        ]
        let container = UseCaseContainer()
        container.register {
            GetDiveLogsUseCase { .success(diveLogs) }
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
