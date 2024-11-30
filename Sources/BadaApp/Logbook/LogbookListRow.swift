//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaUI

struct LogbookListRow: View {
    let item: LogbookListRowItem

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 0) {
                Text(item.leadingPrimaryText)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text(item.trailingPrimaryText ?? "")
                        .font(.callout)
                        .foregroundStyle(.primary)
                    Text(item.trailingSecondaryText ?? "")
                        .font(.callout)
                        .foregroundStyle(.primary)
                }
            }
            HStack(spacing: 0) {
                if let leadingSecondaryText = item.leadingSecondaryText,
                    let leadingSecondaryImage = item.leadingSecondaryImage
                {
                    HStack(spacing: 2) {
                        Image(systemImage: leadingSecondaryImage)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(leadingSecondaryText)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                Spacer()
                Text(item.trailingTertiarytext ?? "")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .padding([.vertical, .trailing], 4)
    }
}

struct LogbookListRowItem: Identifiable, Equatable {
    let id: DiveLogID
    let leadingPrimaryText: String
    let leadingSecondaryImage: SystemImage?
    let leadingSecondaryText: String?
    let trailingPrimaryText: String?
    let trailingSecondaryText: String?
    let trailingTertiarytext: String?
}

#Preview(traits: .sizeThatFitsLayout) {
    LogbookListRow(
        item: LogbookListRowItem(
            id: DiveLogID(),
            leadingPrimaryText: "#12",
            leadingSecondaryImage: .location,
            leadingSecondaryText: "Doljo beach",
            trailingPrimaryText: "24m",
            trailingSecondaryText: "32min",
            trailingTertiarytext: "Oct 31, 2024"
        )
    )
}
