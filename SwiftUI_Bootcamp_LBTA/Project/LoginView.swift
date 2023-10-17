//
//  LoginView.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 01.12.2022.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var email = TextValidator()
    @ObservedObject var username = TextValidator()
    @ObservedObject var password = TextValidator()
    @FocusState private var focusedField: FieldType?
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var sendRequest = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                imageCircleToTopView
                
                VStack {
                    navigationView
                    headerTextView
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            CustomTextFieldView(currentField: .username, isLastField: false, title: username)
                                .focused($focusedField, equals: .username)
                            CustomTextFieldView(currentField: .password, isLastField: true, title: password)
                                .focused($focusedField, equals: .password)
                            
                            signInButtonView
                            cantLoginView
                            signUpSectionView
                            signInWithAnotherApplicationView
                        }
                        .foregroundColor(Color(.blue))
                        .onSubmit {
                            switch focusedField {
                            case .username:
                                focusedField = .password
                            case .password:
                                hideKeyboard()
                            default:
                                print("Creating account…")
                            }
                        }
                        .padding(.bottom, 40)
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    .onDisappear {
                        username.text = ""
                        password.text = ""
                        email.text = ""
                    }
                }
                .padding(.horizontal, 30)
            }
            .ignoresSafeArea()
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    
    private var imageCircleToTopView: some View {
        Image(Image.topCircle)
            .resizable()
            .clipped()
            .frame(height: 185)
            .frame(maxWidth: .infinity)
            .offset(y: Constants.isSafeAreaTop ? 0 : -45)
    }
    
    private var navigationView: some View {
        VStack {
            Spacer()
            VStack {
                Text("Welcome to")
                    .foregroundColor(Color(.blue))
                    .font(.custom(Font.Lato.light, size: 24))
                
                Text("Shark VPN")
                    .foregroundColor(Color(.blue))
                    .font(.custom(Font.Lato.bold, size: 24))
            }
        }
        .frame(height: Constants.isSafeAreaTop ? 130 : 80)
    }
    
    private var headerTextView: some View {
        VStack(spacing: 0) {
            Text("Log In")
                .foregroundColor(Color(.blue))
                .font(.custom(Font.Lato.bold, size: 21))
                .padding(.top, 45)
                .padding(.bottom, 10)
        }
    }
    
    private var signInButtonView: some View {
        Button {
            
        } label: {
            Text("Log In")
                .foregroundColor(Color(.systemBackground))
                .font(.custom(Font.Lato.bold, size: 17))
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color(.blue))
                .cornerRadius(14)
                .padding(.top, 20)
        }
        .alert(alertMessage, isPresented: $showingAlert) {
            if alertMessage == "Сonfirm registration" {
                Button("Cancel", role: .cancel) { }
                
                Button("Confirm") {
                    
                }
            } else {
                Button("OK", role: .cancel) { }
            }
        }
    }
    
    private var cantLoginView: some View {
        Button { //NavigationLink
//                            ConfirmationCodeView(userName: email.text, password: password.text)
        } label: {
            Text("Can’t log in?")
                .font(.custom(Font.Lato.bold, size: 14))
                .padding(.vertical, 20)
                .padding(.horizontal, 30)
        }
    }
    
    private var signUpSectionView: some View {
        VStack {
            Text("Don’t have an account yet?")
                .font(.custom(Font.Lato.bold, size: 14))
                .foregroundColor(Color(.gray))
                .padding(.top, 25)
            
            
            NavigationLink {
                
            } label: {
                Text("Sign Up")
                    .foregroundColor(Color(.systemBackground))
                    .font(.custom(Font.Lato.bold, size: 17))
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color(.blue))
                    .cornerRadius(14)
                    .padding(.top, 15)
            }
            
            Text("—  Or  —")
                .font(.custom(Font.Lato.bold, size: 17))
                .foregroundColor(Color(.gray))
                .padding(.vertical, 30)
        }
    }
    
    private var signInWithAnotherApplicationView: some View {
        HStack {
            Button {
                UIApplication.shared.open(URL(string: "https://apple.com")!)
            } label: {
                Image(Image.white_apple)
                    .frame(width: 50, height: 50)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            
            Spacer()
            
            Button {
                UIApplication.shared.open(URL(string: "https://facebook.com")!)
            } label: {
                Image(Image.white_facebook)
                    .frame(width: 50, height: 50)
                    .background(Color(.chambray))
                    .cornerRadius(10)
            }
            
            Spacer()
            
            Button {
                UIApplication.shared.open(URL(string: "https://google.com")!)
            } label: {
                Image(Image.white_google)
                    .frame(width: 50, height: 50)
                    .background(Color(.red))
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 20)
    }
}
