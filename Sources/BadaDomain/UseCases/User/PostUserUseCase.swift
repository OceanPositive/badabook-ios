//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct PostUserUseCase: ExecutableUseCase {
    private let post: @Sendable (UserInsertRequest) async -> Result<Void, UserRepositoryError>

    package init(
        _ post: @Sendable @escaping (UserInsertRequest) async -> Result<Void, UserRepositoryError>
    ) {
        self.post = post
    }

    package func execute(for request: UserInsertRequest) async -> Result<Void, UserRepositoryError> {
        await post(request)
    }
}
