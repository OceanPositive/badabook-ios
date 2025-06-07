//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct GetCertificationUseCase: ExecutableUseCase {
    private let get: @Sendable (CertificationID) async -> Result<Certification, CertificationRepositoryError>

    package init(
        _ get: @Sendable @escaping (CertificationID) async -> Result<Certification, CertificationRepositoryError>
    ) {
        self.get = get
    }

    package func execute(id: CertificationID) async -> Result<Certification, CertificationRepositoryError> {
        await get(id)
    }
}
