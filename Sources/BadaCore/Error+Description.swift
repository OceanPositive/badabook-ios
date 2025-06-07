//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import Foundation

extension Error {
    package var description: String {
        "\(localizedDescription): \(self)"
    }
}
