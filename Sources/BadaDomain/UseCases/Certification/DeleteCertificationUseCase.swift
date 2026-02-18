//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct DeleteCertificationUseCase: ExecutableUseCase {
    private let delete: @Sendable (CertificationID) async -> Result<Void, CertificationRepositoryError>

    package init(
        _ delete: @Sendable @escaping (CertificationID) async -> Result<Void, CertificationRepositoryError>
    ) {
        self.delete = delete
    }

    package func execute(id: CertificationID) async -> Result<Void, CertificationRepositoryError> {
        await delete(id)
    }
}
