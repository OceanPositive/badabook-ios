//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct GetUserUseCase: ExecutableUseCase {
    private let get: @Sendable () async -> Result<User, UserRepositoryError>

    package init(
        _ get: @Sendable @escaping () async -> Result<User, UserRepositoryError>
    ) {
        self.get = get
    }

    package func execute() async -> Result<User, UserRepositoryError> {
        await get()
    }
}
