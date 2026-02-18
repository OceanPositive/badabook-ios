//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import Foundation

package struct User: Equatable {
    package let identifier: UserID
    package let name: String?
    package let dateOfBirth: Date?
    package let insertDate: Date
    package let updateDate: Date

    package init(
        identifier: UserID,
        name: String?,
        dateOfBirth: Date?,
        insertDate: Date,
        updateDate: Date
    ) {
        self.identifier = identifier
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.insertDate = insertDate
        self.updateDate = updateDate
    }
}
