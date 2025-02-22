//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaUI

struct LogbookListView: View {
    @ObservedObject private var navigationStore = NavigationStore.shared
    @StateObject private var store = ViewStore(
        reducer: LogbookListReducer(),
        state: LogbookListReducer.State()
    )

    var body: some View {
        NavigationStack(
            path: navigationStore.binding(
                \.logbookPaths,
                send: { .setLogbookPaths($0) })
        ) {
            List {
                ForEach(store.state.items) { item in
                    Button {
                        navigationStore.send(.logbook(.logDetail(id: item.id)))
                    } label: {
                        LogbookListRow(item: item)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle(L10n.Logbook.title)
            .navigationDestination(for: NavigationState.LogbookPath.self) { path in
                switch path {
                case let .logDetail(id):
                    LogbookDetailView(id: id)
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    addButton
                }
            }
            .sheet(
                isPresented: store.binding(\.isAddSheetPresenting, send: { .setIsAddSheetPresenting($0) }),
                content: { LogbookAddSheet() }
            )
            .onChange(of: store.state.isAddSheetPresenting, onIsAddSheetPresentingChange)
            .onAppear { store.send(.load) }
        }
    }

    private var addButton: some View {
        Button(
            L10n.Logbook.add,
            systemImage: SystemImage.plus.rawValue
        ) {
            store.send(.setIsAddSheetPresenting(true))
        }
    }

    private func onIsAddSheetPresentingChange(oldValue: Bool, newValue: Bool) {
        if oldValue && !newValue {
            store.send(.load)
        }
    }
}
