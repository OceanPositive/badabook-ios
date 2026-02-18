//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct LocalSearchResult: Equatable {
    package let title: String
    package let subtitle: String
    package let coordinate: Coordinate?

    package init(
        title: String,
        subtitle: String,
        coordinate: Coordinate?
    ) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}

extension LocalSearchResult {
    package struct Coordinate: Equatable {
        package let latitude: Double
        package let longitude: Double

        package init(
            latitude: Double,
            longitude: Double
        ) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }
}
