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
        let request = DiveLogInsertRequest(logNumber: 0)

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
                #expect(DiveLogInsertRequest(diveLog: diveLog) == request)
            }
        case let .failure(error):
            Issue.record(error)
        }
    }
}
