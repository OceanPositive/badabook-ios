//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct PutUserUseCase: ExecutableUseCase {
    private let put: @Sendable (UserUpdateRequest) async -> Result<Void, UserRepositoryError>

    package init(
        _ put: @Sendable @escaping (UserUpdateRequest) async -> Result<Void, UserRepositoryError>
    ) {
        self.put = put
    }

    package func execute(for request: UserUpdateRequest) async -> Result<Void, UserRepositoryError> {
        await put(request)
    }
}
