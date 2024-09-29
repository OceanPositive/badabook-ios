//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

enum Visibility: Codable {
    case good
    case fair
    case bad
}

extension Visibility: DomainConvertible {
    var domain: BadaDomain.Visibility {
        switch self {
        case .good:
            return .good
        case .fair:
            return .fair
        case .bad:
            return .bad
        }
    }

    init(domain: BadaDomain.Visibility) {
        switch domain {
        case .good:
            self = .good
        case .fair:
            self = .fair
        case .bad:
            self = .bad
        }
    }
}
