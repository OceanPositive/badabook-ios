//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
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
    case chevronUp = "chevron.up"
    case chevronDown = "chevron.down"
    case chevronRight = "chevron.right"
    case sunMax = "sun.max"
    case cloud = "cloud"
    case cloudSun = "cloud.sun"
    case wind = "wind"
    case cloudRain = "cloud.rain"
    case cloudSnow = "cloud.snow"
    case location = "location"
    case trash = "trash"
    case plusSquareOnSquare = "plus.square.on.square"
    case minusSquare = "minus.square"
    case magnifyingglass = "magnifyingglass"
}

extension Image {
    package init(systemImage: SystemImage) {
        self.init(systemName: systemImage.rawValue)
    }
}
