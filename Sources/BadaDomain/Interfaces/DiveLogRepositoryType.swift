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
    func diveLogs() -> Result<[DiveLog], DiveLogRepositoryError>
}

package enum DiveLogRepositoryError: Error {
    case insertFailed(String)
    case fetchFailed(String)
    case noResult
}
