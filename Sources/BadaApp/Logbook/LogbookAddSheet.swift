//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaUI

struct LogbookAddSheet: View {
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    @StateObject private var store = ViewStore(
        reducer: LogbookAddReducer(),
        state: LogbookAddReducer.State()
    )
    @State private var notes: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    LabeledFormattedTextField(
                        value: store.binding(\.logNumber, send: { .setLogNumber($0) }),
                        format: .number,
                        prompt: "123",
                        label: L10n.Logbook.logNumber,
                        keyboardType: .numberPad
                    )
                    .focused($focusedField, equals: .logNumber)
                    DatePicker(
                        L10n.Logbook.logDate,
                        selection: store.binding(\.logDate, send: { .setLogDate($0) }),
                        displayedComponents: .date
                    )
                    LabeledContent(L10n.Logbook.diveSite) {
                        Text(store.state.diveSite?.title ?? L10n.Logbook.Placeholder.search)
                            .foregroundStyle(store.state.diveSite == nil ? .tertiary : .secondary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        store.send(.setIsDiveSiteSearchSheetPresenting(true))
                    }
                    LabeledTextField(
                        value: store.binding(\.diveCenter, send: { .setDiveCenter($0) }),
                        prompt: L10n.Logbook.Placeholder.name,
                        label: L10n.Logbook.diveCenter,
                        keyboardType: .default
                    )
                    .focused($focusedField, equals: .diveCenter)
                    Picker(
                        L10n.Logbook.diveStyle,
                        selection: store.binding(\.diveStyle, send: { .setDiveStyle($0) })
                    ) {
                        ForEach(DiveStyle.allCases, id: \.self) { diveStyle in
                            Text(diveStyle.description).tag(diveStyle)
                        }
                    }
                }
                Section {
                    DatePicker(
                        L10n.Logbook.entryTime,
                        selection: store.binding(\.entryTime, send: { .setEntryTime($0) }),
                        displayedComponents: .hourAndMinute
                    )
                    DatePicker(
                        L10n.Logbook.exitTime,
                        selection: store.binding(\.exitTime, send: { .setExitTime($0) }),
                        displayedComponents: .hourAndMinute
                    )
                    LabeledFormattedTextField(
                        value: Binding(
                            get: { store.state.bottomTime?.rawValue },
                            set: { store.send(.setBottomTime($0)) }),
                        format: .number,
                        prompt: L10n.Logbook.Placeholder.minute,
                        label: L10n.Logbook.bottomTime,
                        keyboardType: .decimalPad
                    )
                    .focused($focusedField, equals: .bottomTime)
                    LabeledFormattedTextField(
                        value: Binding(
                            get: { store.state.surfaceInterval?.rawValue },
                            set: { store.send(.setSurfaceInterval($0)) }),
                        format: .number,
                        prompt: L10n.Logbook.Placeholder.minute,
                        label: L10n.Logbook.surfaceInterval,
                        keyboardType: .decimalPad
                    )
                    .focused($focusedField, equals: .surfaceInterval)
                }
                Section(header: Text(L10n.Logbook.depth)) {
                    LabeledFormattedTextField(
                        value: Binding(
                            get: { store.state.maximumDepth?.rawValue },
                            set: { store.send(.setMaximumDepth($0)) }),
                        format: .number,
                        prompt: L10n.Logbook.Placeholder.meter,
                        label: L10n.Logbook.maximum,
                        keyboardType: .numberPad
                    )
                    .focused($focusedField, equals: .maximumDepth)
                    LabeledFormattedTextField(
                        value: Binding(
                            get: { store.state.averageDepth?.rawValue },
                            set: { store.send(.setAverageDepth($0)) }),
                        format: .number,
                        prompt: L10n.Logbook.Placeholder.meter,
                        label: L10n.Logbook.average,
                        keyboardType: .numberPad
                    )
                    .focused($focusedField, equals: .averageDepth)
                }
                Section(header: Text(L10n.Logbook.airPressure)) {
                    LabeledFormattedTextField(
                        value: Binding(
                            get: { store.state.entryAir?.rawValue },
                            set: { store.send(.setEntryAir($0)) }),
                        format: .number,
                        prompt: L10n.Logbook.Placeholder.bar,
                        label: L10n.Logbook.entry,
                        keyboardType: .numberPad
                    )
                    .focused($focusedField, equals: .entryAir)
                    LabeledFormattedTextField(
                        value: Binding(
                            get: { store.state.exitAir?.rawValue },
                            set: { store.send(.setExitAir($0)) }),
                        format: .number,
                        prompt: L10n.Logbook.Placeholder.bar,
                        label: L10n.Logbook.exit,
                        keyboardType: .numberPad
                    )
                    .focused($focusedField, equals: .exitAir)
                }
                Section(header: Text(L10n.Logbook.temperature)) {
                    LabeledFormattedTextField(
                        value: Binding(
                            get: { store.state.surfaceTemperature?.rawValue },
                            set: { store.send(.setSurfaceTemperature($0)) }),
                        format: .number,
                        prompt: "℃",
                        label: L10n.Logbook.surface,
                        keyboardType: .numberPad
                    )
                    .focused($focusedField, equals: .minimumWaterTemperature)
                    LabeledFormattedTextField(
                        value: Binding(
                            get: { store.state.bottomTemperature?.rawValue },
                            set: { store.send(.setBottomTemperature($0)) }),
                        format: .number,
                        prompt: "℃",
                        label: L10n.Logbook.bottom,
                        keyboardType: .numberPad
                    )
                    .focused($focusedField, equals: .averageWaterTemperature)
                }
                Section {
                    Picker(
                        L10n.Logbook.Weather.title,
                        selection: store.binding(\.weather, send: { .setWeather($0) })
                    ) {
                        ForEach(Weather.allCases, id: \.self) { weather in
                            Label(
                                weather.description,
                                systemImage: weather.icon.rawValue
                            )
                            .tag(weather)
                        }
                    }
                    Picker(
                        L10n.Logbook.Feeling.title,
                        selection: store.binding(\.feeling, send: { .setFeeling($0) })
                    ) {
                        ForEach(Feeling.allCases, id: \.self) { feeling in
                            Text(feeling.description)
                                .tag(feeling)
                        }
                    }
                }
                Section(header: Text(L10n.Logbook.notes)) {
                    TextEditor(
                        text: Binding(
                            get: { notes },
                            set: {
                                notes = $0
                                store.send(.setNotes($0))
                            }
                        )
                    )
                    .font(.body)
                    .lineSpacing(4)
                    .frame(height: 100)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                }
            }
            .navigationTitle(L10n.Logbook.addTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    saveButton
                }
                ToolbarItem(placement: .cancellationAction) {
                    cancelButton
                }
                ToolbarItemGroup(placement: .keyboard) {
                    previousFieldButton
                    nextFieldButton
                    Spacer()
                    doneButton
                }
            }
            .overlay {
                if store.state.isLoading {
                    ProgressView()
                        .controlSize(.large)
                }
            }
            .sheet(
                isPresented: Binding<Bool>(
                    get: { store.state.isDiveSiteSearchSheetPresenting },
                    set: { store.send(.setIsDiveSiteSearchSheetPresenting($0)) }
                ),
                content: { LogbookDiveSiteSearchSheet(action: selectDiveSite) }
            )
            .onAppear { store.send(.load) }
            .onChange(of: store.state.shouldDismiss, onShouldDismissChange)
        }
    }

    private var saveButton: some View {
        Button {
            store.send(.save)
        } label: {
            Text(L10n.Common.save)
        }
        .disabled(store.state.saveButtonDisabled)
    }

    private var cancelButton: some View {
        Button {
            store.send(.dismiss)
        } label: {
            Text(L10n.Common.cancel)
        }
    }

    private var doneButton: some View {
        Button {
            focusedField = nil
        } label: {
            Text(L10n.Common.done)
                .fontWeight(.medium)
        }
    }

    private var previousFieldButton: some View {
        Button {
            focusedField = focusedField?.previous
        } label: {
            Image(systemImage: .chevronUp)
        }
        .disabled(focusedField?.previous == nil)
    }

    private var nextFieldButton: some View {
        Button {
            focusedField = focusedField?.next
        } label: {
            Image(systemImage: .chevronDown)
        }
        .disabled(focusedField?.next == nil)
    }

    private func onShouldDismissChange() {
        guard store.state.shouldDismiss else { return }
        dismiss()
    }

    private func selectDiveSite(_ searchResult: LocalSearchResult) {
        store.send(.setDiveSiteBySearching(searchResult))
    }
}

extension LogbookAddSheet {
    private enum Field: Int, CaseIterable {
        case logNumber = 0
        case diveCenter
        case bottomTime
        case surfaceInterval
        case entryAir
        case exitAir
        case maximumDepth
        case averageDepth
        case maximumWaterTemperature
        case minimumWaterTemperature
        case averageWaterTemperature

        var previous: Field? {
            guard let currentIndex = Field.allCases.firstIndex(of: self) else { return nil }
            guard currentIndex > 0 else { return nil }
            return Field.allCases[currentIndex - 1]
        }

        var next: Field? {
            guard let currentIndex = Field.allCases.firstIndex(of: self) else { return nil }
            guard currentIndex < Field.allCases.count - 1 else { return nil }
            return Field.allCases[currentIndex + 1]
        }
    }
}
