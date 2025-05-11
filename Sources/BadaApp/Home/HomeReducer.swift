//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

struct HomeReducer: Reducer {
    enum Action: Sendable {
        case load
        case getDiveLogs
        case setDiveLogs([DiveLog])
    }

    struct State: Sendable, Equatable {
        var diveLogs: [DiveLog] = []
        var totalDiveLogCountText = String.nilText
        var totalDiveSiteCountText = String.nilText
        var totalDiveTimeText = String.nilText
        var daysSinceLastDiveDateText = String.nilText
    }

    @UseCase private var getDiveLogsUseCase: GetDiveLogsUseCase

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .load:
            return .merge {
                .just(.getDiveLogs)
            }
        case .getDiveLogs:
            return .single { await executeGetDiveLogsUseCase() }
        case let .setDiveLogs(diveLogs):
            state.diveLogs = diveLogs
            updateDiveLogSummary(state: &state, diveLogs: diveLogs)
            return .none
        }
    }

    private func executeGetDiveLogsUseCase() async -> Action {
        let result = await getDiveLogsUseCase.execute()
        switch result {
        case let .success(diveLogs):
            return .setDiveLogs(diveLogs)
        case .failure:
            return .setDiveLogs([])
        }
    }

    private func updateDiveLogSummary(state: inout State, diveLogs: [DiveLog]) {
        var totalDiveLogCount = Int.zero
        var totalDiveSiteTitles = Set<String>()
        var totalDiveTime = TimeInterval.zero
        var lastDiveDate: Date?
        for diveLog in diveLogs {
            totalDiveLogCount += 1
            if let title = diveLog.diveSite?.title.lowercased() {
                totalDiveSiteTitles.insert(title)
            }
            if let entry = diveLog.entryTime,
                let exit = diveLog.exitTime
            {
                totalDiveTime += exit.timeIntervalSince(entry)
            }
            if let currentLastDiveDate = lastDiveDate {
                lastDiveDate = max(currentLastDiveDate, diveLog.logDate)
            } else {
                lastDiveDate = diveLog.logDate
            }
        }
        state.totalDiveLogCountText = totalDiveLogCount.formatted(.number)
        state.totalDiveSiteCountText = totalDiveSiteTitles.count.formatted(.number)
        state.totalDiveTimeText = totalDiveTime.formattedDiveTime()
        state.daysSinceLastDiveDateText = lastDiveDate?.formattedDaysAgo() ?? .nilText
    }
}
