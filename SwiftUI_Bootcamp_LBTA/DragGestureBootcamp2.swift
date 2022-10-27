//
//  DragGestureBootcamp2.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 27.10.2022.
//

import SwiftUI

struct DragGestureBootcamp2: View {
    
    @State private var startingOffsetY = UIScreen.main.bounds.height * 0.82
    @State private var currentOffsetY: CGFloat = 0
    @State private var endOffsetY: CGFloat = 0
    
    var body: some View {
        
        ZStack {
            Color.green.ignoresSafeArea()
            
            SignIn()
                .offset(y: startingOffsetY)
                .offset(y: currentOffsetY)
                .offset(y: endOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                                currentOffsetY = value.translation.height
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                if currentOffsetY < -100 {
                                    endOffsetY = -startingOffsetY
                                } else if endOffsetY != 0 && currentOffsetY > 150 {
                                    endOffsetY = 0
                                }
                                currentOffsetY = 0
                            }
                        }
                )
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct SignIn: View {
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "chevron.up")
                    .bold()
                
                Text("Sign up")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Image(systemName: "flame.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Text("This is the description our application. This is my favorite SwiftUI course and i recommended to all of my friends to subscribe to learn SwiftUI.")
                    .multilineTextAlignment(.center)
                
                Text("CRETE AN ACCOUNT")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.black)
                    .cornerRadius(10)
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct DragGestureBootcamp2_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBootcamp2()
    }
}
