//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct UserInsertRequest: Equatable {
    package let name: String
    package let birthDate: Date

    package init(
        name: String,
        birthDate: Date
    ) {
        self.name = name
        self.birthDate = birthDate
    }
}
