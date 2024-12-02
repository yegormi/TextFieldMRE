//
//  UIKitTextField.swift
//  SimpleTextFieldSwiftUI
//
//  Created by Yehor Myropoltsev on 01.12.2024.
//

import SwiftUI

struct UIKitTextField: UIViewRepresentable, CustomTextFieldProtocol {
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
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UITextField, context: Context) -> CGSize? {
        CGSize(width: proposal.width ?? .infinity, height: uiView.intrinsicContentSize.height)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        
        textField.setContentHuggingPriority(.required, for: .vertical)
        textField.setContentCompressionResistancePriority(.required, for: .vertical)
        textField.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        textField.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text.wrappedValue
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: UIKitTextField
        
        init(_ parent: UIKitTextField) {
            self.parent = parent
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.parent.text.wrappedValue = updatedText
                }
            }
            return true
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.onFocusChanged?(true)
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.onFocusChanged?(false)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            parent.onSubmit?()
            return true
        }
    }
}
