//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

package enum UnitValue {
    package enum Distance: Equatable {
        case km(Double)
        case m(Double)
    }

    package enum Pressure: Equatable {
        case bar(Double)
        case psi(Double)
    }

    package enum Weight: Equatable {
        case kg(Double)
        case lb(Double)
    }

    package enum Time: Equatable {
        case second(Double)
        case minute(Double)
        case hour(Double)
        case day(Double)
    }

    package enum Temperature: Equatable {
        case celsius(Double)
        case fahrenheit(Double)
    }
}
