//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

@Repository
package protocol DiveLogRepositoryType {
    func insert(diveLog: DiveLog) -> Result<Void, DiveLogRepositoryError>
    func diveLogs() -> Result<[DiveLog], DiveLogRepositoryError>
}

package enum DiveLogRepositoryError: Error {
    case fetchFailed(String)
    case insertFailed(String)
}
