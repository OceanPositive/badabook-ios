//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import Foundation

package struct GetDiveLogsUseCase {
    private let diveLogs: () -> Result<[DiveLog], DiveLogRepositoryError>

    package init(
        diveLogs: @escaping () -> Result<[DiveLog], DiveLogRepositoryError>
    ) {
        self.diveLogs = diveLogs
    }

    package func execute() -> Result<[DiveLog], DiveLogRepositoryError> {
        diveLogs()
    }
}
