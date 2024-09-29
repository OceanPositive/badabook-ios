//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaUI

struct LogbookView: View {
    @StateObject private var store = ViewStore(
        reducer: LogbookReducer(),
        state: LogbookReducer.State()
    )

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.state.items) { item in
                    LogbookListRow(item: item)
                }
            }
            .navigationTitle(L10n.Logbook.title)
            .onAppear(perform: onAppear)
        }
    }

    private func onAppear() {
        store.send(.load)
    }
}
