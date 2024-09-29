//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct DiveSite: Equatable {
    package let coordinate: Coordinate?
    package let siteName: String
    package let country: String

    package init(
        coordinate: Coordinate? = nil,
        siteName: String,
        country: String
    ) {
        self.coordinate = coordinate
        self.siteName = siteName
        self.country = country
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
