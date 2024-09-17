//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import SwiftUI

package enum SystemImage: String {
    case house = "house"
    case doorSlidingRightHandClosed = "door.sliding.right.hand.closed"
    case bookPages = "book.pages"
}

extension Image {
    package init(systemImage: SystemImage) {
        self.init(systemName: systemImage.rawValue)
    }
}
