//
//  UITestingBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 09.11.2023.
//

import SwiftUI

final class UITestingViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var isCurrentUserAuth: Bool = false
    
    func signUpButtonPressed() {
        guard !text.isEmpty else { return }
        isCurrentUserAuth = true
    }
}

struct UITestingBootcamp: View {
    @StateObject private var vm = UITestingViewModel()
    
    private let placeholderText: String = "Type here...."
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.red, Color.blue], startPoint: .top, endPoint: .bottom)
            
            ZStack {
                if vm.isCurrentUserAuth {
                    WelcomeView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .trailing))
                } else {
                    signUpView
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                }
            }
        }
        .ignoresSafeArea()
    }
}

extension UITestingBootcamp {
    private var signUpView: some View {
        VStack {
            if !vm.isCurrentUserAuth {
                TextField(placeholderText, text: $vm.text)
                    .font(.headline)
                    .padding()
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 10))
                    .accessibilityIdentifier("TextFieldPlaceholder")
            } else {
                Spacer()
            }
            
            Button {
                withAnimation(.smooth) {
                    if vm.isCurrentUserAuth {
                        vm.isCurrentUserAuth = false
                    } else {
                        vm.signUpButtonPressed()
                    }
                }
            } label: {
                Text(vm.isCurrentUserAuth ? "Log out" : "Sign up")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(minHeight: 55)
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(colors: [Color.blue, Color.blue.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(.rect(cornerRadius: 10))
                    .blendMode(.difference)
            }
            .accessibilityIdentifier("SignUpButton")
        }
        .padding()

    }
}

struct WelcomeView: View {
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Show welcome Alert!")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(minHeight: 55)
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(colors: [Color.blue, Color.blue.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .clipShape(.rect(cornerRadius: 10))
                        .blendMode(.difference)
                }
                .accessibilityIdentifier("ShowAlertButton")
                
                NavigationLink {
                    Text("Destination!")
                } label: {
                    Text("Navigate")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(minHeight: 55)
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(colors: [Color.blue, Color.blue.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .clipShape(.rect(cornerRadius: 10))
                        .blendMode(.difference)
                }
                .accessibilityIdentifier("Navigate")
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Welcome to the app."))
            }
            .navigationTitle("Welcome.")
        }
    }
}

#Preview {
    UITestingBootcamp()
}
