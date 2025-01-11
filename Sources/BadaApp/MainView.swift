//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaUI

public struct MainView: View {
    @ObservedObject private var navigationStore = NavigationStore.shared
    @StateObject private var store = ViewStore(
        reducer: MainReducer(),
        state: MainReducer.State()
    )

    public init() {}

    public var body: some View {
        switch store.state.isLoaded {
        case true:
            MainTabView(
                mainTab: navigationStore.binding(\.mainTab, send: { .setMainTab($0) })
            )
        case false:
            SplashView()
                .onAppear(perform: onAppear)
        }
    }

    private func onAppear() {
        store.send(.load)
    }
}

private struct MainTabView: View {
    var mainTab: Binding<NavigationState.MainTab>

    var body: some View {
        TabView(selection: mainTab) {
            Tab(
                L10n.MainTab.home,
                systemImage: SystemImage.house.rawValue,
                value: .home
            ) {
                HomeView()
            }
            // - TODO: Under development
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
