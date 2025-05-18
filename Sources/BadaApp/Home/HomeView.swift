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
                VStack(spacing: 0) {
                    SectionHeader(title: "Profile") {
                        navigationStore.send(.home(.profile))
                    }
                    Spacer()
                        .frame(height: 16)
                    VStack(spacing: 16) {
                        InfoRow(
                            title: "Certification",
                            value: store.state.primaryCertificationText
                        )
                        Divider()
                        InfoRow(
                            title: "Experience",
                            value: store.state.totalExperienceText
                        )
                    }
                    .padding(16)
                    .background(.background.quaternary)
                    .clipShape(.rect(cornerRadius: 8))
                    Spacer()
                        .frame(height: 24)
                    SectionHeader(title: "Summary") {
                        navigationStore.send(.logbook(.root))
                    }
                    Spacer()
                        .frame(height: 16)
                    VStack(spacing: 16) {
                        InfoRow(
                            title: "Logs",
                            value: store.state.totalDiveLogCountText
                        )
                        Divider()
                        InfoRow(
                            title: "Dive sites",
                            value: store.state.totalDiveSiteCountText
                        )
                        Divider()
                        InfoRow(
                            title: "Total dive time",
                            value: store.state.totalDiveTimeText
                        )
                        Divider()
                        InfoRow(
                            title: "Last dive",
                            value: store.state.daysSinceLastDiveDateText
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
                switch path {
                case .profile:
                    ProfileView()
                }
            }
            .onAppear { store.send(.load) }
        }
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
