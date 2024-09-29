//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaUI

struct LogbookListRow: View {
    let item: LogbookRowItem

    var body: some View {
        HStack(spacing: 0) {
            Text("\(item.logNumber)")
            Spacer()
            Text(item.siteName)
        }
    }
}

struct LogbookRowItem: Identifiable, Equatable {
    let id: UUID
    let logNumber: Int
    let siteName: String
}
