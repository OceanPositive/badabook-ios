//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaUI

struct HomeView: View {
    @ObservedObject private var navigationStore = NavigationStore.shared
    @StateObject private var store = ViewStore(
        reducer: HomeReducer(),
        state: HomeReducer.State()
    )

    var body: some View {
        NavigationStack(
            path: navigationStore.binding(
                \.homePaths,
                 send: { .setHomePaths($0) })
        ) {
            ScrollView(.vertical) {
                VStack(spacing: 16) {
                    SectionHeader(title: "Bio") {
                        // TODO: Move to the bio edit page
                    }
                    VStack(spacing: 16) {
                        InfoRow(
                            title: "License",
                            value: "Open water"
                        )
                        Divider()
                        InfoRow(
                            title: "Experience",
                            value: "1 yr 3 mos"
                        )
                    }
                    .padding(16)
                    .background(.background.quaternary)
                    .clipShape(.rect(cornerRadius: 8))
                    SectionHeader(title: "Summary") {
                        navigationStore.send(.logbook(.root))
                    }
                    VStack(spacing: 16) {
                        InfoRow(
                            title: "Logs",
                            value: "123"
                        )
                        Divider()
                        InfoRow(
                            title: "Dive sites",
                            value: "6"
                        )
                        Divider()
                        InfoRow(
                            title: "Total dive time",
                            value: "323h 40m"
                        )
                        Divider()
                        InfoRow(
                            title: "Last dive",
                            value: "30d ago"
                        )
                    }
                    .padding(16)
                    .background(.background.quaternary)
                    .clipShape(.rect(cornerRadius: 8))
                }
                .padding(16)
            }
            .background(.background.secondary)
            .navigationTitle(L10n.Home.title)
            .navigationDestination(for: NavigationState.HomePath.self) { path in
            }
            .onAppear(perform: onAppear)
        }
    }

    private func onAppear() {
        store.send(.initialize)
    }
}

extension HomeView {
    private struct SectionHeader: View {
        let title: String
        let action: () -> Void

        var body: some View {
            HStack(spacing: 0) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.foreground)
                Spacer()
                Image(systemImage: .chevronRight)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                action()
            }
        }
    }

    private struct InfoRow: View {
        let title: String
        let value: String

        var body: some View {
            HStack(spacing: 0) {
                Text(title)
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundStyle(.primary)
                Spacer()
                Text(value)
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    HomeView()
}
