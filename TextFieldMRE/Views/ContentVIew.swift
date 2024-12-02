import SwiftUI

struct ContentView: View {
    @State private var textInputs = TextInputState()
    @State private var useSwiftUI = false
    
    @FocusState private var focusedField: InputField?
    
    var body: some View {
        VStack(spacing: 20) {
            textFieldGroup
            
            Toggle("Use SwiftUI", isOn: $useSwiftUI)
            
            Spacer()
        }
        .padding(30)
    }
    
    private var textFieldGroup: some View {
        Group {
            if useSwiftUI {
                textFields(using: createSwiftUITextField)
            } else {
                textFields(using: createUIKitTextField)
            }
        }
    }
    
    private func textFields<T: View>(
        using factory: (InputField) -> T
    ) -> some View {
        Group {
            factory(.first)
            factory(.second)
        }
    }
    
    private func createSwiftUITextField(_ field: InputField) -> some View {
        SwiftUITextField(
            text: binding(for: field),
            placeholder: placeholder(for: field),
            returnKeyType: returnKeyType(for: field),
            onSubmit: onSubmit(for: field)
        )
        .focused($focusedField, equals: field)
    }
    
    private func createUIKitTextField(_ field: InputField) -> some View {
        UIKitTextField(
            text: binding(for: field),
            placeholder: placeholder(for: field),
            returnKeyType: returnKeyType(for: field),
            onSubmit: onSubmit(for: field)
        )
        .focused($focusedField, equals: field)
    }
    
    private func binding(for field: InputField) -> Binding<String> {
        switch field {
        case .first: return $textInputs.first
        case .second: return $textInputs.second
        }
    }
    
    private func placeholder(for field: InputField) -> String {
        switch field {
        case .first: return "First text field"
        case .second: return "Second text field"
        }
    }
    
    private func returnKeyType(for field: InputField) -> UIReturnKeyType {
        switch field {
        case .first: return .next
        case .second: return .done
        }
    }
    
    private func onSubmit(for field: InputField) -> () -> Void {
        switch field {
        case .first: return { focusedField = .second }
        case .second: return { focusedField = nil }
        }
    }
}

struct TextInputState {
    var first = ""
    var second = ""
}

enum InputField: Hashable {
    case first, second
}
