//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import Foundation

package struct Certification: Equatable {
    package let identifier: CertificationID
    package let agency: CertificationAgency
    package let level: CertificationLevel
    package let number: String
    package let date: Date

    package init(
        identifier: CertificationID,
        agency: CertificationAgency,
        level: CertificationLevel,
        number: String,
        date: Date
    ) {
        self.identifier = identifier
        self.agency = agency
        self.level = level
        self.number = number
        self.date = date
    }
}
