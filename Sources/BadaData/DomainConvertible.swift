//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import Foundation

protocol DomainConvertible {
    associatedtype DomainType

    var domain: DomainType { get }
    init(domain: DomainType)
}
