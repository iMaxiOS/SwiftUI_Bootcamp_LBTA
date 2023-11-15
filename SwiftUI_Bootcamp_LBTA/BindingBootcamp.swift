//
//  BindingBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 15.11.2023.
//

import SwiftUI

struct BindingBootcamp: View {
    @State private var title: String = ""
//    @State private var showAlert: Bool = false
    @State private var errorMassage: String? = nil
    
    var body: some View {
        VStack {
            Text(title)
            TitleView(title: $title)
            TitleView2(title: $title)
            TitleView3(title: Binding(get: {
                title
            }, set: { value in
                self.title = value
            }))
            
            Button {
                errorMassage = "NEW ERROR!!!!"
//                showAlert.toggle()
            } label: {
                Text("SHOW ERROR!!!")
                    .modifier(ButtonModifier())
            }

        }
        .alert(errorMassage ?? "", isPresented: Binding(value: $errorMassage)) {
            Button("OK") {
                
            }
        }
//        .alert(errorMassage ?? "ERROR", isPresented: $showAlert) {
//            Button("OK") {
//                
//            }
//        }
    }
}

extension Binding where Value == Bool {
    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}


struct TitleView: View {
    @Binding var title: String
    
    var body: some View {
        Text(title)
//            .onAppear {
//                title = "NEW TITLE2"
//            }
    }
}

struct TitleView2: View {
    let title: Binding<String>
    
    var body: some View {
        Text(title.wrappedValue)
    }
}

struct TitleView3: View {
    let title: Binding<String>
    
    var body: some View {
        Text(title.wrappedValue)
            .onAppear {
                title.wrappedValue = "NEW TITLE3"
            }
    }
}

#Preview {
    BindingBootcamp()
}
