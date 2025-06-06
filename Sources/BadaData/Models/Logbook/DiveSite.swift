//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

struct DiveSite: Codable {
    let title: String
    let subtitle: String
    let coordinate: SafeCodableOptional<Coordinate>

    struct Coordinate: Codable {
        let latitude: Double
        let longitude: Double
    }
}

extension DiveSite: DomainConvertible {
    var domain: BadaDomain.DiveSite {
        BadaDomain.DiveSite(
            title: title,
            subtitle: subtitle,
            coordinate: coordinate.optional.map {
                BadaDomain.DiveSite.Coordinate(
                    latitude: $0.latitude,
                    longitude: $0.longitude
                )
            }
        )
    }

    init(domain: BadaDomain.DiveSite) {
        self.title = domain.title
        self.subtitle = domain.subtitle
        self.coordinate = domain.coordinate.map {
            DiveSite.Coordinate(
                latitude: $0.latitude,
                longitude: $0.longitude
            )
        }.safeCodableOptional
    }
}
