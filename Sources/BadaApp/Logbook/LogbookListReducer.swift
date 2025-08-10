//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

struct LogbookListReducer: Reducer {
    enum Action: Sendable {
        case load
        case delete(LogbookListRowItem)
        case addMockData
        case removeMockData
        case setItems([LogbookListRowItem])
        case setIsAddSheetPresenting(Bool)
        case none
    }

    struct State: Sendable, Equatable {
        var items: [LogbookListRowItem] = []
        var isAddSheetPresenting: Bool = false
    }

    @UseCase private var getDiveLogsUseCase: GetDiveLogsUseCase
    @UseCase private var deleteDiveLogUseCase: DeleteDiveLogUseCase
    @UseCase private var postMockDiveLogsUseCase: PostMockDiveLogsUseCase
    @UseCase private var deleteMockDiveLogsUseCase: DeleteMockDiveLogsUseCase

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .load:
            return .single { await executeGetDiveLogsUseCase() }
        case let .delete(item):
            return .single { [state] in
                await executeDeleteDiveLogUseCase(
                    state: state,
                    with: item.id
                )
            }
        case .addMockData:
            return .single { await executePostMockDiveLogsUseCase() }
        case .removeMockData:
            return .single { await executeDeleteMockDiveLogsUseCase() }
        case let .setItems(items):
            state.items = items
            return .none
        case let .setIsAddSheetPresenting(isAddSheetPresenting):
            state.isAddSheetPresenting = isAddSheetPresenting
            return .none
        case .none:
            return .none
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
                    maximumDepthText: formatted(depth: diveLog.maximumDepth),
                    totalTimeText: formattedTotalTime(diveLog.entryTime, diveLog.exitTime),
                    logDateText: formatted(date: diveLog.logDate)
                )
            }.sorted { $0.logNumber > $1.logNumber }
            return .setItems(items)
        case .failure:
            return .setItems([])
        }
    }

    private func executeDeleteDiveLogUseCase(
        state: State,
        with identifier: DiveLogID
    ) async -> Action {
        let result = await deleteDiveLogUseCase.execute(id: identifier)
        switch result {
        case .success:
            let items = state.items
                .filter { $0.identifier != identifier }
                .sorted { $0.logNumber > $1.logNumber }
            return .setItems(items)
        case .failure:
            return .load
        }
    }

    private func executePostMockDiveLogsUseCase() async -> Action {
        var requests = [DiveLogInsertRequest]()
        for _ in 0..<100 {
            requests.append(DiveLogInsertRequest.mock)
        }
        let result = await postMockDiveLogsUseCase.execute(for: requests)
        switch result {
        case .success:
            return .none
        case .failure:
            return .none
        }
    }

    private func executeDeleteMockDiveLogsUseCase() async -> Action {
        let result = await deleteMockDiveLogsUseCase.execute()
        switch result {
        case .success:
            return .none
        case .failure:
            return .none
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
