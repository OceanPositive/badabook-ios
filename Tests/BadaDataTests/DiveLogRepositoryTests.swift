//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaTesting

@testable import BadaData

struct DiveLogRepositoryTests {
    let sut: DiveLogRepository!

    init() async {
        sut = await DiveLogRepository(persistentStore: PersistentStore.mainTest)
    }

    @Test
    func insert() async {
        let request = DiveLogInsertRequest(
            logNumber: 0,
            logDate: Date(timeIntervalSince1970: 0),
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

        switch await sut.diveLogs() {
        case let .success(diveLogs):
            #expect(diveLogs.count == 1)
            if let diveLog = diveLogs.first {
                #expect(diveLog.logNumber == request.logNumber)
                #expect(diveLog.logDate == request.logDate)
            }
        case let .failure(error):
            Issue.record(error)
        }
    }
}
