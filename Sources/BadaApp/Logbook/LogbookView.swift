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
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    addButton
                }
            }
            .sheet(
                isPresented: Binding<Bool>(
                    get: { store.state.isAddSheetPresenting },
                    set: { store.send(.setIsAddSheetPresenting($0)) }
                ),
                content: { LogbookAddSheet() }
            )
            .onAppear(perform: onAppear)
        }
    }

    private var addButton: some View {
        Button(
            L10n.Logbook.add,
            systemImage: SystemImage.plus.rawValue
        ) {
            tapAddButton()
        }
    }

    private func onAppear() {
        store.send(.load)
    }

    private func tapAddButton() {
        store.send(.setIsAddSheetPresenting(true))
    }
}
