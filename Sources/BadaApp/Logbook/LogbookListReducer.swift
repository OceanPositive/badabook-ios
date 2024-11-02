//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

struct LogbookListReducer: Reducer {
    enum Action: Sendable {
        case load
        case setItems([LogbookListRowItem])
        case setIsAddSheetPresenting(Bool)
    }

    struct State: Sendable, Equatable {
        var items: [LogbookListRowItem] = []
        var isAddSheetPresenting: Bool = false
    }

    @UseCase private var getDiveLogsUseCase: GetDiveLogsUseCase

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .load:
            return .single { await executeGetDiveLogsUseCase() }
        case let .setItems(items):
            state.items = items
            return .none
        case let .setIsAddSheetPresenting(isAddSheetPresenting):
            state.isAddSheetPresenting = isAddSheetPresenting
            return .none
        }
    }

    private func executeGetDiveLogsUseCase() async -> Action {
        let result = await getDiveLogsUseCase.execute()
        switch result {
        case let .success(diveLogs):
            let items = diveLogs.map { diveLog in
                LogbookListRowItem(
                    id: diveLog.id,
                    leadingPrimaryText: "#\(diveLog.logNumber)",
                    leadingSecondaryImage: .location,
                    leadingSecondaryText: diveLog.diveSite?.title,
                    trailingPrimaryText: formatted(depth: diveLog.maximumDepth),
                    trailingSecondaryText: formattedTotalTime(diveLog.entryTime, diveLog.exitTime),
                    trailingTertiarytext: formatted(date: diveLog.logDate)
                )
            }
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
        let interval = exitTime.timeIntervalSince(entryTime)
        return "\(interval.formatted(.number.precision(.fractionLength(0))))min"
    }

    private func formatted(date: Date?) -> String? {
        guard let date else { return nil }
        return date.formatted(date: .abbreviated, time: .omitted)
    }
}
