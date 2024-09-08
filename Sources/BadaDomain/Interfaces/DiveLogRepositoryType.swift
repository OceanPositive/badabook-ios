import Foundation

package protocol DiveLogRepositoryType {
    func insert(diveLog: DiveLog) -> Result<Void, DiveLogRepositoryError>
    func diveLogs() -> Result<[DiveLog], DiveLogRepositoryError>
}

package enum DiveLogRepositoryError: Error {
    case fetchFailed(String)
    case insertFailed(String)
}
