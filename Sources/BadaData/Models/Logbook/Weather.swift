//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

enum Weather: Codable {
    case sunny
    case partlyCloudy
    case cloudy
    case windy
    case rainy
    case snowy
}

extension Weather: DomainConvertible {
    var domain: BadaDomain.Weather {
        switch self {
        case .sunny:
            return .sunny
        case .partlyCloudy:
            return .partlyCloudy
        case .cloudy:
            return .cloudy
        case .windy:
            return .windy
        case .rainy:
            return .rainy
        case .snowy:
            return .snowy
        }
    }

    init(domain: BadaDomain.Weather) {
        switch domain {
        case .sunny:
            self = .sunny
        case .partlyCloudy:
            self = .partlyCloudy
        case .cloudy:
            self = .cloudy
        case .windy:
            self = .windy
        case .rainy:
            self = .rainy
        case .snowy:
            self = .snowy
        }
    }
}
