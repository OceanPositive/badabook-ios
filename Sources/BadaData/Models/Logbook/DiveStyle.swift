//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

enum DiveStyle: Codable {
    case boat
    case beach
    case night
    case sideMount
    case doubleTank
    case dpv
    case wreck
    case training
}

extension DiveStyle: DomainConvertible {
    var domain: BadaDomain.DiveStyle {
        switch self {
        case .boat:
            return .boat
        case .beach:
            return .beach
        case .night:
            return .night
        case .sideMount:
            return .sideMount
        case .doubleTank:
            return .doubleTank
        case .dpv:
            return .dpv
        case .wreck:
            return .wreck
        case .training:
            return .training
        }
    }

    init(domain: BadaDomain.DiveStyle) {
        switch domain {
        case .boat:
            self = .boat
        case .beach:
            self = .beach
        case .night:
            self = .night
        case .sideMount:
            self = .sideMount
        case .doubleTank:
            self = .doubleTank
        case .dpv:
            self = .dpv
        case .wreck:
            self = .wreck
        case .training:
            self = .training
        }
    }
}
