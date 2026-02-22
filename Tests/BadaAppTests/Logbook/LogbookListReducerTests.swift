//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaTesting
import Foundation
import Testing

@testable import BadaApp

@Suite
struct LogbookListReducerTests {
    init() {
        UseCaseContainer.instance.register {
            GetDiveLogsUseCase { .success([]) }
        }
        UseCaseContainer.instance.register {
            DeleteDiveLogUseCase { _ in .success(Void()) }
        }
        UseCaseContainer.instance.register {
            PostMockDiveLogsUseCase { _ in .success(Void()) }
        }
        UseCaseContainer.instance.register {
            DeleteMockDiveLogsUseCase { .success(Void()) }
        }
        UseCaseContainer.instance.register {
            ConnectCloudNotificationUseCase {
                AsyncStream { continuation in
                    continuation.finish()
                }
            }
        }
    }

    @Test
    func initialState() async {
        let sut = Store(
            reducer: LogbookListReducer(),
            state: LogbookListReducer.State()
        )

        await sut.expect(\.items, [])
        await sut.expect(\.isAddSheetPresenting, false)
    }

    @Test
    func load() async {
        let container = UseCaseContainer()
        container.register {
            GetDiveLogsUseCase {
                .success(
                    [
                        DiveLog(
                            logNumber: 1,
                            logDate: Date(timeIntervalSince1970: 1)
                        ),
                        DiveLog(
                            logNumber: 2,
                            logDate: Date(timeIntervalSince1970: 2)
                        ),
                    ]
                )
            }
        }
        container.register {
            DeleteDiveLogUseCase { _ in .success(Void()) }
        }
        container.register {
            PostMockDiveLogsUseCase { _ in .success(Void()) }
        }
        container.register {
            DeleteMockDiveLogsUseCase { .success(Void()) }
        }
        container.register {
            ConnectCloudNotificationUseCase {
                AsyncStream { continuation in
                    continuation.finish()
                }
            }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: LogbookListReducer(),
                state: LogbookListReducer.State()
            )

            await sut.send(.load)

            // sorted by logNumber descending
            await sut.expect(\.items.count, 2)
            await sut.expect(\.items[0].logNumber, 2)
            await sut.expect(\.items[1].logNumber, 1)
        }
    }

    @Test
    func search() async {
        let sut = Store(
            reducer: LogbookListReducer(),
            state: LogbookListReducer.State()
        )
        await sut.send(.search("1"))
        await sut.expect(\.searchText, "1")
    }

    @Test
    func delete() async {
        let itemToDelete = LogbookListRowItem(
            identifier: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
            logNumber: 1,
            logNumberText: "#1",
            diveSiteText: "Site",
            diveCenterText: "Center",
            maximumDepthText: "10m",
            totalTimeText: "30min",
            logDateText: "Date",
            notesText: "Notes"
        )

        let initialItems = [itemToDelete]

        let container = UseCaseContainer()
        container.register {
            DeleteDiveLogUseCase { id in
                if id == itemToDelete.identifier {
                    return .success(Void())
                } else {
                    return .failure(.noResult)
                }
            }
        }
        container.register {
            GetDiveLogsUseCase { .success([]) }
        }
        container.register {
            PostMockDiveLogsUseCase { _ in .success(Void()) }
        }
        container.register {
            DeleteMockDiveLogsUseCase { .success(Void()) }
        }
        container.register {
            ConnectCloudNotificationUseCase {
                AsyncStream { continuation in
                    continuation.finish()
                }
            }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: LogbookListReducer(),
                state: LogbookListReducer.State(items: initialItems)
            )

            await sut.send(.delete(itemToDelete))
            await sut.expect(\.items, [])
        }
    }

    @Test
    func setItems() async {
        let sut = Store(
            reducer: LogbookListReducer(),
            state: LogbookListReducer.State()
        )

        let items: [LogbookListRowItem] = [
            LogbookListRowItem(
                identifier: UUID(),
                logNumber: 1,
                logNumberText: "#1",
                diveSiteText: "Site",
                diveCenterText: "Center",
                maximumDepthText: "10m",
                totalTimeText: "30min",
                logDateText: "Date",
                notesText: "Notes"
            )
        ]

        await sut.send(.setItems(items))
        await sut.expect(\.items, items)
    }

    @Test
    func setIsAddSheetPresenting() async {
        let sut = Store(
            reducer: LogbookListReducer(),
            state: LogbookListReducer.State()
        )

        await sut.send(.setIsAddSheetPresenting(true))
        await sut.expect(\.isAddSheetPresenting, true)

        await sut.send(.setIsAddSheetPresenting(false))
        await sut.expect(\.isAddSheetPresenting, false)
    }

    @Test
    func setSearchText() async {
        let items: [LogbookListRowItem] = [
            LogbookListRowItem(
                identifier: UUID(),
                logNumber: 2,
                logNumberText: "#2",
                diveSiteText: "Deep Blue",
                diveCenterText: "Center A",
                maximumDepthText: "30m",
                totalTimeText: "45min",
                logDateText: "Date 2",
                notesText: "Good dive"
            ),
            LogbookListRowItem(
                identifier: UUID(),
                logNumber: 1,
                logNumberText: "#1",
                diveSiteText: "Shallow Reef",
                diveCenterText: "Center B",
                maximumDepthText: "10m",
                totalTimeText: "30min",
                logDateText: "Date 1",
                notesText: "Bad visibility"
            )
        ]

        let sut = Store(
            reducer: LogbookListReducer(),
            state: LogbookListReducer.State(items: items)
        )

        // Initial state
        await sut.expect(\.filteredItems, items)

        // Search by log number
        await sut.send(.setSearchText("1"))
        await sut.expect(\.searchText, "1")
        await sut.expect(\.filteredItems.count, 1)
        await sut.expect(\.filteredItems[0].logNumber, 1)

        // Search by dive site
        await sut.send(.setSearchText("Deep"))
        await sut.expect(\.searchText, "Deep")
        await sut.expect(\.filteredItems.count, 1)
        await sut.expect(\.filteredItems[0].logNumber, 2)

        // Search by dive center
        await sut.send(.setSearchText("Center A"))
        await sut.expect(\.searchText, "Center A")
        await sut.expect(\.filteredItems.count, 1)
        await sut.expect(\.filteredItems[0].logNumber, 2)

        // Search by notes
        await sut.send(.setSearchText("visibility"))
        await sut.expect(\.searchText, "visibility")
        await sut.expect(\.filteredItems.count, 1)
        await sut.expect(\.filteredItems[0].logNumber, 1)

        // Search case insensitive
        await sut.send(.setSearchText("deep"))
        await sut.expect(\.searchText, "deep")
        await sut.expect(\.filteredItems.count, 1)
        await sut.expect(\.filteredItems[0].logNumber, 2)

        // Empty search
        await sut.send(.setSearchText(""))
        await sut.expect(\.searchText, "")
        await sut.expect(\.filteredItems, items)
    }
}
