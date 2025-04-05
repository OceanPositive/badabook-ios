//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

@Repository
package protocol DiveLogRepositoryType {
    func insert(request: DiveLogInsertRequest) -> Result<Void, DiveLogRepositoryError>
    func fetchAll() -> Result<[DiveLog], DiveLogRepositoryError>
    func fetch(by identifier: DiveLogID) -> Result<DiveLog, DiveLogRepositoryError>
    func update(request: DiveLogUpdateRequest) -> Result<Void, DiveLogRepositoryError>
    func delete(for identifier: DiveLogID) -> Result<Void, DiveLogRepositoryError>
}

package enum DiveLogRepositoryError: Error, Equatable {
    case insertFailed(String)
    case fetchFailed(String)
    case updateFailed(String)
    case deleteFailed(String)
    case noResult
}
