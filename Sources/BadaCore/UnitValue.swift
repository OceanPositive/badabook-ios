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

extension UnitValue.Distance {
    package var rawValue: Double {
        switch self {
        case let .km(value):
            return value
        case let .m(value):
            return value
        }
    }
}

extension UnitValue.Pressure {
    package var rawValue: Double {
        switch self {
        case let .bar(value):
            return value
        case let .psi(value):
            return value
        }
    }
}

extension UnitValue.Weight {
    package var rawValue: Double {
        switch self {
        case let .kg(value):
            return value
        case let .lb(value):
            return value
        }
    }
}

extension UnitValue.Time {
    package var rawValue: Double {
        switch self {
        case let .second(value):
            return value
        case let .minute(value):
            return value
        case let .hour(value):
            return value
        case let .day(value):
            return value
        }
    }
}

extension UnitValue.Temperature {
    package var rawValue: Double {
        switch self {
        case let .celsius(value):
            return value
        case let .fahrenheit(value):
            return value
        }
    }
}
