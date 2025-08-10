//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

enum DiveGasType: Codable {
    case air
    case nitrox(oxygenPercentage: Int)
}

extension DiveGasType: DomainConvertible {
    var domain: BadaDomain.DiveGasType {
        switch self {
        case .air:
            return .air
        case let .nitrox(oxygenPercentage):
            return .nitrox(oxygenPercentage: oxygenPercentage)
        }
    }

    init(domain: BadaDomain.DiveGasType) {
        switch domain {
        case .air:
            self = .air
        case let .nitrox(oxygenPercentage):
            self = .nitrox(oxygenPercentage: oxygenPercentage)
        }
    }
}
