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
            Form {
                Section {
                    Picker(
                        "Agency",
                        selection: store.binding(\.agency, send: { .setAgency($0) })
                    ) {
                        ForEach(CertificationAgency.allCases, id: \.self) { agency in
                            Text(agency.description)
                                .tag(agency)
                        }
                    }
                    Picker(
                        "Level",
                        selection: store.binding(\.level, send: { .setLevel($0) })
                    ) {
                        ForEach(CertificationLevel.allCases, id: \.self) { level in
                            Text(level.description)
                                .tag(level)
                        }
                    }
                    DatePicker(
                        "Cert. Date",
                        selection: store.binding(\.date, send: { .setDate($0) }),
                        displayedComponents: .date
                    )
                    LabeledTextField(
                        value: store.binding(\.number, send: { .setNumber($0) }),
                        prompt: "",
                        label: "Cert. No.",
                        keyboardType: .default
                    )
                }
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
            .onChange(of: store.state.shouldDismiss, onShouldDismissChange)
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

    private func onShouldDismissChange() {
        guard store.state.shouldDismiss else { return }
        dismiss()
    }
}
