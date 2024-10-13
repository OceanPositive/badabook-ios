//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

package struct LocalSearchResult: Equatable {
    package let title: String
    package let subtitle: String

    package init(
        title: String,
        subtitle: String
    ) {
        self.title = title
        self.subtitle = subtitle
    }
}
