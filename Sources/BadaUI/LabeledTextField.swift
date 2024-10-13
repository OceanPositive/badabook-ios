//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import SwiftUI

package struct LabeledTextField<Format>: View
where Format: ParseableFormatStyle, Format.FormatOutput == String {
    private let label: String
    private let value: Binding<Format.FormatInput?>
    private let format: Format
    private let prompt: String
    private let keyboardType: KeyboardType
    private let textAlignment: TextAlignment

    package init(
        value: Binding<Format.FormatInput?>,
        format: Format,
        prompt: String,
        label: String,
        keyboardType: KeyboardType,
        textAlignment: TextAlignment = .trailing
    ) {
        self.label = label
        self.value = value
        self.format = format
        self.prompt = prompt
        self.keyboardType = keyboardType
        self.textAlignment = textAlignment
    }

    package var body: some View {
        #if os(iOS)
            LabeledContent(label) {
                TextField(
                    value: value,
                    format: format,
                    prompt: Text(prompt),
                    label: { Text(label) }
                )
                .multilineTextAlignment(textAlignment)
                .keyboardType(keyboardType.uiKeyboardType)
            }
        #else
            TextField(
                value: value,
                format: format,
                prompt: Text(prompt),
                label: { Text(label) }
            )
            .multilineTextAlignment(textAlignment)
        #endif
    }
}

extension LabeledTextField {
    package enum KeyboardType: Int, Sendable {
        case `default` = 0
        case asciiCapable = 1
        case numbersAndPunctuation = 2
        case URL = 3
        case numberPad = 4
        case phonePad = 5
        case namePhonePad = 6
        case emailAddress = 7
        case decimalPad = 8
        case twitter = 9
        case webSearch = 10
        case asciiCapableNumberPad = 11

        #if os(iOS)
            var uiKeyboardType: UIKeyboardType {
                switch self {
                case .default: return .default
                case .asciiCapable: return .asciiCapable
                case .numbersAndPunctuation: return .numbersAndPunctuation
                case .URL: return .URL
                case .numberPad: return .numberPad
                case .phonePad: return .phonePad
                case .namePhonePad: return .namePhonePad
                case .emailAddress: return .emailAddress
                case .decimalPad: return .decimalPad
                case .twitter: return .twitter
                case .webSearch: return .webSearch
                case .asciiCapableNumberPad: return .asciiCapableNumberPad
                }
            }
        #endif
    }
}
