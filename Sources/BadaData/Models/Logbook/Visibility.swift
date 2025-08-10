//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

enum Visibility: Codable {
    case high
    case average
    case low
}

extension Visibility: DomainConvertible {
    var domain: BadaDomain.Visibility {
        switch self {
        case .high:
            return .high
        case .average:
            return .average
        case .low:
            return .low
        }
    }

    init(domain: BadaDomain.Visibility) {
        switch domain {
        case .high:
            self = .high
        case .average:
            self = .average
        case .low:
            self = .low
        }
    }
}
