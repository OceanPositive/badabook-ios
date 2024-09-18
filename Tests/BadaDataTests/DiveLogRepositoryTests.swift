//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import Testing

@testable import BadaData

struct DiveLogRepositoryTests {
    let sut: DiveLogRepository!

    init() async {
        sut = await DiveLogRepository(persistentStore: PersistentStore.mainTest)
    }

    @Test
    func insert() async {
        let diveLog = DiveLog(
            location: DiveLog.Location(
                latitude: 1,
                longitude: 2,
                siteName: "siteName1",
                country: "country1"
            ),
            entryTime: Date(timeIntervalSince1970: 100),
            exitTime: Date(timeIntervalSince1970: 200),
            depth: 10,
            duration: 20,
            waterTemperature: 30,
            visibility: 40,
            airConsumption: 50,
            diveBuddy: "diveBuddy1",
            diveType: "diveType1",
            notes: "notes1"
        )

        switch await sut.insert(diveLog: diveLog) {
        case .success:
            break
        case let .failure(error):
            Issue.record(error)
        }

        switch await sut.diveLogs() {
        case let .success(diveLogs):
            #expect(diveLogs.count == 1)
            #expect(diveLogs.first == diveLog)
        case let .failure(error):
            Issue.record(error)
        }
    }
}
