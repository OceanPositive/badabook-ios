//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

enum Surge: Codable {
    case light
    case medium
    case strong
}

extension Surge: DomainConvertible {
    var domain: BadaDomain.Surge {
        switch self {
        case .light:
            return .light
        case .medium:
            return .medium
        case .strong:
            return .strong
        }
    }

    init(domain: BadaDomain.Surge) {
        switch domain {
        case .light:
            self = .light
        case .medium:
            self = .medium
        case .strong:
            self = .strong
        }
    }
}
