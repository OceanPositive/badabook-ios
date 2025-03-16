//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaUI

struct LogbookDetailView: View {
    let id: DiveLogID

    init(id: DiveLogID) {
        self.id = id
    }

    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    @StateObject private var store = ViewStore(
        reducer: LogbookDetailReducer(),
        state: LogbookDetailReducer.State()
    )
    @State private var notes: String = ""

    var body: some View {
        Form {
            Section {
                LabeledFormattedTextField(
                    value: store.binding(\.logNumber, send: { .setLogNumber($0) }),
                    format: .number,
                    prompt: "123",
                    label: "Log number",
                    keyboardType: .numberPad
                )
                .focused($focusedField, equals: .logNumber)
                DatePicker(
                    "Log date",
                    selection: store.binding(\.logDate, send: { .setLogDate($0) }),
                    displayedComponents: .date
                )
                LabeledContent("Dive site") {
                    Text(store.state.diveSite?.title ?? "search")
                        .foregroundStyle(store.state.diveSite == nil ? .tertiary : .secondary)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    store.send(.setIsDiveSiteSearchSheetPresenting(true))
                }
                LabeledTextField(
                    value: store.binding(\.diveCenter, send: { .setDiveCenter($0) }),
                    prompt: "name",
                    label: "Dive center",
                    keyboardType: .default
                )
                .focused($focusedField, equals: .diveCenter)
                Picker(
                    "Dive style",
                    selection: store.binding(\.diveStyle, send: { .setDiveStyle($0) })
                ) {
                    ForEach(DiveStyle.allCases, id: \.self) { diveStyle in
                        Text(diveStyle.description)
                            .tag(diveStyle)
                    }
                }
            }
            Section {
                DatePicker(
                    "Entry time",
                    selection: store.binding(\.entryTime, send: { .setEntryTime($0) }),
                    displayedComponents: .hourAndMinute
                )
                DatePicker(
                    "Exit time",
                    selection: store.binding(\.exitTime, send: { .setExitTime($0) }),
                    displayedComponents: .hourAndMinute
                )
                LabeledFormattedTextField(
                    value: Binding(
                        get: { store.state.bottomTime?.rawValue },
                        set: { store.send(.setBottomTime($0)) }),
                    format: .number,
                    prompt: "minute",
                    label: "Bottom time",
                    keyboardType: .decimalPad
                )
                .focused($focusedField, equals: .bottomTime)
                LabeledFormattedTextField(
                    value: Binding(
                        get: { store.state.surfaceInterval?.rawValue },
                        set: { store.send(.setSurfaceInterval($0)) }),
                    format: .number,
                    prompt: "minute",
                    label: "Surfcae interval",
                    keyboardType: .decimalPad
                )
                .focused($focusedField, equals: .surfaceInterval)
            }
            Section(header: Text("Air pressure")) {
                LabeledFormattedTextField(
                    value: Binding(
                        get: { store.state.entryAir?.rawValue },
                        set: { store.send(.setEntryAir($0)) }),
                    format: .number,
                    prompt: "bar",
                    label: "Entry",
                    keyboardType: .numberPad
                )
                .focused($focusedField, equals: .entryAir)
                LabeledFormattedTextField(
                    value: Binding(
                        get: { store.state.exitAir?.rawValue },
                        set: { store.send(.setExitAir($0)) }),
                    format: .number,
                    prompt: "bar",
                    label: "Exit",
                    keyboardType: .numberPad
                )
                .focused($focusedField, equals: .exitAir)
            }
            Section(header: Text("Depth")) {
                LabeledFormattedTextField(
                    value: Binding(
                        get: { store.state.maximumDepth?.rawValue },
                        set: { store.send(.setMaximumDepth($0)) }),
                    format: .number,
                    prompt: "m",
                    label: "Maximum",
                    keyboardType: .numberPad
                )
                .focused($focusedField, equals: .maximumDepth)
                LabeledFormattedTextField(
                    value: Binding(
                        get: { store.state.averageDepth?.rawValue },
                        set: { store.send(.setAverageDepth($0)) }),
                    format: .number,
                    prompt: "m",
                    label: "Average",
                    keyboardType: .numberPad
                )
                .focused($focusedField, equals: .averageDepth)
            }
            Section(header: Text("Temperature")) {
                LabeledFormattedTextField(
                    value: Binding(
                        get: { store.state.airTemperature?.rawValue },
                        set: { store.send(.setAirTemperature($0)) }),
                    format: .number,
                    prompt: "℃",
                    label: "Air",
                    keyboardType: .numberPad
                )
                .focused($focusedField, equals: .maximumWaterTemperature)
                LabeledFormattedTextField(
                    value: Binding(
                        get: { store.state.surfaceTemperature?.rawValue },
                        set: { store.send(.setSurfaceTemperature($0)) }),
                    format: .number,
                    prompt: "℃",
                    label: "Surface",
                    keyboardType: .numberPad
                )
                .focused($focusedField, equals: .minimumWaterTemperature)
                LabeledFormattedTextField(
                    value: Binding(
                        get: { store.state.bottomTemperature?.rawValue },
                        set: { store.send(.setBottomTemperature($0)) }),
                    format: .number,
                    prompt: "℃",
                    label: "Bottom",
                    keyboardType: .numberPad
                )
                .focused($focusedField, equals: .averageWaterTemperature)
            }
            Section {
                Picker(
                    "Weather",
                    selection: store.binding(\.weather, send: { .setWeather($0) })
                ) {
                    ForEach(Weather.allCases, id: \.self) { weather in
                        let spacing = " "
                        Label(
                            spacing + weather.description,
                            systemImage: weather.icon.rawValue
                        )
                        .tag(weather)
                    }
                }
                Picker(
                    "Feeling",
                    selection: store.binding(\.feeling, send: { .setFeeling($0) })
                ) {
                    ForEach(Feeling.allCases, id: \.self) { feeling in
                        Text(feeling.description)
                            .tag(feeling)
                    }
                }
            }
            Section(header: Text("Notes")) {
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
                #if os(iOS)
                    .textInputAutocapitalization(.never)
                #endif
            }
        }
        #if os(macOS)
            .padding()
        #endif
        .navigationTitle("Log")
        #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
        .toolbar {
            // FIXME: Invalid frame dimension (negative or non-finite).
            ToolbarItem(placement: .confirmationAction) {
                saveButton
            }
            ToolbarItemGroup(placement: .keyboard) {
                previousFieldButton
                nextFieldButton
                Spacer()
                doneButton
            }
        }
        .sheet(
            isPresented: Binding<Bool>(
                get: { store.state.isDiveSiteSearchSheetPresenting },
                set: { store.send(.setIsDiveSiteSearchSheetPresenting($0)) }
            ),
            content: { LogbookDiveSiteSearchSheet(action: selectDiveSite) }
        )
        .onAppear { store.send(.load(id)) }
        .onChange(of: store.state.shouldDismiss, onShouldDismissChange)
        .onChange(of: store.state.notesInitialized, onNotesInitializedChange)
    }

    private var saveButton: some View {
        Button {
            store.send(.save)
        } label: {
            Text("Save")
        }
        .disabled(store.state.saveButtonDisabled)
    }

    private var doneButton: some View {
        Button {
            focusedField = nil
        } label: {
            Text("Done")
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

    private func onNotesInitializedChange() {
        guard store.state.notesInitialized else { return }
        notes = store.state.notes
    }

    private func selectDiveSite(_ searchResult: LocalSearchResult) {
        store.send(.setDiveSiteSearchResult(searchResult))
    }
}

extension LogbookDetailView {
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
