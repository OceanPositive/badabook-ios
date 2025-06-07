//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import Foundation

/// A codable wrapper to safely represent optional values in SwiftData.
///
/// In SwiftData, directly using an optional `Codable` property can lead to a crash during decoding.
/// This type avoids that issue by explicitly encoding and decoding the presence or absence of a
/// value.
package enum SafeCodableOptional<Wrapped: Codable>: Codable {
    case some(Wrapped)
    case none
}

extension SafeCodableOptional {
    package var optional: Wrapped? {
        switch self {
        case let .some(value):
            return .some(value)
        case .none:
            return .none
        }
    }
}

extension Optional where Wrapped: Codable {
    package var safeCodableOptional: SafeCodableOptional<Wrapped> {
        switch self {
        case let .some(value):
            return .some(value)
        case .none:
            return .none
        }
    }
}
