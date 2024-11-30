//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct GetDiveLogUseCase: ExecutableUseCase {
    private let get: @Sendable (DiveLogID) async -> Result<DiveLog, DiveLogRepositoryError>

    package init(
        _ get: @Sendable @escaping (DiveLogID) async -> Result<DiveLog, DiveLogRepositoryError>
    ) {
        self.get = get
    }

    package func execute(id: DiveLogID) async -> Result<DiveLog, DiveLogRepositoryError> {
        await get(id)
    }
}
