//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaUI

struct LogbookListRow: View {
    let item: LogbookListRowItem

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 0) {
                Text(item.logNumberText)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text(item.maximumDepthText ?? "")
                        .font(.callout)
                        .foregroundStyle(.primary)
                    Text(item.totalTimeText ?? "")
                        .font(.callout)
                        .foregroundStyle(.primary)
                }
            }
            HStack(spacing: 0) {
                if let diveSiteText = item.diveSiteText {
                    HStack(spacing: 2) {
                        Image(systemImage: .location)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(diveSiteText)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                Spacer()
                Text(item.logDateText ?? "")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .padding([.vertical, .trailing], 4)
    }
}

struct LogbookListRowItem: Identifiable, Equatable {
    var id: DiveLogID { identifier }
    let identifier: DiveLogID
    let logNumber: Int
    let logNumberText: String
    let diveSiteText: String?
    let maximumDepthText: String?
    let totalTimeText: String?
    let logDateText: String?
}

#Preview(traits: .sizeThatFitsLayout) {
    LogbookListRow(
        item: LogbookListRowItem(
            identifier: DiveLogID(),
            logNumber: 12,
            logNumberText: "#12",
            diveSiteText: "Doljo beach",
            maximumDepthText: "24m",
            totalTimeText: "32min",
            logDateText: "Oct 31, 2024"
        )
    )
}
