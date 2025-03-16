//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

enum CertificationAgency: Codable {
    case padi
    case naui
    case scubapro
    case sdi
    case tdi
    case ssi
}

extension CertificationAgency: DomainConvertible {
    var domain: BadaDomain.CertificationAgency {
        switch self {
        case .padi:
            return .padi
        case .naui:
            return .naui
        case .scubapro:
            return .scubapro
        case .sdi:
            return .sdi
        case .tdi:
            return .tdi
        case .ssi:
            return .ssi
        }
    }

    init(domain: BadaDomain.CertificationAgency) {
        switch domain {
        case .padi:
            self = .padi
        case .naui:
            self = .naui
        case .scubapro:
            self = .scubapro
        case .sdi:
            self = .sdi
        case .tdi:
            self = .tdi
        case .ssi:
            self = .ssi
        }
    }
}
