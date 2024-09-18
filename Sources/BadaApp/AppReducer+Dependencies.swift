//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaData
import BadaDomain

extension AppReducer {
    func registerUseCases() {
        register {
            GetDiveLogsUseCase {
                let repository = await DiveLogRepository(persistentStore: .main)
                return await repository.diveLogs()
            }
        }
        register {
            PostDiveLogUseCase { diveLog in
                let repository = await DiveLogRepository(persistentStore: .main)
                return await repository.insert(diveLog: diveLog)
            }
        }
    }

    private func register<T: ExecutableUseCase>(
        _ type: T.Type = T.self,
        build: () -> T
    ) {
        UseCaseContainer.instance.register(type, build: build)
    }
}
