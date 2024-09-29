//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

struct DiveSite: Codable {
    let coordinate: Coordinate?
    let siteName: String
    let country: String

    struct Coordinate: Codable {
        let latitude: Double
        let longitude: Double
    }
}

extension DiveSite: DomainConvertible {
    var domain: BadaDomain.DiveSite {
        BadaDomain.DiveSite(
            coordinate: coordinate.map {
                BadaDomain.DiveSite.Coordinate(
                    latitude: $0.latitude,
                    longitude: $0.longitude
                )
            },
            siteName: siteName,
            country: country
        )
    }

    init(domain: BadaDomain.DiveSite) {
        self.coordinate = domain.coordinate.map {
            DiveSite.Coordinate(
                latitude: $0.latitude,
                longitude: $0.longitude
            )
        }
        self.siteName = domain.siteName
        self.country = domain.country
    }
}
