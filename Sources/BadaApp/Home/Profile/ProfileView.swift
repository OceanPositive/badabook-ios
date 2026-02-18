//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var store = ViewStore(
        reducer: ProfileReducer(),
        state: ProfileReducer.State()
    )
    private typealias State = ProfileReducer.State

    var body: some View {
        List {
            Section {
                LabeledTextField(
                    value: store.binding(\.name, send: { .setName($0) }),
                    prompt: L10n.Profile.notSet,
                    label: L10n.Profile.name,
                    keyboardType: .default
                )
                DatePicker(
                    L10n.Profile.dateOfBirth,
                    selection: store.binding(\.dateOfBirth, send: { .setDateOfBirth($0) }),
                    displayedComponents: .date
                )
            }
            Section(header: Text(L10n.Profile.certifications)) {
                ForEach(store.state.certifications, id: \.identifier) { certification in
                    CertificationRow(certification: certification)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            let identifier = certification.identifier
                            store.send(.setSheet(.certificationEdit(identifier: identifier)))
                        }
                        .swipeActions(
                            edge: .trailing,
                            allowsFullSwipe: false
                        ) {
                            Button(role: .destructive) {
                                store.send(.delete(certification))
                            } label: {
                                Image(systemImage: .trash)
                            }
                        }
                }
                Button {
                    store.send(.setSheet(.certificationAdd))
                } label: {
                    HStack {
                        Image(systemName: SystemImage.plus.rawValue)
                        Text(L10n.Profile.newCertification)
                    }
                    .font(.body)
                }
            }
        }
        .navigationTitle(L10n.Profile.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                saveButton
            }
        }
        .sheet(item: store.binding(\.sheet, send: { .setSheet($0) })) { sheet in
            switch sheet {
            case .certificationAdd:
                CertificationAddSheet()
            case let .certificationEdit(identifier):
                CertificationEditSheet(identifier: identifier)
            }
        }
        .onAppear { store.send(.load) }
        .onChange(of: store.state.sheet, onSheetChange)
        .onChange(of: store.state.shouldDismiss, onShouldDismissChange)
    }

    private var saveButton: some View {
        Button {
            store.send(.save)
        } label: {
            Text(L10n.Common.save)
        }
    }

    private func onSheetChange(oldValue: State.Sheet?, newValue: State.Sheet?) {
        guard oldValue != nil && newValue == nil else { return }
        store.send(.load)
    }

    private func onShouldDismissChange() {
        guard store.state.shouldDismiss else { return }
        dismiss()
    }
}

extension ProfileView {
    private struct CertificationRow: View {
        let certification: Certification

        var body: some View {
            VStack(alignment: .trailing, spacing: 0) {
                HStack(spacing: 0) {
                    Text(agencyText(certification.agency))
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Spacer()
                    if let agency = certification.agency {
                        Image(imageResource(agency))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(color: .secondary, radius: 0.5, x: 0, y: 0)
                            .frame(height: 24)
                            .padding(.vertical, 8)
                    }
                }
                Spacer()
                    .frame(height: 16)
                Text(levelText(certification.level))
                    .font(.body)
                    .foregroundStyle(.primary)
                Spacer()
                    .frame(height: 8)
                Text(certification.date?.formatted(date: .long, time: .omitted) ?? .nilText)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }

        private func agencyText(_ agency: CertificationAgency?) -> String {
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
            case .none:
                String.nilText
            }
        }

        private func imageResource(_ agency: CertificationAgency) -> ImageResource {
            switch agency {
            case .padi:
                ImageResource.padiLogo
            case .naui:
                ImageResource.nauiLogo
            case .scubapro:
                ImageResource.scubaproLogo
            case .sdi:
                ImageResource.sdiLogo
            case .tdi:
                ImageResource.tdiLogo
            case .ssi:
                ImageResource.ssiLogo
            }
        }

        private func levelText(_ level: CertificationLevel?) -> String {
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
            case .none:
                String.nilText
            }
        }
    }
}

#Preview {
    ProfileView()
}
