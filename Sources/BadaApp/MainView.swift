//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaUI

public struct MainView: View {
    @Environment(\.appStoreState) private var appStoreState
    @ObservedObject private var navigationStore = NavigationStore.shared
    @StateObject private var store = ViewStore(
        reducer: MainReducer(),
        state: MainReducer.State()
    )
    @State private var mainTab: NavigationState.MainTab = .home
    private var isAppLoaded: Bool {
        appStoreState.isLoaded && store.state.isLoaded
    }

    public init() {}

    public var body: some View {
        switch isAppLoaded {
        case true:
            MainTabView(mainTab: $mainTab)
                .onChange(of: mainTab, onMainTabChange)
                .onChange(of: navigationStore.state.mainTab, onNavigationStoreMainTabChange)
        case false:
            SplashView()
                .onAppear { store.send(.load) }
        }
    }

    private func onMainTabChange() {
        /// Fixes the "Update NavigationAuthority bound path tried to update multiple times per
        /// frame" warning
        Task { @MainActor in
            try await Task.sleep(nanoseconds: NSEC_PER_SEC / 60)
            navigationStore.send(.setMainTab(mainTab))
        }
    }

    private func onNavigationStoreMainTabChange() {
        guard mainTab != navigationStore.state.mainTab else { return }
        mainTab = navigationStore.state.mainTab
    }
}

private struct MainTabView: View {
    let mainTab: Binding<NavigationState.MainTab>

    var body: some View {
        TabView(selection: mainTab) {
            Tab(
                L10n.MainTab.home,
                systemImage: SystemImage.house.rawValue,
                value: .home
            ) {
                HomeView()
            }
            // TODO: Under development
            #if DEBUG
                Tab(
                    L10n.MainTab.equipment,
                    systemImage: SystemImage.doorSlidingRightHandClosed.rawValue,
                    value: .equipment
                ) {
                    EquipmentView()
                }
            #endif
            Tab(
                L10n.MainTab.logbook,
                systemImage: SystemImage.bookPages.rawValue,
                value: .logbook
            ) {
                LogbookListView()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}
