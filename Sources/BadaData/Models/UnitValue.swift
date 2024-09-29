//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

enum UnitValue {
    enum Distance: Codable {
        case km(Double)
        case m(Double)
    }

    enum Pressure: Codable {
        case bar(Double)
        case psi(Double)
    }

    enum Weight: Codable {
        case kg(Double)
        case lb(Double)
    }

    enum Time: Codable {
        case second(Double)
        case minute(Double)
        case hour(Double)
        case day(Double)
    }

    enum Temperature: Codable {
        case celsius(Double)
        case fahrenheit(Double)
    }
}

extension UnitValue.Distance: DomainConvertible {
    var domain: BadaDomain.UnitValue.Distance {
        switch self {
        case let .km(value):
            return .km(value)
        case let .m(value):
            return .m(value)
        }
    }

    init(domain: BadaDomain.UnitValue.Distance) {
        switch domain {
        case let .km(value):
            self = .km(value)
        case let .m(value):
            self = .m(value)
        }
    }
}

extension UnitValue.Pressure: DomainConvertible {
    var domain: BadaDomain.UnitValue.Pressure {
        switch self {
        case let .bar(value):
            return .bar(value)
        case let .psi(value):
            return .psi(value)
        }
    }

    init(domain: BadaDomain.UnitValue.Pressure) {
        switch domain {
        case let .bar(value):
            self = .bar(value)
        case let .psi(value):
            self = .psi(value)
        }
    }
}

extension UnitValue.Weight: DomainConvertible {
    var domain: BadaDomain.UnitValue.Weight {
        switch self {
        case let .kg(value):
            return .kg(value)
        case let .lb(value):
            return .lb(value)
        }
    }

    init(domain: BadaDomain.UnitValue.Weight) {
        switch domain {
        case let .kg(value):
            self = .kg(value)
        case let .lb(value):
            self = .lb(value)
        }
    }
}

extension UnitValue.Time: DomainConvertible {
    var domain: BadaDomain.UnitValue.Time {
        switch self {
        case let .second(value):
            return .second(value)
        case let .minute(value):
            return .minute(value)
        case let .hour(value):
            return .hour(value)
        case let .day(value):
            return .day(value)
        }
    }

    init(domain: BadaDomain.UnitValue.Time) {
        switch domain {
        case let .second(value):
            self = .second(value)
        case let .minute(value):
            self = .minute(value)
        case let .hour(value):
            self = .hour(value)
        case let .day(value):
            self = .day(value)
        }
    }
}

extension UnitValue.Temperature: DomainConvertible {
    var domain: BadaDomain.UnitValue.Temperature {
        switch self {
        case let .celsius(value):
            return .celsius(value)
        case let .fahrenheit(value):
            return .fahrenheit(value)
        }
    }

    init(domain: BadaDomain.UnitValue.Temperature) {
        switch domain {
        case let .celsius(value):
            self = .celsius(value)
        case let .fahrenheit(value):
            self = .fahrenheit(value)
        }
    }
}
