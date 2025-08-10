//
//  Badabook
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
                        L10n.Certification.agency,
                        selection: store.binding(\.agency, send: { .setAgency($0) })
                    ) {
                        ForEach(CertificationAgency.allCases, id: \.self) { agency in
                            Text(agency.description)
                                .tag(agency)
                        }
                    }
                    Picker(
                        L10n.Certification.level,
                        selection: store.binding(\.level, send: { .setLevel($0) })
                    ) {
                        ForEach(CertificationLevel.allCases, id: \.self) { level in
                            Text(level.description)
                                .tag(level)
                        }
                    }
                    DatePicker(
                        L10n.Certification.certDate,
                        selection: store.binding(\.date, send: { .setDate($0) }),
                        displayedComponents: .date
                    )
                    LabeledTextField(
                        value: store.binding(\.number, send: { .setNumber($0) }),
                        prompt: L10n.Certification.certificationNumber,
                        label: L10n.Certification.number,
                        keyboardType: .default
                    )
                }
                Button(role: .destructive) {
                    store.send(.delete)
                } label: {
                    HStack {
                        Spacer()
                        Text(L10n.Common.delete)
                        Spacer()
                    }
                }
            }
            .navigationTitle(L10n.Certification.title)
            .navigationBarTitleDisplayMode(.inline)
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
            Text(L10n.Common.cancel)
        }
    }

    private var saveButton: some View {
        Button {
            store.send(.save)
        } label: {
            Text(L10n.Common.save)
        }
    }

    private func onShouldDismissChange() {
        guard store.state.shouldDismiss else { return }
        dismiss()
    }
}
