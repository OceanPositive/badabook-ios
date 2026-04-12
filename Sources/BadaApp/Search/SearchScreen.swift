//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaUI

struct SearchScreen: View {
    @ObservedObject private var navigationStore = NavigationStore.shared
    @StateObject private var store = ViewStore(
        reducer: SearchReducer(),
        state: SearchReducer.State()
    )

    var body: some View {
        NavigationStack(
            path: navigationStore.binding(
                \.searchPaths,
                send: { .setSearchPaths($0) })
        ) {
            List {
                ForEach(store.state.filteredItems) { item in
                    Button {
                        navigationStore.send(.search(.logDetail(id: item.id)))
                    } label: {
                        LogbookListRow(item: item)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
            .listStyle(.automatic)
            .overlay {
                if store.state.searchText.isEmpty {
                    ContentUnavailableView(
                        L10n.Search.emptyPrompt,
                        systemImage: SystemImage.magnifyingglass.rawValue
                    )
                } else if store.state.filteredItems.isEmpty {
                    ContentUnavailableView(
                        L10n.Search.noResults,
                        systemImage: SystemImage.magnifyingglass.rawValue
                    )
                }
            }
            .navigationTitle(L10n.MainTab.search)
            .navigationDestination(for: NavigationState.SearchPath.self) { path in
                switch path {
                case let .logDetail(id):
                    LogbookDetailScreen(id: id)
                }
            }
            .onAppear { store.send(.load) }
            .searchable(text: store.binding(\.searchText, send: { .search($0) }))
        }
    }
}
