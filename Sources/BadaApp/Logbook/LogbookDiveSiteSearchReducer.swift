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
        case setSearchText(String)
        case setSearchResult(LocalSearchResult?)
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
                .single { await executeGetLocalSearchResult(for: searchCompletion) },
                .just(.setIsSearching(false))
            )
        case let .setSearchText(text):
            state.searchText = text
            return .single { await executeGetLocalSearchCompletions(for: text) }
                .debounce(id: DebounceID.searchText, for: .milliseconds(500))
        case let .setSearchResult(searchResult):
            state.searchResult = searchResult
            return .none
        case let .setSearchCompletions(searchCompletions):
            guard !state.searchText.isEmpty else {
                state.searchCompletions = []
                return .none
            }
            if searchCompletions.isEmpty {
                let manualCompletion = LocalSearchCompletion(
                    title: state.searchText,
                    subtitle: "No matching results",
                    rawValue: nil
                )
                state.searchCompletions = [manualCompletion]
            } else {
                let manualCompletion = LocalSearchCompletion(
                    title: state.searchText,
                    subtitle: "",
                    rawValue: nil
                )
                state.searchCompletions = [manualCompletion] + searchCompletions
            }
            return .none
        case let .setIsSearching(isSearching):
            state.isSearching = isSearching
            return .none
        }
    }

    private func executeGetLocalSearchCompletions(for searchText: String) async -> Action {
        let searchCompletions = await getLocalSearchCompletionsUseCase.execute(for: searchText)
            .sorted { $0.title < $1.title }
        return .setSearchCompletions(searchCompletions)
    }

    private func executeGetLocalSearchResult(for searchCompletion: LocalSearchCompletion) async -> Action {
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
