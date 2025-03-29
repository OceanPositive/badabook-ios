//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct GetUserUseCase: ExecutableUseCase {
    private let get: @Sendable (UserID) async -> Result<User, UserRepositoryError>

    package init(
        _ get: @Sendable @escaping (UserID) async -> Result<User, UserRepositoryError>
    ) {
        self.get = get
    }

    package func execute(id: UserID) async -> Result<User, UserRepositoryError> {
        await get(id)
    }
}
