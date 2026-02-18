//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct PutDiveLogUseCase: ExecutableUseCase {
    private let put: @Sendable (DiveLogUpdateRequest) async -> Result<Void, DiveLogRepositoryError>

    package init(
        _ put: @Sendable @escaping (DiveLogUpdateRequest) async -> Result<Void, DiveLogRepositoryError>
    ) {
        self.put = put
    }

    package func execute(for request: DiveLogUpdateRequest) async -> Result<Void, DiveLogRepositoryError> {
        await put(request)
    }
}
