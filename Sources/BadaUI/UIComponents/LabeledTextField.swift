//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import SwiftUI

package struct LabeledTextField: View {
    private let label: String
    private let value: Binding<String>
    private let prompt: String
    private let keyboardType: KeyboardType
    private let textAlignment: TextAlignment

    package init(
        value: Binding<String>,
        prompt: String,
        label: String,
        keyboardType: KeyboardType,
        textAlignment: TextAlignment = .trailing
    ) {
        self.label = label
        self.value = value
        self.prompt = prompt
        self.keyboardType = keyboardType
        self.textAlignment = textAlignment
    }

    package var body: some View {
        LabeledContent(label) {
            TextField(
                text: value,
                prompt: Text(prompt),
                label: { Text(label) }
            )
            .multilineTextAlignment(textAlignment)
            .keyboardType(keyboardType.uiKeyboardType)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
        }
    }
}
