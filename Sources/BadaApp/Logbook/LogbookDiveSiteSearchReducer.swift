//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

struct LogbookDiveSiteSearchReducer: Reducer {
    enum Action: Sendable {
        case search(for: LocalSearchCompletion)
        case setSearchResult(LocalSearchResult?)
        case setSearchText(String)
        case setSearchCompletions([LocalSearchCompletion])
        case setIsSearching(Bool)
    }

    struct State: Sendable, Equatable {
        var searchText: String = ""
        var searchCompletions: [LocalSearchCompletion] = []
        var searchResult: LocalSearchResult?
        var isSearching: Bool = false
    }

    @UseCase private var getLocalSearchCompletionsUseCase: GetLocalSearchCompletionsUseCase
    @UseCase private var getLocalSearchResultUseCase: GetLocalSearchResultUseCase

    enum DebounceID {
        case searchText
    }

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case let .search(searchCompletion):
            return .concat(
                .just(.setIsSearching(true)),
                .single { await executeGetLocalSearchResultUseCase(for: searchCompletion) },
                .just(.setIsSearching(false))
            )
        case let .setSearchResult(searchResult):
            state.searchResult = searchResult
            return .none
        case let .setSearchText(searchText):
            state.searchText = searchText
            return .single {
                let searchCompletions = await getLocalSearchCompletionsUseCase.execute(for: searchText)
                    .sorted { $0.title < $1.title }
                return .setSearchCompletions(searchCompletions)
            }
            .debounce(id: DebounceID.searchText, for: .milliseconds(500))
        case let .setSearchCompletions(searchCompletions):
            if searchCompletions.isEmpty {
                let manualCompletion = LocalSearchCompletion(
                    title: state.searchText,
                    subtitle: "No matching results",
                    rawValue: nil
                )
                state.searchCompletions = [manualCompletion]
            } else {
                state.searchCompletions = searchCompletions
            }
            return .none
        case let .setIsSearching(isSearching):
            state.isSearching = isSearching
            return .none
        }
    }

    private func executeGetLocalSearchResultUseCase(for searchCompletion: LocalSearchCompletion) async -> Action {
        do {
            let searchResult = try await getLocalSearchResultUseCase.execute(for: searchCompletion)
            return .setSearchResult(searchResult)
        } catch {
            switch error {
            case .invalidSearchCompletion:
                let searchResult = LocalSearchResult(
                    title: searchCompletion.title,
                    subtitle: searchCompletion.subtitle,
                    coordinate: nil
                )
                return .setSearchResult(searchResult)
            case .searchFailed,
                .searchCompletionNotFound,
                .mapItemNotFound:
                return .setSearchResult(nil)
            }
        }
    }
}
