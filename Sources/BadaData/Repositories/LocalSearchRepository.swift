//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import MapKit

package final class LocalSearchRepository: NSObject, LocalSearchRepositoryType {
    private let completer = MKLocalSearchCompleter()
    private var searchContinuation: CheckedContinuation<[LocalSearchCompletion], Never>?

    package override init() {
        super.init()
        completer.delegate = self
        completer.resultTypes = MKLocalSearchCompleter.ResultType(rawValue: 0)
    }

    @MainActor
    package func search(
        text: String
    ) async -> [LocalSearchCompletion] {
        guard !text.isEmpty else { return [] }
        return await withCheckedContinuation { continuation in
            searchContinuation = continuation
            completer.queryFragment = text
        }
    }

    package func search(
        for searchCompletion: LocalSearchCompletion
    ) async throws(LocalSearchRepositoryError) -> LocalSearchResult {
        guard let searchCompletion = searchCompletion.rawValue else {
            throw LocalSearchRepositoryError.invalidSearchCompletion
        }
        let request = MKLocalSearch.Request(completion: searchCompletion)
        let search = MKLocalSearch(request: request)
        do {
            let response = try await search.start()
            guard let item = response.mapItems.first else {
                throw LocalSearchRepositoryError.mapItemNotFound
            }
            if let location = item.placemark.location {
                return LocalSearchResult(
                    title: searchCompletion.title,
                    subtitle: searchCompletion.subtitle,
                    coordinate: LocalSearchResult.Coordinate(
                        latitude: location.coordinate.latitude,
                        longitude: location.coordinate.longitude
                    )
                )
            } else {
                return LocalSearchResult(
                    title: searchCompletion.title,
                    subtitle: searchCompletion.subtitle,
                    coordinate: nil
                )
            }
        } catch {
            throw LocalSearchRepositoryError.searchFailed(error.description)
        }
    }
}

extension LocalSearchRepository: MKLocalSearchCompleterDelegate {
    package func completerDidUpdateResults(
        _ completer: MKLocalSearchCompleter
    ) {
        let searchResults = completer.results.map { result in
            LocalSearchCompletion(
                title: result.title,
                subtitle: result.subtitle,
                rawValue: result
            )
        }
        searchContinuation?.resume(returning: searchResults)
        searchContinuation = nil
    }

    package func completer(
        _ completer: MKLocalSearchCompleter,
        didFailWithError error: any Error
    ) {
        searchContinuation?.resume(returning: [])
        searchContinuation = nil
    }
}
