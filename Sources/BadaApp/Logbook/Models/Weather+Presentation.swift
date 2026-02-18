//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaUI

extension Weather {
    static var allCases: [Weather] {
        [
            .sunny,
            .partlyCloudy,
            .cloudy,
            .windy,
            .rainy,
            .snowy,
        ]
    }

    var description: String {
        switch self {
        case .sunny: return L10n.Logbook.Weather.sunny
        case .partlyCloudy: return L10n.Logbook.Weather.partlyCloudy
        case .cloudy: return L10n.Logbook.Weather.cloudy
        case .windy: return L10n.Logbook.Weather.windy
        case .rainy: return L10n.Logbook.Weather.rainy
        case .snowy: return L10n.Logbook.Weather.snowy
        }
    }

    var icon: SystemImage {
        switch self {
        case .sunny: return .sunMax
        case .partlyCloudy: return .cloudSun
        case .cloudy: return .cloud
        case .windy: return .wind
        case .rainy: return .cloudRain
        case .snowy: return .cloudSnow
        }
    }
}
