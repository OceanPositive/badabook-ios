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
struct SearchReducerTests {
    init() {
        UseCaseContainer.instance.register {
            GetDiveLogsUseCase { .success([]) }
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
            ConnectCloudNotificationUseCase {
                AsyncStream { continuation in
                    continuation.finish()
                }
            }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: SearchReducer(),
                state: SearchReducer.State()
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
            reducer: SearchReducer(),
            state: SearchReducer.State()
        )
        await sut.send(.search("dive"))
        // Wait for debounce
        try? await Task.sleep(for: .milliseconds(500))
        await sut.expect(\.searchText, "dive")
    }

    @Test
    func setItems() async {
        let sut = Store(
            reducer: SearchReducer(),
            state: SearchReducer.State()
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
            ),
        ]

        let sut = Store(
            reducer: SearchReducer(),
            state: SearchReducer.State(items: items)
        )

        // Empty search returns empty (search-only view)
        await sut.expect(\.filteredItems, [])

        // Search by log number
        await sut.send(.setSearchText("#1"))
        await sut.expect(\.searchText, "#1")
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

        // Clear search returns empty
        await sut.send(.setSearchText(""))
        await sut.expect(\.searchText, "")
        await sut.expect(\.filteredItems, [])
    }

    @Test
    func handleCloudEvent() async {
        let container = UseCaseContainer()
        container.register {
            GetDiveLogsUseCase { .success([]) }
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
                reducer: SearchReducer(),
                state: SearchReducer.State()
            )

            await sut.send(
                .handleCloudEvent(
                    CloudEvent(
                        type: .import,
                        identifier: UUID(),
                        storeIdentifier: "test",
                        succeeded: true,
                        startDate: Date(),
                        endDate: nil,
                        error: nil
                    )
                )
            )
            await sut.expect(\.items, [])
        }
    }
}
