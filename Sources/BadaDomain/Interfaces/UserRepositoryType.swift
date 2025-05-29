//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

@Repository
package protocol UserRepositoryType {
    func insert(request: UserInsertRequest) -> Result<Void, UserRepositoryError>
    func fetch() -> Result<User, UserRepositoryError>
    func update(request: UserUpdateRequest) -> Result<Void, UserRepositoryError>
}

package enum UserRepositoryError: Error, Equatable {
    case insertFailed(String)
    case fetchFailed(String)
    case updateFailed(String)
    case noResult
}
