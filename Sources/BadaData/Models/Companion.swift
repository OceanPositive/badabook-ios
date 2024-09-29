//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

enum Companion: Codable {
    case buddy(name: String)
    case guide(name: String, certificationLevel: CertificationLevel)
}

extension Companion: DomainConvertible {
    var domain: BadaDomain.Companion {
        switch self {
        case let .buddy(name):
            return .buddy(name: name)
        case let .guide(name, certificationLevel):
            return .guide(name: name, certificationLevel: certificationLevel.domain)
        }
    }

    init(domain: BadaDomain.Companion) {
        switch domain {
        case let .buddy(name):
            self = .buddy(name: name)
        case let .guide(name, certificationLevel):
            self = .guide(name: name, certificationLevel: CertificationLevel(domain: certificationLevel))
        }
    }
}
