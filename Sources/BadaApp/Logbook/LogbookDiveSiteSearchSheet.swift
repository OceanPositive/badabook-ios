//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaUI

struct LogbookDiveSiteSearchSheet: View {
    let action: (LocalSearchResult) -> Void

    @Environment(\.dismiss) private var dismiss
    @StateObject private var store = ViewStore(
        reducer: LogbookDiveSiteSearchReducer(),
        state: LogbookDiveSiteSearchReducer.State()
    )

    var body: some View {
        NavigationStack {
            List(Array(store.state.searchCompletions.enumerated()), id: \.offset) { index, searchCompletion in
                Button {
                    store.send(.search(for: searchCompletion))
                } label: {
                    VStack(alignment: .leading) {
                        Text(searchCompletion.title)
                            .font(.headline)
                            .foregroundStyle(Color.primary)
                        if !searchCompletion.subtitle.isEmpty {
                            Text(searchCompletion.subtitle)
                                .font(.subheadline)
                                .foregroundStyle(Color.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Dive site")
            #if os(macOS)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        cancelButton
                    }
                }
                .frame(idealWidth: 400, idealHeight: 600)
            #endif
            .searchable(
                text: store.binding(\.searchText, send: { .setSearchText($0) }),
                prompt: Text("Search")
            )
            .disabled(store.state.isSearching)
            .overlay {
                if store.state.isSearching {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .controlSize(.large)
                }
            }
            .onChange(of: store.state.searchResult, onSearchResultChange)
        }
    }

    private var cancelButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
        }
    }

    private func onSearchResultChange() {
        guard let searchResult = store.state.searchResult else { return }
        action(searchResult)
        dismiss()
    }
}
