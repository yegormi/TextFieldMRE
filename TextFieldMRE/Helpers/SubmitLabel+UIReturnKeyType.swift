//
//  UIReturnKeyType+Exit.swift
//  SimpleTextFieldSwiftUI
//
//  Created by Yehor Myropoltsev on 01.12.2024.
//
import SwiftUI

// Helper extension to convert UIReturnKeyType to SwiftUI.SubmitLabel
extension SwiftUI.SubmitLabel {
    init(_ returnKeyType: UIReturnKeyType) {
        switch returnKeyType {
        case .done: self = .done
        case .next: self = .next
        case .go: self = .go
        case .send: self = .send
        default: self = .done
        }
    }
}
