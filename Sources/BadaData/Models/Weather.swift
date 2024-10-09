//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

enum Weather: Codable {
    case sunny
    case partlyCloudy
    case cloudy
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
        case .rainy:
            self = .rainy
        case .snowy:
            self = .snowy
        }
    }
}