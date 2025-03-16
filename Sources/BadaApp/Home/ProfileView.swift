//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaUI

struct ProfileView: View {
    @StateObject private var store = ViewStore(
        reducer: ProfileReducer(),
        state: ProfileReducer.State()
    )

    var body: some View {
        Form {
            Section {
                LabeledTextField(
                    value: store.binding(\.name, send: { .setName($0) }),
                    prompt: "Not Set",
                    label: "Name",
                    keyboardType: .default
                )
                DatePicker(
                    "Date of Birth",
                    selection: store.binding(\.dateOfBirth, send: { .setDateOfBirth($0) }),
                    displayedComponents: .date
                )
            }
            Section(header: Text("Certifications")) {
                ForEach(store.state.certifications, id: \.identifier) { certification in
                    CertificationRow(certification: certification)
                }
                Button {
                    store.send(.setIsCertificationAddSheetPresenting(true))
                } label: {
                    HStack {
                        Image(systemName: SystemImage.plus.rawValue)
                        Text("New Certification")
                    }
                    .font(.body)
                }
            }
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
        .sheet(
            isPresented: store.binding(\.isCertificationAddSheetPresenting, send: { .setIsCertificationAddSheetPresenting($0) }),
            content: { CertificationAddSheet() }
        )
        .onAppear { store.send(.load) }
    }

    private var saveButton: some View {
        Button {
            store.send(.save)
        } label: {
            Text("Save")
        }
    }
}

extension ProfileView {
    private struct CertificationRow: View {
        var certification: Certification

        var body: some View {
            VStack(alignment: .trailing, spacing: 0) {
                HStack(spacing: 8) {
                    Circle()
                        .frame(width: 24, height: 24)
                    Text(agencyText(certification.agency))
                        .font(.body)
                        .foregroundStyle(.primary)
                    Spacer()
                }
                Spacer()
                    .frame(height: 16)
                Text(levelText(certification.level))
                    .font(.body)
                    .foregroundStyle(.primary)
                Spacer()
                    .frame(height: 8)
                Text(certification.date.formatted(date: .long, time: .omitted))
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }

        private func agencyText(_ agency: CertificationAgency) -> String {
            switch agency {
            case .padi:
                "PADI"
            case .naui:
                "NAUI"
            case .scubapro:
                "SCUBA PRO"
            case .sdi:
                "SDI"
            case .tdi:
                "TDI"
            case .ssi:
                "SSI"
            }
        }

        private func levelText(_ level: CertificationLevel) -> String {
            switch level {
            case .openWater:
                "Open water"
            case .advancedOpenWater:
                "Advanced open water"
            case .rescueDiver:
                "Rescue diver"
            case .diveMaster:
                "Dive master"
            case .instructor:
                "Instructor"
            case .instructorTrainer:
                "Instructor trainer"
            }
        }
    }
}

#Preview {
    ProfileView()
}
