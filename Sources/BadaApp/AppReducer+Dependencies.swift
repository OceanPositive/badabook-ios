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
            GetDiveLogUseCase { id in
                let repository = await DiveLogRepository(persistentStore: .main)
                return await repository.diveLog(id: id)
            }
        }
        register {
            PostDiveLogUseCase { request in
                let repository = await DiveLogRepository(persistentStore: .main)
                return await repository.insert(request: request)
            }
        }
        register {
            GetLocalSearchCompletionsUseCase { searchText in
                let repository = LocalSearchRepository()
                return await repository.search(text: searchText)
            }
        }
        register {
            GetLocalSearchResultUseCase { searchCompletion throws(LocalSearchRepositoryError) in
                let repository = LocalSearchRepository()
                return try await repository.search(for: searchCompletion)
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
