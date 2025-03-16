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
                return await repository.fetchAll()
            }
        }
        register {
            GetDiveLogUseCase { identifier in
                let repository = await DiveLogRepository(persistentStore: .main)
                return await repository.fetch(by: identifier)
            }
        }
        register {
            PostDiveLogUseCase { request in
                let repository = await DiveLogRepository(persistentStore: .main)
                return await repository.insert(request: request)
            }
        }
        register {
            PutDiveLogUseCase { request in
                let repository = await DiveLogRepository(persistentStore: .main)
                return await repository.update(request: request)
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
        register {
            GetCertificationsUseCase {
                let repository = await CertificationRepository(persistentStore: .main)
                return await repository.fetchAll()
            }
        }
        register {
            GetCertificationUseCase { identifier in
                let repository = await CertificationRepository(persistentStore: .main)
                return await repository.fetch(for: identifier)
            }
        }
        register {
            PostCertificationUseCase { request in
                let repository = await CertificationRepository(persistentStore: .main)
                return await repository.insert(request: request)
            }
        }
        register {
            PutCertificationUseCase { request in
                let repository = await CertificationRepository(persistentStore: .main)
                return await repository.update(request: request)
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
