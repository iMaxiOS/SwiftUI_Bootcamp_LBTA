//
//  SelectedServerBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 15.11.2022.
//

import SwiftUI

struct SelectedServerBootcamp: View {
    @Environment(\.scenePhase) var scenePhase
    
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                imageCircleToTop
                connectButtonToServer
                
                VStack(spacing: 0) {
                    navigationViewHeader
                    yourConnectSection

                    Spacer()

                    VStack(spacing: Constants.smallDevice ? 30 : 70) {
                        smartConnectSection
                        navigationLinkToSelectServer
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 20)
            }
            .navigationBarHidden(true)
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private var imageCircleToTop: some View {
        ZStack(alignment: .top) {
            Image(Image.connect1)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 275)
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    private var connectButtonToServer: some View {
        Button {
            withAnimation {
                
            }
        } label: {
            ZStack {
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [Color(.systemBackground), Color(.systemBackground), Color.notConnect]),
                            center: .center,
                            startRadius: 0,
                            endRadius: 90
                        )
                    )
                    .frame(width: 192, height: 192)
                
                Circle()
                    .fill(Color(.systemBackground))
                    .frame(width: 148, height: 148)
                
                Image(Image.power)
                    .renderingMode(.template)
                    .foregroundColor(Color(.gray))
                    .frame(width: 40, height: 44)
            }
        }
        .offset(y: 215)
    }
    
    private var navigationViewHeader: some View {
        HStack {
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color(.blue))
                        .frame(width: 80, height: 40)
                    VStack(spacing: 0) {
                        Text("Upgrade to")
                            .font(.custom(Font.Lato.bold, size: 10))
                            .foregroundColor(Color(.systemBackground))
                        Text("PRO")
                            .font(.custom(Font.Lato.bold, size: 17))
                            .foregroundColor(Color(.systemBackground))
                    }
                    .multilineTextAlignment(.center)
                }
            }
            
            Spacer()
            
            NavigationLink {
                
            } label: {
                Image(Image.person)
                    .foregroundColor(Color(.blue))
            }
        }
    }
    
    private var yourConnectSection: some View {
        VStack {
            Text("Your Connection")
                .font(.custom(Font.Lato.light, size: 24))
            Text("is not Secured")
                .font(.custom(Font.Lato.bold, size: 24))
        }
        .foregroundColor(Color(.gray))
        .padding(.top, 47)
    }
    
    private var smartConnectSection: some View {
        VStack(spacing: 11) {
            Text("Smart Connect")
                .font(.custom(Font.Lato.bold, size: 17))
                .foregroundColor(Color(.gray))
            
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(.blue).opacity(0.05))
                .overlay {
                    HStack(alignment: .center, spacing: 20) {
                        Image(Image.brazil)
                            .resizable()
                            .clipped()
                            .frame(width: 28, height: 20)
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Brazil")
                                .font(.custom(Font.Lato.bold, size: 17))
                            Text("Italy")
                                .font(.custom(Font.Lato.bold, size: 12))
                        }
                        .foregroundColor(Color(.textField))
                        
                        Spacer()
                        
                        Image(Image.network)
                        
                        Button {
                            
                        } label: {
                            Image(Image.info)
                                .frame(width: 26, height: 26)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .frame(height: 60)
        }
    }
    
    private var navigationLinkToSelectServer: some View {
        NavigationLink {
            
        } label: {
            VStack(spacing: 11) {
                Text("Select Server")
                    .font(.custom(Font.Lato.bold, size: 17))
                    .foregroundColor(Color(.gray))
                
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.blue).opacity(0.07))
                    .overlay {
                        HStack(alignment: .center, spacing: 20) {
                            Image(Image.usa)
                                .resizable()
                                .clipped()
                                .frame(width: 28, height: 20)
                            
                            VStack(alignment: .leading, spacing: 3) {
                                Text("USA")
                                    .font(.custom(Font.Lato.bold, size: 17))
                                Text("New York")
                                    .font(.custom(Font.Lato.bold, size: 12))
                            }
                            .foregroundColor(Color(.textField))
                            
                            Spacer()
                            
                            Image(Image.network)
                            
                            Image(Image.rightArrow)
                                .frame(width: 26, height: 18)
                        }
                        .padding(.horizontal, 20)
                    }
                    .frame(height: 60)
            }
        }
    }
}
