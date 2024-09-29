//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import Foundation

package enum UnitValue {
    package enum Distance: Equatable, Codable {
        case km(Double)
        case m(Double)
    }

    package enum Pressure: Equatable, Codable {
        case bar(Double)
        case psi(Double)
    }

    package enum Weight: Equatable, Codable {
        case kg(Double)
        case lb(Double)
    }

    package enum Time: Equatable, Codable {
        case second(Double)
        case minute(Double)
        case hour(Double)
        case day(Double)
    }

    package enum Temperature: Equatable, Codable {
        case celsius(Double)
        case fahrenheit(Double)
    }
}
