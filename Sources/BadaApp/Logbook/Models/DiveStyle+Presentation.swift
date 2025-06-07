//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

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
        case .boat: return "Boat"
        case .beach: return "Beach"
        case .night: return "Night"
        case .sideMount: return "Side Mount"
        case .doubleTank: return "Double Tank"
        case .dpv: return "DPV"
        case .wreck: return "Wreck"
        case .training: return "Training"
        }
    }
}
