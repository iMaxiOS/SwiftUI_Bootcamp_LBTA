//
//  UIViewRepresentableBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 07.11.2023.
//

import SwiftUI

struct UIViewRepresentableBootcamp: View {
    @State private var text = ""
    
    var body: some View {
        
        VStack {
            Text(text)
                .font(.headline)
                .frame(height: 55)
            
            TextField("Type here..", text: $text)
                .padding(.horizontal)
                .frame(height: 55)
                .background(.gray)
            
            UITextFieldViewRepresentable(text: $text)
                .padding(.horizontal)
                .frame(height: 55)
                .background(.gray)
        }
        .padding()
    }
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextField {
        let textField = getTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    private func getTextField() -> UITextField {
        let textField = UITextField()
        let attribute = NSAttributedString(
            string: "Type here....",
            attributes: [.foregroundColor: UIColor.red]
        )
        textField.attributedPlaceholder = attribute
        return textField
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

#Preview {
    UIViewRepresentableBootcamp()
}
