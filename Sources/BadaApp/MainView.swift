//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaUI

public struct MainView: View {
    @StateObject private var store = ViewStore(
        reducer: MainReducer(),
        state: MainReducer.State()
    )

    public init() {}

    public var body: some View {
        switch store.state.isLoaded {
        case true:
            MainTabView(
                tab: Binding<MainTab>(
                    get: { store.state.tab },
                    set: { store.send(.setTab($0)) }
                )
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
    var tab: Binding<MainTab>

    var body: some View {
        TabView(selection: tab) {
            Tab(
                L10n.MainTab.home,
                systemImage: SystemImage.house.rawValue,
                value: .home
            ) {
                HomeView()
            }
            Tab(
                L10n.MainTab.equipment,
                systemImage: SystemImage.doorSlidingRightHandClosed.rawValue,
                value: .equipment
            ) {
                EquipmentView()
            }
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
