//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

enum Feeling: Codable {
    case amazing
    case good
    case average
    case poor
}

extension Feeling: DomainConvertible {
    var domain: BadaDomain.Feeling {
        switch self {
        case .amazing:
            return .amazing
        case .good:
            return .good
        case .average:
            return .average
        case .poor:
            return .poor
        }
    }

    init(domain: BadaDomain.Feeling) {
        switch domain {
        case .amazing:
            self = .amazing
        case .good:
            self = .good
        case .average:
            self = .average
        case .poor:
            self = .poor
        }
    }
}
