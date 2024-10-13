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
        case setSearchText(String)
        case setSearchResults([LocalSearchResultItem])
    }

    struct State: Sendable, Equatable {
        var searchText: String = ""
        var searchResults: [LocalSearchResultItem] = []
    }

    @UseCase private var getLocalSearchResultsUseCase: GetLocalSearchResultsUseCase

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case let .setSearchText(searchText):
            state.searchText = searchText
            return .single {
                let searchResults = await getLocalSearchResultsUseCase.execute(searchText: searchText)
                    .map { result in
                        LocalSearchResultItem(
                            title: result.title,
                            subtitle: result.subtitle
                        )
                    }
                    .sorted { $0.title < $1.title }
                return .setSearchResults(searchResults)
            }
        case let .setSearchResults(searchResults):
            state.searchResults = searchResults
            return .none
        }
    }
}
