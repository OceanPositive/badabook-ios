//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct UserInsertRequest: Equatable {
    package let name: String
    package let dateOfBirth: Date

    package init(
        name: String,
        dateOfBirth: Date
    ) {
        self.name = name
        self.dateOfBirth = dateOfBirth
    }
}
