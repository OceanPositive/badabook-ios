//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaUI

struct EquipmentView: View {
    @ObservedObject private var navigationStore = NavigationStore.shared
    @StateObject private var store = ViewStore(
        reducer: EquipmentReducer(),
        state: EquipmentReducer.State()
    )

    var body: some View {
        NavigationStack(
            path: navigationStore.binding(
                \.equipmentPaths,
                send: { .setEquipmentPaths($0) })
        ) {
            ScrollView(.vertical) {

            }
            .background(.background.secondary)
            .navigationTitle(L10n.Equipment.title)
            .navigationDestination(for: NavigationState.EquipmentPath.self) { path in
            }
        }
    }
}
