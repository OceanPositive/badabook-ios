//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

struct SearchReducer: Reducer {
    enum Action: Sendable {
        case load
        case search(String)
        case setItems([LogbookListRowItem])
        case setSearchText(String)
        case handleCloudEvent(CloudEvent)
    }

    struct State: Sendable, Equatable {
        var items: [LogbookListRowItem] = []
        var searchText: String = ""

        var filteredItems: [LogbookListRowItem] {
            if searchText.isEmpty {
                return []
            } else {
                return items.filter { item in
                    item.logNumberText.localizedCaseInsensitiveContains(searchText)
                        || (item.diveSiteText?.localizedCaseInsensitiveContains(searchText) ?? false)
                        || (item.diveCenterText?.localizedCaseInsensitiveContains(searchText) ?? false)
                        || (item.notesText?.localizedCaseInsensitiveContains(searchText) ?? false)
                }
            }
        }
    }

    @UseCase private var getDiveLogsUseCase: GetDiveLogsUseCase
    @UseCase private var connectCloudNotificationUseCase: ConnectCloudNotificationUseCase

    private enum DebounceID {
        case cloudEvent
        case search
    }

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .load:
            return .single { await executeGetDiveLogsUseCase() }
        case let .search(text):
            return .single {
                return .setSearchText(text)
            }
            .debounce(id: DebounceID.search, for: .milliseconds(500))
        case let .setItems(items):
            state.items = items
            return .none
        case let .setSearchText(searchText):
            state.searchText = searchText
            return .none
        case let .handleCloudEvent(cloudEvent):
            switch cloudEvent.type {
            case .import:
                return .just(.load)
                    .debounce(id: DebounceID.cloudEvent, for: .seconds(3))
            case .setup,
                .export:
                return .none
            }
        }
    }

    func bind() -> AnyEffect<Action> {
        AnyEffect.merge {
            AnyEffect.sequence { send in
                let events = await connectCloudNotificationUseCase.execute()
                for await event in events {
                    send(.handleCloudEvent(event))
                }
            }
        }
    }

    private func executeGetDiveLogsUseCase() async -> Action {
        let result = await getDiveLogsUseCase.execute()
        switch result {
        case let .success(diveLogs):
            let items = diveLogs.map { diveLog in
                LogbookListRowItem(
                    identifier: diveLog.identifier,
                    logNumber: diveLog.logNumber,
                    logNumberText: "#\(diveLog.logNumber)",
                    diveSiteText: diveLog.diveSite?.title,
                    diveCenterText: diveLog.diveCenter,
                    maximumDepthText: formatted(depth: diveLog.maximumDepth),
                    totalTimeText: formattedTotalTime(diveLog.entryTime, diveLog.exitTime),
                    logDateText: formatted(date: diveLog.logDate),
                    notesText: diveLog.notes
                )
            }.sorted { $0.logNumber > $1.logNumber }
            return .setItems(items)
        case .failure:
            return .setItems([])
        }
    }

    private func formatted(depth: UnitValue.Distance?) -> String? {
        guard let depth else { return nil }
        switch depth {
        case let .km(double):
            return "\((double * 1_000).formatted(.number.precision(.fractionLength(0))))m"
        case let .m(double):
            return "\(double.formatted(.number.precision(.fractionLength(0))))m"
        }
    }

    private func formattedTotalTime(_ entryTime: Date?, _ exitTime: Date?) -> String? {
        guard let entryTime else { return nil }
        guard let exitTime else { return nil }
        let interval = exitTime.timeIntervalSince(entryTime) / 60.0
        return "\(interval.formatted(.number.precision(.fractionLength(0))))min"
    }

    private func formatted(date: Date?) -> String? {
        guard let date else { return nil }
        return date.formatted(date: .abbreviated, time: .omitted)
    }
}
