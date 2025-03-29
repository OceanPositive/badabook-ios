//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct UserUpdateRequest: Equatable {
    package let identifier: UserID
    package let name: String
    package let birthDate: Date

    package init(
        identifier: UserID,
        name: String,
        birthDate: Date
    ) {
        self.identifier = identifier
        self.name = name
        self.birthDate = birthDate
    }
}
