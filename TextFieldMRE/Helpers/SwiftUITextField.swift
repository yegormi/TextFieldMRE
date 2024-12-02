//
//  SwiftUITextField.swift
//  SimpleTextFieldSwiftUI
//
//  Created by Yehor Myropoltsev on 01.12.2024.
//

import SwiftUI

struct SwiftUITextField: View, CustomTextFieldProtocol {
    let text: Binding<String>
    let placeholder: String
    let isSecure: Bool
    let keyboardType: UIKeyboardType
    let onSubmit: (() -> Void)?
    let onFocusChanged: ((Bool) -> Void)?
    let returnKeyType: UIReturnKeyType
        
    init(
        text: Binding<String>,
        placeholder: String = "",
        isSecure: Bool = false,
        keyboardType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        onSubmit: (() -> Void)? = nil,
        onFocusChanged: ((Bool) -> Void)? = nil
    ) {
        self.text = text
        self.placeholder = placeholder
        self.isSecure = isSecure
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.onSubmit = onSubmit
        self.onFocusChanged = onFocusChanged
    }
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: text)
            } else {
                TextField(placeholder, text: text)
            }
        }
        .keyboardType(keyboardType)
        .submitLabel(SubmitLabel(returnKeyType))
        .textFieldStyle(.roundedBorder)
        .focused($isFocused)
        .onChange(of: isFocused) { old, new in
            onFocusChanged?(new)
        }
        .onSubmit {
            onSubmit?()
        }
    }
}
