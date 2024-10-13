//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaUI

struct LogbookDiveSiteSearchSheet: View {
    @StateObject private var store = ViewStore(
        reducer: LogbookDiveSiteSearchReducer(),
        state: LogbookDiveSiteSearchReducer.State()
    )

    var body: some View {
        NavigationStack {
            List(store.state.searchResults, id: \.self) { result in
                VStack(alignment: .leading) {
                    Text(result.title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    if !result.subtitle.isEmpty {
                        Text(result.subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Dive site")
            .searchable(
                text: store.binding(\.searchText, send: { .setSearchText($0) }),
                prompt: Text("Search")
            )
        }
    }
}
