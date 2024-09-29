//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

struct Equipment: Codable {
    let suit: Suit?
    let bcd: BCD?
    let weight: UnitValue.Weight?
}

extension Equipment {
    enum Suit: Codable {
        case wet3mm
        case wet5mm
        case wet7mm
        case dry
        case semiDry
        case shorty
    }

    enum BCD: Codable {
        case jacket
        case backplate
        case hybrid
        case sidemount
    }
}

extension Equipment: DomainConvertible {
    var domain: BadaDomain.Equipment {
        BadaDomain.Equipment(
            suit: suit?.domain,
            bcd: bcd?.domain,
            weight: weight
        )
    }

    init(domain: BadaDomain.Equipment) {
        self.suit = domain.suit.map { Suit(domain: $0) }
        self.bcd = domain.bcd.map { BCD(domain: $0) }
        self.weight = domain.weight
    }
}

extension Equipment.Suit: DomainConvertible {
    var domain: BadaDomain.Equipment.Suit {
        switch self {
        case .wet3mm:
            return .wet3mm
        case .wet5mm:
            return .wet5mm
        case .wet7mm:
            return .wet7mm
        case .dry:
            return .dry
        case .semiDry:
            return .semiDry
        case .shorty:
            return .shorty
        }
    }

    init(domain: BadaDomain.Equipment.Suit) {
        switch domain {
        case .wet3mm:
            self = .wet3mm
        case .wet5mm:
            self = .wet5mm
        case .wet7mm:
            self = .wet7mm
        case .dry:
            self = .dry
        case .semiDry:
            self = .semiDry
        case .shorty:
            self = .shorty
        }
    }
}

extension Equipment.BCD: DomainConvertible {
    var domain: BadaDomain.Equipment.BCD {
        switch self {
        case .jacket:
            return .jacket
        case .backplate:
            return .backplate
        case .hybrid:
            return .hybrid
        case .sidemount:
            return .sidemount
        }
    }

    init(domain: BadaDomain.Equipment.BCD) {
        switch domain {
        case .jacket:
            self = .jacket
        case .backplate:
            self = .backplate
        case .hybrid:
            self = .hybrid
        case .sidemount:
            self = .sidemount
        }
    }
}
