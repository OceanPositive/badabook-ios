//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaUI

struct LogbookListView: View {
    @StateObject private var store = ViewStore(
        reducer: LogbookListReducer(),
        state: LogbookListReducer.State()
    )

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.state.items) { item in
                    Button(action: { tapRowItem(item) }) {
                        LogbookListRow(item: item)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
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
            .onChange(of: store.state.isAddSheetPresenting, isAddSheetPresentingChanged)
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

    private func isAddSheetPresentingChanged(oldValue: Bool, newValue: Bool) {
        if oldValue && !newValue {
            store.send(.load)
        }
    }

    private func onAppear() {
        store.send(.load)
    }

    private func tapAddButton() {
        store.send(.setIsAddSheetPresenting(true))
    }

    private func tapRowItem(_ item: LogbookListRowItem) {
        // TODO: WIP
    }
}
