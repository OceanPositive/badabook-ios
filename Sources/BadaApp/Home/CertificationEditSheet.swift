//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaUI

struct CertificationEditSheet: View {
    let identifier: CertificationID

    init(identifier: CertificationID) {
        self.identifier = identifier
    }

    @Environment(\.dismiss) private var dismiss
    @StateObject private var store = ViewStore(
        reducer: CertificationEditReducer(),
        state: CertificationEditReducer.State()
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
                        prompt: "Certification number",
                        label: "No.",
                        keyboardType: .default
                    )
                }
                Button(role: .destructive) {
                    store.send(.delete)
                } label: {
                    HStack {
                        Spacer()
                        Text("Delete")
                        Spacer()
                    }
                }
            }
            #if os(macOS)
                .padding()
            #endif
            .navigationTitle("Certification")
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    saveButton
                }
                ToolbarItem(placement: .cancellationAction) {
                    cancelButton
                }
            }
            .onAppear { store.send(.load(identifier)) }
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

    private var saveButton: some View {
        Button {
            store.send(.save)
        } label: {
            Text("Save")
        }
    }

    private func onShouldDismissChange() {
        guard store.state.shouldDismiss else { return }
        dismiss()
    }
}
