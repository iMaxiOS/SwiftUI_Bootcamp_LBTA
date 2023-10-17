//
//  CustomTextFieldView.swift
//  SharkVPN
//
//  Created by Alena Klysa on 27.10.2022.
//

import SwiftUI
import Combine


class TextValidator: ObservableObject {
    
    @Published var text = ""
    
    func validation(type: FieldType, equalWithText: String?) -> Bool {
        switch type {
        case .username:
            return text.count >= 5
        case .password, .newPassword, .repeatNewPassword, .createPassword:
            let passwordFormat = "^(?=.*[a-z])(?=.*[A-Z])(?=.*?[0-9])[A-Za-z\\d(-.,@$!%*?&_^+€£¥•:;#()<=>{|}~)]{8,}$"
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
            return passwordTest.evaluate(with: text)
        case .email:
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                   let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: text)
//        case .code:
//            return text.count >= 6
        case .repeatPassword:
            return !text.isEmpty && text.count >= 8 && text == equalWithText
        }
    }
}

enum FieldType {
    case email
    case username
    case password
    case repeatPassword
//    case code
    case newPassword
    case repeatNewPassword
    case createPassword
    
    var placeholder: String {
        switch self {
        case .email:
            return "Email"
        case .username:
            return "Username"
        case .password:
            return "Password"
        case .repeatPassword:
            return "Repeat Password"
//        case .code:
//            return "Confirmation code"
        case .newPassword:
            return "New Password"
        case .repeatNewPassword:
            return "Repeat New Password"
        case .createPassword:
            return "Create Password"
        }
    }
    
    var errorMessage: String {
        switch self {
        case .email:
            return "Check if the email is correct"
        case .username:
            return "Username should contain 5-35 letters and (optionally) numbers and underscores."
        case .password, .newPassword, .repeatNewPassword, .createPassword:
            return "Password should contain min 8 both uppercase and lowercase letters, numbers and (optionally) special symbols"
//        case .code:
//            return "Conformation code should contain 6 numbers"
        case .repeatPassword:
            return "Password fields do not match"
        }
    }
}

struct CustomTextFieldView: View {
    
    var currentField: FieldType = .email
    var isLastField: Bool
    
    @FocusState private var isTextFieldFocused: Bool
    @ObservedObject var title = TextValidator()
    @ObservedObject var comparableText = TextValidator()
    @State private var endEditingField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            switch currentField {
            case .username, .email:
                emailField()
                    .padding(.top, 15)
//            case .code:
//                codeField()
            case .password, .repeatPassword, .newPassword, .repeatNewPassword, .createPassword:
                secureField()
                    .padding(.top, 15)
            }
        }
    }
    
    @ViewBuilder
    func emailField() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(currentField.placeholder)
                .font(.system(size: 17, weight: .semibold))
                .font(.custom(Font.Lato.bold, size: 17))
                .offset(x: !title.text.isEmpty ? 0 : 20, y: !title.text.isEmpty ? 0 : 32)
            
            HStack {
                TextField("", text: $title.text)
                    .font(.custom(Font.Lato.bold, size: 17))
                    .foregroundColor(Color(.textField))
                    .submitLabel(.next)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 19)
                    .onReceive(Just(title.text)) { newValue in
                        let value = newValue.replacingOccurrences(
                            of: " ", with: "", options: .regularExpression)
                        if value != newValue {
                            self.title.text = value
                        }
                    }
                    .focused($isTextFieldFocused)
                    .onChange(of: isTextFieldFocused) { isFocused in
                        if isFocused {
                            endEditingField = false
                        } else {
                            endEditingField = true
                        }
                    }
                
                Image(validationField() ? Image.checkmark : Image.xmark)
                    .renderingMode(.template)
                    .foregroundColor(validationField() ? Color(.blue) : endEditingField ? Color.red : Color(.gray))
                    .frame(width: 26, height: 26)
            }
            
            Divider()
                .frame(height: 1)
                .background(validationField() ? Color(.blue) : endEditingField ? Color.red : Color(.gray))
            
            if endEditingField {
                if !title.validation(type: currentField, equalWithText: comparableText.text) && !title.text.isEmpty {
                    Text(currentField.errorMessage)
                        .foregroundColor(Color.red)
                        .font(.custom(Font.Lato.bold, size: 10))
                        .frame(height: currentField == .email ? 16 : 26)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                }
            }
        }
        .animation(.spring(), value: title.text.isEmpty)
        .foregroundColor(Color(.gray))
    }
    
    /*
    @ViewBuilder
    func codeField() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Confirmation code")
                .font(.custom(Font.Lato.bold, size: 17))
                .foregroundColor(Color(.gray))
            
            HStack(spacing: 14) {
                ForEach(0..<6, id: \.self) { index in
                    VStack(spacing: 8) {
                        TextField("", text: $title.text)
                            .foregroundColor(Color(.textField))
                            .font(.custom(Font.Lato.bold, size: 24))
                            .keyboardType(.numberPad)
                            .textContentType(.oneTimeCode)
                            .multilineTextAlignment(.center)
                            .disableAutocorrection(true)
                            .onReceive(Just(title.text)) { newValue in
                                let value = newValue.replacingOccurrences(
                                    of: " ", with: "", options: .regularExpression)
                                if value != newValue {
                                    self.title.text = value
                                }
                            }
                            .focused($isTextFieldFocused)
                            .onChange(of: isTextFieldFocused) { isFocused in
                                if isFocused {
                                    endEditingField = false
                                } else {
                                    endEditingField = true
                                }
                            }

                        Rectangle()
                            .frame(width: 45, height: 2)
                            .foregroundColor(Color(.gray))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
    */
    
    @ViewBuilder
    func secureField() -> some View {
//        if self.showPassword {
            VStack(alignment: .leading, spacing: 4) {
                Text(currentField.placeholder)
                    .font(.custom(Font.Lato.bold, size: 17))
                    .offset(x: !title.text.isEmpty ? 0 : 20, y: !title.text.isEmpty ? 0 : 32)
                
                HStack {
                    SecureField("", text: $title.text)
                        .font(.custom(Font.Lato.bold, size: 17))
                        .foregroundColor(Color(.textField))
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .padding(.leading, 19)
                        .submitLabel(isLastField ? .done : .next)
                        .onReceive(Just(title.text)) { newValue in
                            let value = newValue.replacingOccurrences(
                                of: " ", with: "", options: .regularExpression)
                            if value != newValue {
                                self.title.text = value
                            }
                        }
                        .focused($isTextFieldFocused)
                        .onChange(of: isTextFieldFocused) { isFocused in
                            if isFocused {
                                endEditingField = false
                            } else {
                                endEditingField = true
                            }
                        }
                    
                    Image(validationField() ? Image.checkmark : Image.xmark)
                        .renderingMode(.template)
                        .foregroundColor(validationField() ? Color(.blue) : endEditingField ? Color.red : Color(.gray))
                        .frame(width: 26, height: 26)
                }
                
                Divider()
                    .frame(height: 1)
                    .background(validationField() ? Color(.blue) : endEditingField ? Color.red : Color(.gray))
                
                if endEditingField {
                    if !title.validation(type: currentField, equalWithText: comparableText.text) && !title.text.isEmpty {
                        Text(currentField.errorMessage)
                            .foregroundColor(Color(.red))
                            .font(.custom(Font.Lato.bold, size: 10))
                            .frame(height: currentField == .username ? 16 : 26)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                    }
                }
            }
            .animation(.spring(), value: title.text.isEmpty)
            .foregroundColor(Color(.gray))
//        } else {
//            SecureField(currentField.placeholder, text: $title.text)
//                .padding()
//                .textInputAutocapitalization(.never)
//                .disableAutocorrection(true)
//                .frame(width: 250, height: 50, alignment: .leading)
//                .submitLabel(isLastField ? .done : .next)
//                .onReceive(Just(title.text)) { newValue in
//                    let value = newValue.replacingOccurrences(
//                        of: " ", with: "", options: .regularExpression)
//                    if value != newValue {
//                        self.title.text = value
//                    }
//
//                }
//                .focused($isTextFieldFocused)
//                .onChange(of: isTextFieldFocused) { isFocused in
//                    if isFocused {
//                        endEditingField = false
//                    } else {
//                        endEditingField = true
//                    }
//                }
//        }
    }
    
    private func validationField() -> Bool {
        title.validation(type: currentField, equalWithText: comparableText.text)
    }
    
//    private func colorValidation() -> Color {
//        if title.text.isEmpty {
//            return .gray
//        } else {
//            if validationField() {
//                return .blue
//            } else {
//                return .red
//            }
//        }
//    }
}

struct CustomTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldView(isLastField: false)
    }
}
