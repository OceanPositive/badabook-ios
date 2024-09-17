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
