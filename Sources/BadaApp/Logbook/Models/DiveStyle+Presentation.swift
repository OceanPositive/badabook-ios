//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

extension DiveStyle {
    static var allCases: [DiveStyle] {
        [
            .boat,
            .beach,
            .night,
            .sideMount,
            .doubleTank,
            .dpv,
            .wreck,
            .training,
        ]
    }

    var description: String {
        switch self {
        case .boat: return L10n.DiveStyle.boat
        case .beach: return L10n.DiveStyle.beach
        case .night: return L10n.DiveStyle.night
        case .sideMount: return L10n.DiveStyle.sideMount
        case .doubleTank: return L10n.DiveStyle.doubleTank
        case .dpv: return L10n.DiveStyle.dpv
        case .wreck: return L10n.DiveStyle.wreck
        case .training: return L10n.DiveStyle.training
        }
    }
}
