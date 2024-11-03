//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

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
        case .sunny: return "Sunny"
        case .partlyCloudy: return "Partly Cloudy"
        case .cloudy: return "Cloudy"
        case .windy: return "Windy"
        case .rainy: return "Rainy"
        case .snowy: return "Snowy"
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
