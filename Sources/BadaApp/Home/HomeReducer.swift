//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

struct HomeReducer: Reducer {
    enum Action: Sendable {
        case load
        case getCertifications
        case setCertifications([Certification])
        case getDiveLogs
        case setDiveLogs([DiveLog])
    }

    struct State: Sendable, Equatable {
        var certifications: [Certification] = []
        var primaryCertificationText = String.nilText
        var diveLogs: [DiveLog] = []
        var totalExperienceText = String.nilText
        var totalDiveLogCountText = String.nilText
        var totalDiveSiteCountText = String.nilText
        var totalDiveTimeText = String.nilText
        var daysSinceLastDiveDateText = String.nilText
    }

    @UseCase private var getCertificationsUseCase: GetCertificationsUseCase
    @UseCase private var getDiveLogsUseCase: GetDiveLogsUseCase

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .load:
            return .merge {
                AnyEffect.just(.getCertifications)
                AnyEffect.just(.getDiveLogs)
            }
        case .getDiveLogs:
            return .single { await executeGetDiveLogsUseCase() }
        case let .setDiveLogs(diveLogs):
            state.diveLogs = diveLogs
            updateDiveLogSummary(state: &state, diveLogs: diveLogs)
            return .none
        case .getCertifications:
            return .single { await executeGetCertificationsUseCase() }
        case let .setCertifications(certifications):
            updateCertifications(state: &state, certifications: certifications)
            return .none
        }
    }

    private func executeGetCertificationsUseCase() async -> Action {
        let result = await getCertificationsUseCase.execute()
        switch result {
        case let .success(certifications):
            return .setCertifications(certifications)
        case .failure:
            return .setCertifications([])
        }
    }

    private func updateCertifications(state: inout State, certifications: [Certification]) {
        if let latestCertification = certifications.max(by: { $0.date.compare($1.date) == .orderedAscending }) {
            state.primaryCertificationText = latestCertification.level.description
        }
        state.certifications = certifications
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
        var firstDiveDate: Date?
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
            if let currentFirstDiveDate = firstDiveDate {
                firstDiveDate = min(currentFirstDiveDate, diveLog.logDate)
            } else {
                firstDiveDate = diveLog.logDate
            }
            if let currentLastDiveDate = lastDiveDate {
                lastDiveDate = max(currentLastDiveDate, diveLog.logDate)
            } else {
                lastDiveDate = diveLog.logDate
            }
        }
        state.totalExperienceText = firstDiveDate.map({ Date.now.timeIntervalSince($0) })?.formattedExperience() ?? .nilText
        state.totalDiveLogCountText = totalDiveLogCount.formatted(.number)
        state.totalDiveSiteCountText = totalDiveSiteTitles.count.formatted(.number)
        state.totalDiveTimeText = totalDiveTime.formattedDiveTime()
        state.daysSinceLastDiveDateText = lastDiveDate?.formattedDaysAgo() ?? .nilText
    }
}
