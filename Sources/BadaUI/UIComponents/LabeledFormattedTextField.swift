//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import SwiftUI

package struct LabeledFormattedTextField<Format>: View
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
    }
}
