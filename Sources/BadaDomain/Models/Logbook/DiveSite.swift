//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct DiveSite: Equatable {
    package let title: String
    package let subtitle: String
    package let coordinate: Coordinate?

    package init(
        title: String,
        subtitle: String,
        coordinate: Coordinate? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }

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
