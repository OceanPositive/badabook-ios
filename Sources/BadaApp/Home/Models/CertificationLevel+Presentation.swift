//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaDomain

extension CertificationLevel {
    static var allCases: [CertificationLevel] {
        [
            .openWater,
            .advancedOpenWater,
            .rescueDiver,
            .diveMaster,
            .instructor,
            .instructorTrainer,
        ]
    }

    var description: String {
        switch self {
        case .openWater:
            "Open Water"
        case .advancedOpenWater:
            "Advanced Open Water"
        case .rescueDiver:
            "Rescue Diver"
        case .diveMaster:
            "Dive Master"
        case .instructor:
            "Instructor"
        case .instructorTrainer:
            "Instructor Trainer"
        }
    }
}
