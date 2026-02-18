//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

enum CertificationLevel: Codable {
    case openWater
    case advancedOpenWater
    case rescueDiver
    case diveMaster
    case instructor
    case instructorTrainer
}

extension CertificationLevel: DomainConvertible {
    var domain: BadaDomain.CertificationLevel {
        switch self {
        case .openWater:
            return .openWater
        case .advancedOpenWater:
            return .advancedOpenWater
        case .rescueDiver:
            return .rescueDiver
        case .diveMaster:
            return .diveMaster
        case .instructor:
            return .instructor
        case .instructorTrainer:
            return .instructorTrainer
        }
    }

    init(domain: BadaDomain.CertificationLevel) {
        switch domain {
        case .openWater:
            self = .openWater
        case .advancedOpenWater:
            self = .advancedOpenWater
        case .rescueDiver:
            self = .rescueDiver
        case .diveMaster:
            self = .diveMaster
        case .instructor:
            self = .instructor
        case .instructorTrainer:
            self = .instructorTrainer
        }
    }
}
