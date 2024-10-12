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
    let country: String
    let siteName: String
    let diveCenter: String?

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
            country: country,
            siteName: siteName,
            diveCenter: diveCenter
        )
    }

    init(domain: BadaDomain.DiveSite) {
        self.coordinate = domain.coordinate.map {
            DiveSite.Coordinate(
                latitude: $0.latitude,
                longitude: $0.longitude
            )
        }
        self.country = domain.country
        self.siteName = domain.siteName
        self.diveCenter = domain.diveCenter
    }
}
