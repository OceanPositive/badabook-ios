//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct PostDiveLogUseCase: ExecutableUseCase {
    private let post: @Sendable (DiveLogInsertRequest) async -> Result<Void, DiveLogRepositoryError>

    package init(
        _ post: @Sendable @escaping (DiveLogInsertRequest) async -> Result<Void, DiveLogRepositoryError>
    ) {
        self.post = post
    }

    package func execute(request: DiveLogInsertRequest) async -> Result<Void, DiveLogRepositoryError> {
        await post(request)
    }
}
