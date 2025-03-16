//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct PostCertificationUseCase: ExecutableUseCase {
    private let post: @Sendable (CertificationInsertRequest) async -> Result<Void, CertificationRepositoryError>

    package init(
        _ post: @Sendable @escaping (CertificationInsertRequest) async -> Result<Void, CertificationRepositoryError>
    ) {
        self.post = post
    }

    package func execute(for request: CertificationInsertRequest) async -> Result<Void, CertificationRepositoryError> {
        await post(request)
    }
}
