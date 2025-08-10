//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaTesting

@testable import BadaData

@Suite
struct DiveLogRepositoryTests {
    let sut: DiveLogRepository!

    init() async {
        sut = await DiveLogRepository(persistentStore: PersistentStore.mainTest)
    }

    @Test
    func insert() async {
        let request = DiveLogInsertRequest(
            logNumber: #line,
            logDate: Date(timeIntervalSince1970: 12),
            diveSite: nil,
            diveCenter: nil,
            diveStyle: nil,
            entryTime: nil,
            exitTime: nil,
            surfaceInterval: nil,
            entryAir: nil,
            exitAir: nil,
            gasType: nil,
            equipment: nil,
            maximumDepth: nil,
            averageDepth: nil,
            airTemperature: nil,
            surfaceTemperature: nil,
            bottomTemperature: nil,
            weather: nil,
            surge: nil,
            visibility: nil,
            visibilityDistance: nil,
            feeling: nil,
            companions: [],
            notes: nil
        )
        switch await sut.insert(request: request) {
        case .success:
            break
        case let .failure(error):
            Issue.record(error)
        }

        switch await sut.fetchAll() {
        case let .success(diveLogs):
            if let diveLog = diveLogs.first(where: { $0.logNumber == request.logNumber }) {
                #expect(diveLog.logDate == request.logDate)
                #expect(diveLog.notes == nil)
            } else {
                Issue.record("No diveLog found.")
            }
        case let .failure(error):
            Issue.record(error)
        }
    }

    @Test
    func update() async {
        let insertRequest = DiveLogInsertRequest(
            logNumber: #line,
            logDate: Date(timeIntervalSince1970: 12),
            diveSite: nil,
            diveCenter: nil,
            diveStyle: nil,
            entryTime: nil,
            exitTime: nil,
            surfaceInterval: nil,
            entryAir: nil,
            exitAir: nil,
            gasType: nil,
            equipment: nil,
            maximumDepth: nil,
            averageDepth: nil,
            airTemperature: nil,
            surfaceTemperature: nil,
            bottomTemperature: nil,
            weather: nil,
            surge: nil,
            visibility: nil,
            visibilityDistance: nil,
            feeling: nil,
            companions: [],
            notes: nil
        )
        switch await sut.insert(request: insertRequest) {
        case .success:
            break
        case let .failure(error):
            Issue.record(error)
        }

        var mock: DiveLog?
        switch await sut.fetchAll() {
        case let .success(diveLogs):
            if let diveLog = diveLogs.first(where: { $0.logNumber == insertRequest.logNumber }) {
                #expect(diveLog.logDate == Date(timeIntervalSince1970: 12))
                #expect(diveLog.notes == nil)
                mock = diveLog
            } else {
                Issue.record("No diveLog found.")
            }
        case let .failure(error):
            Issue.record(error)
        }
        guard let mock else {
            Issue.record("No diveLog found.")
            return
        }

        let updateRequest = DiveLogUpdateRequest(
            identifier: mock.identifier,
            logNumber: mock.logNumber,
            logDate: Date(timeIntervalSince1970: 13),
            diveSite: mock.diveSite,
            diveCenter: mock.diveCenter,
            diveStyle: mock.diveStyle,
            entryTime: mock.entryTime,
            exitTime: mock.exitTime,
            surfaceInterval: mock.surfaceInterval,
            entryAir: mock.entryAir,
            exitAir: mock.exitAir,
            gasType: mock.gasType,
            equipment: mock.equipment,
            maximumDepth: mock.maximumDepth,
            averageDepth: mock.averageDepth,
            airTemperature: mock.airTemperature,
            surfaceTemperature: mock.surfaceTemperature,
            bottomTemperature: mock.bottomTemperature,
            weather: mock.weather,
            surge: mock.surge,
            visibility: mock.visibility,
            visibilityDistance: mock.visibilityDistance,
            feeling: mock.feeling,
            companions: mock.companions,
            notes: "notes",
            insertDate: mock.insertDate
        )
        switch await sut.update(request: updateRequest) {
        case .success:
            break
        case let .failure(error):
            Issue.record(error)
        }

        switch await sut.fetchAll() {
        case let .success(diveLogs):
            if let diveLog = diveLogs.first(where: { $0.logNumber == insertRequest.logNumber }) {
                #expect(diveLog.logDate == Date(timeIntervalSince1970: 13))
                #expect(diveLog.notes == "notes")
            } else {
                Issue.record("No diveLog found.")
            }
        case let .failure(error):
            Issue.record(error)
        }
    }

    @Test
    func fetch() async {
        let insertRequest = DiveLogInsertRequest(
            logNumber: #line,
            logDate: Date(timeIntervalSince1970: 12),
            diveSite: nil,
            diveCenter: nil,
            diveStyle: nil,
            entryTime: nil,
            exitTime: nil,
            surfaceInterval: nil,
            entryAir: nil,
            exitAir: nil,
            gasType: nil,
            equipment: nil,
            maximumDepth: nil,
            averageDepth: nil,
            airTemperature: nil,
            surfaceTemperature: nil,
            bottomTemperature: nil,
            weather: nil,
            surge: nil,
            visibility: nil,
            visibilityDistance: nil,
            feeling: nil,
            companions: [],
            notes: "notes"
        )
        switch await sut.insert(request: insertRequest) {
        case .success:
            break
        case let .failure(error):
            Issue.record(error)
        }

        var mock: DiveLog?
        switch await sut.fetchAll() {
        case let .success(diveLogs):
            if let diveLog = diveLogs.first(where: { $0.logNumber == insertRequest.logNumber }) {
                #expect(diveLog.logDate == Date(timeIntervalSince1970: 12))
                #expect(diveLog.notes == "notes")
                mock = diveLog
            } else {
                Issue.record("No diveLog found.")
            }
        case let .failure(error):
            Issue.record(error)
        }
        guard let mock else {
            Issue.record("No diveLog found.")
            return
        }

        switch await sut.fetch(by: mock.identifier) {
        case let .success(diveLog):
            #expect(diveLog.logNumber == insertRequest.logNumber)
            #expect(diveLog.logDate == insertRequest.logDate)
            #expect(diveLog.notes == insertRequest.notes)
        case let .failure(error):
            Issue.record(error)
        }
    }
}
