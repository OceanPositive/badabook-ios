//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaDomain
import MapKit

package final class LocalSearchRepository: NSObject, LocalSearchRepositoryType {
    private let completer = MKLocalSearchCompleter()
    private var searchContinuation: CheckedContinuation<[LocalSearchResult], Never>?

    package override init() {
        super.init()
        completer.delegate = self
    }

    @MainActor
    package func search(text: String) async -> [LocalSearchResult] {
        return await withCheckedContinuation { continuation in
            searchContinuation = continuation
            completer.queryFragment = text
        }
    }
}

extension LocalSearchRepository: MKLocalSearchCompleterDelegate {
    package func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let searchResults = completer.results.map { result in
            LocalSearchResult(
                title: result.title,
                subtitle: result.subtitle
            )
        }
        searchContinuation?.resume(returning: searchResults)
        searchContinuation = nil
    }

    package func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: any Error) {
        searchContinuation?.resume(returning: [])
        searchContinuation = nil
    }
}
