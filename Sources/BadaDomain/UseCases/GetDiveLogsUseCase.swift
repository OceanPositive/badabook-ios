//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct GetDiveLogsUseCase: ExecutableUseCase {
    private let get: @Sendable () async -> Result<[DiveLog], DiveLogRepositoryError>

    package init(
        _ get: @Sendable @escaping () async -> Result<[DiveLog], DiveLogRepositoryError>
    ) {
        self.get = get
    }

    package func execute() async -> Result<[DiveLog], DiveLogRepositoryError> {
        await get()
    }
}
