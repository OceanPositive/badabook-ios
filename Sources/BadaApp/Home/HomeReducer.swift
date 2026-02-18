//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
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
        case handleCloudEvent(CloudEvent)
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
    @UseCase private var connectCloudNotificationUseCase: ConnectCloudNotificationUseCase

    private enum DebounceID {
        case cloudEvent
    }

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
        if let latestCertification = certifications.max(by: {
            guard let lhs = $0.date else { return false }
            guard let rhs = $1.date else { return false }
            return lhs.compare(rhs) == .orderedAscending
        }) {
            state.primaryCertificationText = latestCertification.level?.description ?? .nilText
        } else {
            state.primaryCertificationText = .nilText
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
