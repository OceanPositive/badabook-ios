//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct DeleteDiveLogUseCase: ExecutableUseCase {
    private let delete: @Sendable (DiveLogID) async -> Result<Void, DiveLogRepositoryError>

    package init(
        _ delete: @Sendable @escaping (DiveLogID) async -> Result<Void, DiveLogRepositoryError>
    ) {
        self.delete = delete
    }

    package func execute(id: DiveLogID) async -> Result<Void, DiveLogRepositoryError> {
        await delete(id)
    }
}
