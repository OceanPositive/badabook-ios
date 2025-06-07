//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct CertificationInsertRequest: Equatable {
    package let agency: CertificationAgency
    package let level: CertificationLevel
    package let number: String
    package let date: Date

    package init(
        agency: CertificationAgency,
        level: CertificationLevel,
        number: String,
        date: Date
    ) {
        self.agency = agency
        self.level = level
        self.number = number
        self.date = date
    }
}
