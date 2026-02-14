//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
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
    func delete() async {
        let itemToDelete = LogbookListRowItem(
            identifier: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
            logNumber: 1,
            logNumberText: "#1",
            diveSiteText: "Site",
            maximumDepthText: "10m",
            totalTimeText: "30min",
            logDateText: "Date"
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
                maximumDepthText: "10m",
                totalTimeText: "30min",
                logDateText: "Date"
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
}
