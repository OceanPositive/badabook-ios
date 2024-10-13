//
//  BadaBook
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
                    LabeledContent("Dive site") {
                        Text("Bohol")
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        store.send(.setIsDiveSiteSearchSheetPresenting(true))
                    }
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
                Section {
                    Picker(
                        "Weather",
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
            .sheet(
                isPresented: Binding<Bool>(
                    get: { store.state.isDiveSiteSearchSheetPresenting },
                    set: { store.send(.setIsDiveSiteSearchSheetPresenting($0)) }
                ),
                content: { LogbookDiveSiteSearchSheet() }
            )
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
                .fontWeight(.medium)
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

extension Weather {
    fileprivate static var allCases: [Weather] {
        [
            .sunny,
            .partlyCloudy,
            .cloudy,
            .windy,
            .rainy,
            .snowy,
        ]
    }

    fileprivate var description: String {
        switch self {
        case .sunny: return "Sunny"
        case .partlyCloudy: return "Partly Cloudy"
        case .cloudy: return "Cloudy"
        case .windy: return "Windy"
        case .rainy: return "Rainy"
        case .snowy: return "Snowy"
        }
    }

    fileprivate var icon: SystemImage {
        switch self {
        case .sunny: return .sunMax
        case .partlyCloudy: return .cloudSun
        case .cloudy: return .cloud
        case .windy: return .wind
        case .rainy: return .cloudRain
        case .snowy: return .cloudSnow
        }
    }
}

extension Feeling {
    fileprivate static var allCases: [Feeling] {
        [
            .amazing,
            .good,
            .average,
            .poor,
        ]
    }

    fileprivate var description: String {
        switch self {
        case .amazing: return "😍 Amazing"
        case .good: return "😆 Good"
        case .average: return "😐 Average"
        case .poor: return "😥 Poor"
        }
    }
}
