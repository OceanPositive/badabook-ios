//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaUI

struct ProfileView: View {
    @StateObject private var store = ViewStore(
        reducer: ProfileReducer(),
        state: ProfileReducer.State()
    )

    var body: some View {
        Form {

        }
        #if os(macOS)
            .padding()
        #endif
        .navigationTitle("Profile")
        #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                saveButton
            }
        }
        .onAppear(perform: onAppear)
    }

    private var saveButton: some View {
        Button(action: tapSaveButton) {
            Text("Save")
        }
    }

    private func onAppear() {
        store.send(.load)
    }

    private func tapSaveButton() {
        store.send(.save)
    }
}

#Preview {
    ProfileView()
}
