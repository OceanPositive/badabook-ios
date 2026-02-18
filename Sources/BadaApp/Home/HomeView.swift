//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
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
                    SectionHeader(title: L10n.Home.profileSection) {
                        navigationStore.send(.home(.profile))
                    }
                    Spacer()
                        .frame(height: 16)
                    VStack(spacing: 16) {
                        InfoRow(
                            title: L10n.Home.profileCertification,
                            value: store.state.primaryCertificationText
                        )
                        Divider()
                        InfoRow(
                            title: L10n.Home.profileExperience,
                            value: store.state.totalExperienceText
                        )
                    }
                    .padding(16)
                    .background(Color(.secondarySystemGroupedBackground))
                    .clipShape(.rect(cornerRadius: 8))
                    Spacer()
                        .frame(height: 24)
                    SectionHeader(title: L10n.Home.summarySection) {
                        navigationStore.send(.logbook(.root))
                    }
                    Spacer()
                        .frame(height: 16)
                    VStack(spacing: 16) {
                        InfoRow(
                            title: L10n.Home.summaryLogs,
                            value: store.state.totalDiveLogCountText
                        )
                        Divider()
                        InfoRow(
                            title: L10n.Home.summaryDiveSites,
                            value: store.state.totalDiveSiteCountText
                        )
                        Divider()
                        InfoRow(
                            title: L10n.Home.summaryTotalDiveTime,
                            value: store.state.totalDiveTimeText
                        )
                        Divider()
                        InfoRow(
                            title: L10n.Home.summaryLastDive,
                            value: store.state.daysSinceLastDiveDateText
                        )
                    }
                    .padding(16)
                    .background(Color(.secondarySystemGroupedBackground))
                    .clipShape(.rect(cornerRadius: 8))
                }
                .padding(16)
            }
            .background(Color(.systemGroupedBackground))
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
