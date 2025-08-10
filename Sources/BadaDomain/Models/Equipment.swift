//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct Equipment: Equatable {
    package let suit: Suit?
    package let bcd: BCD?
    package let weight: UnitValue.Weight?

    package init(
        suit: Suit? = nil,
        bcd: BCD? = nil,
        weight: UnitValue.Weight? = nil
    ) {
        self.suit = suit
        self.bcd = bcd
        self.weight = weight
    }
}

extension Equipment {
    package enum Suit {
        case wet3mm
        case wet5mm
        case wet7mm
        case dry
        case semiDry
        case shorty
    }

    package enum BCD {
        case jacket
        case backplate
        case hybrid
        case sidemount
    }
}
