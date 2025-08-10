//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct PutCertificationUseCase: ExecutableUseCase {
    private let put: @Sendable (CertificationUpdateRequest) async -> Result<Void, CertificationRepositoryError>

    package init(
        _ put: @Sendable @escaping (CertificationUpdateRequest) async -> Result<Void, CertificationRepositoryError>
    ) {
        self.put = put
    }

    package func execute(for request: CertificationUpdateRequest) async -> Result<Void, CertificationRepositoryError> {
        await put(request)
    }
}
