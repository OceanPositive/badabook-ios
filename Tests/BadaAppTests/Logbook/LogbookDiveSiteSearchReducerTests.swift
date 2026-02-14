//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaTesting
import MapKit

@testable import BadaApp

@Suite
struct LogbookDiveSiteSearchReducerTests {
    init() {
        UseCaseContainer.instance.register {
            GetLocalSearchCompletionsUseCase { _ in [] }
        }
        UseCaseContainer.instance.register {
            GetLocalSearchResultUseCase { _ in
                return .failure(.invalidSearchCompletion)
            }
        }
    }

    @Test
    func search() async {
        let completion = LocalSearchCompletion(
            title: "Test Title",
            subtitle: "Test Subtitle",
            rawValue: nil
        )
        let searchResult = LocalSearchResult(
            title: "Test Title",
            subtitle: "Test Subtitle",
            coordinate: nil
        )

        let container = UseCaseContainer()
        container.register {
            GetLocalSearchCompletionsUseCase { _ in [] }
        }
        container.register {
            GetLocalSearchResultUseCase { _ in
                return .success(searchResult)
            }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: LogbookDiveSiteSearchReducer(),
                state: LogbookDiveSiteSearchReducer.State()
            )

            await sut.send(.search(for: completion))
            await sut.expect(\.searchResult, searchResult)
            await sut.expect(\.isSearching, false)
        }
    }

    @Test
    func setSearchText() async {
        let completions = [
            LocalSearchCompletion(title: "A", subtitle: "a", rawValue: nil),
            LocalSearchCompletion(title: "B", subtitle: "b", rawValue: nil),
        ]

        let container = UseCaseContainer()
        container.register {
            GetLocalSearchCompletionsUseCase { _ in completions }
        }
        container.register {
            GetLocalSearchResultUseCase { _ in
                return .failure(.invalidSearchCompletion)
            }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: LogbookDiveSiteSearchReducer(),
                state: LogbookDiveSiteSearchReducer.State()
            )

            await sut.send(.setSearchText("Test"))
            await sut.expect(\.searchText, "Test")

            // Wait for debounce
            try? await Task.sleep(for: .seconds(1))

            // After debounce, it should have fetched completions and updated state
            // Initial manual completion + 2 fetched = 3
            await sut.expect(\.searchCompletions.count, 3)
            await sut.expect(\.searchCompletions[0].title, "Test")  // Manual completion
            await sut.expect(\.searchCompletions[1].title, "A")
            await sut.expect(\.searchCompletions[2].title, "B")
        }
    }

    @Test
    func setSearchResult() async {
        let sut = Store(
            reducer: LogbookDiveSiteSearchReducer(),
            state: LogbookDiveSiteSearchReducer.State()
        )

        let result = LocalSearchResult(
            title: "Result",
            subtitle: "Sub",
            coordinate: nil
        )

        await sut.send(.setSearchResult(result))
        await sut.expect(\.searchResult, result)
    }

    @Test
    func setSearchCompletions() async {
        let sut = Store(
            reducer: LogbookDiveSiteSearchReducer(),
            state: LogbookDiveSiteSearchReducer.State(searchText: "Query")
        )

        let completions = [
            LocalSearchCompletion(title: "Completion 1", subtitle: "Sub 1", rawValue: nil)
        ]

        await sut.send(.setSearchCompletions(completions))

        await sut.expect(\.searchCompletions.count, 2)
        await sut.expect(\.searchCompletions[0].title, "Query")  // Manual
        await sut.expect(\.searchCompletions[1].title, "Completion 1")
    }

    @Test
    func setSearchCompletionsEmpty() async {
        let sut = Store(
            reducer: LogbookDiveSiteSearchReducer(),
            state: LogbookDiveSiteSearchReducer.State(searchText: "Query")
        )

        await sut.send(.setSearchCompletions([]))

        await sut.expect(\.searchCompletions.count, 1)
        await sut.expect(\.searchCompletions[0].title, "Query")
        await sut.expect(\.searchCompletions[0].subtitle, "No matching results")
    }

    @Test
    func setSearchCompletionsEmptyText() async {
        let sut = Store(
            reducer: LogbookDiveSiteSearchReducer(),
            state: LogbookDiveSiteSearchReducer.State(searchText: "")
        )
        let completions = [
            LocalSearchCompletion(title: "Completion 1", subtitle: "Sub 1", rawValue: nil)
        ]

        await sut.send(.setSearchCompletions(completions))

        await sut.expect(\.searchCompletions, [])
    }

    @Test
    func setIsSearching() async {
        let sut = Store(
            reducer: LogbookDiveSiteSearchReducer(),
            state: LogbookDiveSiteSearchReducer.State()
        )

        await sut.send(.setIsSearching(true))
        await sut.expect(\.isSearching, true)
    }
}
