//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

package struct GetLocalSearchResultsUseCase: ExecutableUseCase {
    private let get: @Sendable (String) async -> [LocalSearchResult]

    package init(
        _ get: @Sendable @escaping (String) async -> [LocalSearchResult]
    ) {
        self.get = get
    }

    package func execute(searchText: String) async -> [LocalSearchResult] {
        await get(searchText)
    }
}
