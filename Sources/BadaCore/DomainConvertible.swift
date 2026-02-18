//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import Foundation

package protocol DomainConvertible {
    associatedtype DomainType

    var domain: DomainType { get }
    init(domain: DomainType)
}
