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
    case number = "number"
    case personTextRectangle = "person.text.rectangle"
    case stopwatch = "stopwatch"
    case calendar = "calendar"
    case plus = "plus"
}

extension Image {
    package init(systemImage: SystemImage) {
        self.init(systemName: systemImage.rawValue)
    }
}
