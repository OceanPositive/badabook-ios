//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import SwiftData

@Model
final class CertificationEntity {
    @Attribute(.unique)
    var identifier: CertificationID
    var agency: CertificationAgency
    var level: CertificationLevel
    var number: String
    var date: Date

    init(
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

extension CertificationEntity: DomainConvertible {
    var domain: BadaDomain.Certification {
        BadaDomain.Certification(
            identifier: identifier,
            agency: agency.domain,
            level: level.domain,
            number: number,
            date: date
        )
    }

    convenience init(domain: BadaDomain.Certification) {
        self.init(
            identifier: domain.identifier,
            agency: CertificationAgency(domain: domain.agency),
            level: CertificationLevel(domain: domain.level),
            number: domain.number,
            date: domain.date
        )
    }
}

extension CertificationEntity {
    convenience init(insertRequest: BadaDomain.CertificationInsertRequest) {
        self.init(
            identifier: CertificationID(),
            agency: CertificationAgency(domain: insertRequest.agency),
            level: CertificationLevel(domain: insertRequest.level),
            number: insertRequest.number,
            date: insertRequest.date
        )
    }

    func update(with updateRequest: CertificationUpdateRequest) {
        agency = CertificationAgency(domain: updateRequest.agency)
        level = CertificationLevel(domain: updateRequest.level)
        number = updateRequest.number
        date = updateRequest.date
    }
}
