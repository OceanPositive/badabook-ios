//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import MapKit

package struct LocalSearchCompletion: Equatable, @unchecked Sendable {
    package let title: String
    package let subtitle: String
    package let rawValue: MKLocalSearchCompletion?

    package init(
        title: String,
        subtitle: String,
        rawValue: MKLocalSearchCompletion?
    ) {
        self.title = title
        self.subtitle = subtitle
        self.rawValue = rawValue
    }
}
