import XCTest
import BadaDomain
@testable import BadaData

final class DiveLogRepositoryTests: XCTestCase {
    var sut: DiveLogRepository!

    override func setUp() async throws {
        sut = await DiveLogRepository(persistentStore: PersistentStore.mainTest)
    }

    func test_insert() async {
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
            XCTAssert(true)
        case let .failure(error):
            XCTFail(error.localizedDescription)
        }

        switch await sut.diveLogs() {
        case let .success(diveLogs):
            XCTAssertEqual(diveLogs.count, 1)
            XCTAssertEqual(diveLogs.first!, diveLog)
        case let .failure(error):
            XCTFail(error.localizedDescription)
        }
    }
}
