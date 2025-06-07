//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct GetCertificationsUseCase: ExecutableUseCase {
    private let get: @Sendable () async -> Result<[Certification], CertificationRepositoryError>

    package init(
        _ get: @Sendable @escaping () async -> Result<[Certification], CertificationRepositoryError>
    ) {
        self.get = get
    }

    package func execute() async -> Result<[Certification], CertificationRepositoryError> {
        await get()
    }
}
