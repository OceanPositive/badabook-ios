//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package protocol LocalSearchRepositoryType {
    func search(text: String) async -> [LocalSearchCompletion]
    func search(for result: LocalSearchCompletion) async throws(LocalSearchRepositoryError) -> LocalSearchResult
}

package enum LocalSearchRepositoryError: Error {
    case searchFailed(String)
    case searchCompletionNotFound
    case mapItemNotFound
    case invalidSearchCompletion
}
