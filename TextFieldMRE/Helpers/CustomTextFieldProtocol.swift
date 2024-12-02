//
//  CustomTextFieldProtocol.swift
//  SimpleTextFieldSwiftUI
//
//  Created by Yehor Myropoltsev on 01.12.2024.
//

import SwiftUI

protocol CustomTextFieldProtocol {
    var text: Binding<String> { get }
    var placeholder: String { get }
    var isSecure: Bool { get }
    var keyboardType: UIKeyboardType { get }
    var onSubmit: (() -> Void)? { get }
    var onFocusChanged: ((Bool) -> Void)? { get }
    var returnKeyType: UIReturnKeyType { get }
}
