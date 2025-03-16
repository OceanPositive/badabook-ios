//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct GetLocalSearchResultUseCase: ExecutableUseCase {
    private let get: @Sendable (LocalSearchCompletion) async throws(LocalSearchRepositoryError) -> LocalSearchResult

    package init(
        _ get: @Sendable @escaping (LocalSearchCompletion) async throws(LocalSearchRepositoryError) -> LocalSearchResult
    ) {
        self.get = get
    }

    package func execute(for searchCompletion: LocalSearchCompletion) async throws(LocalSearchRepositoryError) -> LocalSearchResult {
        try await get(searchCompletion)
    }
}
