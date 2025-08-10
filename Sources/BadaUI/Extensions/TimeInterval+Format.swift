//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import Foundation

extension TimeInterval {
    package func formattedExperience() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.year, .month, .day]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: self) ?? "-"
    }

    package func formattedDiveTime() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: self) ?? "-"
    }
}
