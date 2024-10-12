//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaUI
import BadaDomain

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
                    LabeledTextField(
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
                    Picker(
                        "Dive style",
                        selection: store.binding(\.diveStyle, send: { .setDiveStyle($0) })
                    ) {
                        ForEach(DiveStyle.allCases, id: \.self) { diveStyle in
                            Text(diveStyle.description).tag(diveStyle)
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
                    LabeledTextField(
                        value: Binding(
                            get: { store.state.bottomTime?.rawValue },
                            set: { store.send(.setBottomTime($0)) }),
                        format: .number,
                        prompt: "minute",
                        label: "Bottom time",
                        keyboardType: .decimalPad
                    )
                    .focused($focusedField, equals: .bottomTime)
                    LabeledTextField(
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
                    LabeledTextField(
                        value: Binding(
                            get: { store.state.entryAir?.rawValue },
                            set: { store.send(.setEntryAir($0)) }),
                        format: .number,
                        prompt: "bar",
                        label: "Entry",
                        keyboardType: .numberPad
                    )
                    .focused($focusedField, equals: .entryAir)
                    LabeledTextField(
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
                    LabeledTextField(
                        value: Binding(
                            get: { store.state.maximumDepth?.rawValue },
                            set: { store.send(.setMaximumDepth($0)) }),
                        format: .number,
                        prompt: "m",
                        label: "Maximum",
                        keyboardType: .numberPad
                    )
                    .focused($focusedField, equals: .maximumDepth)
                    LabeledTextField(
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
                    LabeledTextField(
                        value: Binding(
                            get: { store.state.airTemperature?.rawValue },
                            set: { store.send(.setAirTemperature($0)) }),
                        format: .number,
                        prompt: "℃",
                        label: "Air",
                        keyboardType: .numberPad
                    )
                    .focused($focusedField, equals: .maximumWaterTemperature)
                    LabeledTextField(
                        value: Binding(
                            get: { store.state.surfaceTemperature?.rawValue },
                            set: { store.send(.setSurfaceTemperature($0)) }),
                        format: .number,
                        prompt: "℃",
                        label: "Surface",
                        keyboardType: .numberPad
                    )
                    .focused($focusedField, equals: .minimumWaterTemperature)
                    LabeledTextField(
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
            .navigationTitle("New log")
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
                ToolbarItem(placement: .keyboard) {
                    HStack(spacing: 0) {
                        previousFieldButton
                        nextFieldButton
                        Spacer()
                        doneButton
                    }
                }
            }
            #if os(macOS)
            .padding()
            #endif
        }
    }

    private var saveButton: some View {
        Button(action: tapSaveButton) {
            Text("Save")
        }
    }

    private var cancelButton: some View {
        Button(action: tapCancelButton) {
            Text("Cancel")
        }
    }

    private var doneButton: some View {
        Button(action: tapDoneButton) {
            Text("Done")
        }
    }

    private var previousFieldButton: some View {
        Button(action: tapPreviousFieldButton) {
            Image(systemImage: .chevronUp)
        }
        .disabled(focusedField?.previous == nil)
    }

    private var nextFieldButton: some View {
        Button(action: tapNextFieldButton) {
            Image(systemImage: .chevronDown)
        }
        .disabled(focusedField?.next == nil)
    }

    private func tapSaveButton() {

    }

    private func tapCancelButton() {
        dismiss()
    }

    private func tapDoneButton() {
        focusedField = nil
    }

    private func tapNextFieldButton() {
        focusedField = focusedField?.next
    }

    private func tapPreviousFieldButton() {
        focusedField = focusedField?.previous
    }
}

extension DiveStyle {
    fileprivate static var allCases: [DiveStyle] {
        [
            .boat,
            .beach,
            .night,
            .sideMount,
            .doubleTank,
            .dpv,
            .wreck,
            .training,
        ]
    }

    fileprivate var description: String {
        switch self {
        case .boat: return "Boat"
        case .beach: return "Beach"
        case .night: return "Night"
        case .sideMount: return "Side Mount"
        case .doubleTank: return "Double Tank"
        case .dpv: return "DPV"
        case .wreck: return "Wreck"
        case .training: return "Training"
        }
    }
}

extension LogbookAddSheet {
    private enum Field: Int, CaseIterable {
        case logNumber = 0
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
