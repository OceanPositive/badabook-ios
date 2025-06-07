//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaDomain

extension CertificationAgency {
    static var allCases: [CertificationAgency] {
        [
            .padi,
            .naui,
            .scubapro,
            .sdi,
            .tdi,
            .ssi,
        ]
    }

    var description: String {
        switch self {
        case .padi:
            "PADI"
        case .naui:
            "NAUI"
        case .scubapro:
            "SCUBAPRO"
        case .sdi:
            "SDI"
        case .tdi:
            "TDI"
        case .ssi:
            "SSI"
        }
    }
}
