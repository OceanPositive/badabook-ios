//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct GetLocalSearchResultUseCase: ExecutableUseCase {
    private let get: @Sendable (LocalSearchCompletion) async -> Result<LocalSearchResult, LocalSearchRepositoryError>

    package init(
        _ get: @Sendable @escaping (LocalSearchCompletion) async -> Result<LocalSearchResult, LocalSearchRepositoryError>
    ) {
        self.get = get
    }

    package func execute(for searchCompletion: LocalSearchCompletion) async -> Result<LocalSearchResult, LocalSearchRepositoryError> {
        await get(searchCompletion)
    }
}
