//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct UserUpdateRequest: Equatable {
    package let identifier: UserID
    package let name: String
    package let dateOfBirth: Date

    package init(
        identifier: UserID,
        name: String,
        dateOfBirth: Date
    ) {
        self.identifier = identifier
        self.name = name
        self.dateOfBirth = dateOfBirth
    }
}
