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
struct HomeReducerTests {
    @Test
    func load() async {
        let container = UseCaseContainer()
        container.register {
            GetDiveLogsUseCase { .success([]) }
        }
        container.register {
            GetCertificationsUseCase { .success([]) }
        }
        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: HomeReducer(),
                state: HomeReducer.State()
            )
            await sut.expect(\.totalDiveLogCountText, "-")

            await sut.send(.load)
            await sut.expect(\.totalDiveLogCountText, "0")
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
        container.register {
            GetCertificationsUseCase { .success([]) }
        }
        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: HomeReducer(),
                state: HomeReducer.State()
            )
            await sut.send(.getDiveLogs)
            await sut.expect(\.totalDiveLogCountText, "3")
        }
    }
}
