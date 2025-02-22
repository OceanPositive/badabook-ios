//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaUI

struct CertificationAddSheet: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var store = ViewStore(
        reducer: CertificationAddReducer(),
        state: CertificationAddReducer.State()
    )

    var body: some View {
        NavigationStack {
            VStack {
                Text("CertificationAddSheet")
            }
            #if os(macOS)
                .padding()
            #endif
            .navigationTitle("New Certification")
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    addButton
                }
                ToolbarItem(placement: .cancellationAction) {
                    cancelButton
                }
            }
        }
    }

    private var cancelButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
        }
    }

    private var addButton: some View {
        Button {

        } label: {
            Text("Add")
        }
    }
}
