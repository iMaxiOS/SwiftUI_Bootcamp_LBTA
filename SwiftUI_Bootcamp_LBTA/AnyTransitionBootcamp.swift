//
//  AnyTransitionBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 01.11.2023.
//

import SwiftUI

struct RotationViewModifier: ViewModifier {
    var rotation: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(
                x: rotation != 0 ? Constants.widthScreen : 0,
                y: rotation != 0 ? Constants.heightScreen : 0
            )
    }
}

extension AnyTransition {
    static var rotation: AnyTransition {
        modifier(
            active: RotationViewModifier(rotation: 180),
            identity: RotationViewModifier(rotation: 0)
        )
    }
    
    static var rotationOn: AnyTransition {
        asymmetric(insertion: .rotation, removal: .move(edge: .leading))
    }
}

struct AnyTransitionBootcamp: View {
    
    @State private var showCard: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Button {
                    withAnimation(.smooth) {
                        showCard.toggle()
                    }
                } label: {
                    Text("Click me!!")
                        .modifier(DefaultViewModifier(foreground: .white, bg: .blue))
                }
//                .buttonStyle(DefaultButtonStyle())
                .buttonStyle(.plain)
                .padding(.horizontal, 30)
            }
            
            if showCard {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                CardAlert(showCard: $showCard)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.rotation)
                    .zIndex(2)
            }
        }
    }
}

struct CardAlert: View {
    @Binding var showCard: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Delete account!!")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Do you want to delete your account?")
                .font(.subheadline)
                .fontWeight(.medium)
            
            Image(systemName: "trash")
                .resizable()
                .frame(width: 60, height: 60)
            
            HStack(spacing: 10) {
                Button(action: {
                    withAnimation(.smooth) {
                        showCard.toggle()
                    }
                }, label: {
                    Text("No")
                        .modifier(DefaultViewModifier(foreground: .white, bg: .pink))
                })
                .buttonStyle(DefaultButtonStyle())
                
                Button(action: {
                    withAnimation(.smooth) {
                        showCard.toggle()
                    }
                }, label: {
                    Text("Yes")
                        .modifier(DefaultViewModifier(foreground: .white, bg: .pink))
                })
                .buttonStyle(DefaultButtonStyle())
            }
        }
        .padding()
        .foregroundStyle(.white)
        .background(LinearGradient(colors: [Color.red, Color.white], startPoint: .top, endPoint: .bottom))
        .clipShape(.rect(cornerRadius: 20))
        .padding()
        .shadow(radius: 10)
    }
}

#Preview {
    AnyTransitionBootcamp()
}
