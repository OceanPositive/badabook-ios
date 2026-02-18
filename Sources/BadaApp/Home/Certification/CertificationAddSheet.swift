//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
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
            }
            .navigationTitle(L10n.Certification.newTitle)
            .navigationBarTitleDisplayMode(.inline)
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
            Text(L10n.Common.cancel)
        }
    }

    private var addButton: some View {
        Button {
            store.send(.add)
        } label: {
            Text(L10n.Common.add)
        }
    }

    private func onShouldDismissChange() {
        guard store.state.shouldDismiss else { return }
        dismiss()
    }
}
