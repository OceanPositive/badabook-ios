//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct GetLocalSearchCompletionsUseCase: ExecutableUseCase {
    private let get: @Sendable (String) async -> [LocalSearchCompletion]

    package init(
        _ get: @Sendable @escaping (String) async -> [LocalSearchCompletion]
    ) {
        self.get = get
    }

    package func execute(for searchText: String) async -> [LocalSearchCompletion] {
        await get(searchText)
    }
}
