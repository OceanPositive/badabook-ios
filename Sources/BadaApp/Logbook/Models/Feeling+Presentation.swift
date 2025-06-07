//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaDomain

extension Feeling {
    static var allCases: [Feeling] {
        [
            .amazing,
            .good,
            .average,
            .poor,
        ]
    }

    var description: String {
        switch self {
        case .amazing: return "😍 Amazing"
        case .good: return "😆 Good"
        case .average: return "😐 Average"
        case .poor: return "😥 Poor"
        }
    }
}
