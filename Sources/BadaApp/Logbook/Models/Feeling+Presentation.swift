//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
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
        case .amazing: return "😍 \(L10n.Logbook.Feeling.amazing)"
        case .good: return "😆 \(L10n.Logbook.Feeling.good)"
        case .average: return "😐 \(L10n.Logbook.Feeling.average)"
        case .poor: return "😥 \(L10n.Logbook.Feeling.poor)"
        }
    }
}
