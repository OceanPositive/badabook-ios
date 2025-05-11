//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import Foundation

extension Date {
    package func formattedDaysAgo() -> String {
        var formatStyle = Date.RelativeFormatStyle()
        formatStyle.presentation = .numeric
        formatStyle.unitsStyle = .wide
        return formatted(formatStyle)
    }
}
