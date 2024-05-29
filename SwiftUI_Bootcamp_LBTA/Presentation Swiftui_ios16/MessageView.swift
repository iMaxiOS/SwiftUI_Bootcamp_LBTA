//
//  MessageView.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 22.05.2024.
//

import SwiftUI

struct MessageView: View {
    @State private var time = 0.0
    @AppStorage("showMessage") private var showMessage = true
    
    private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        content
            .opacity(showMessage ? 1 : 0)
            .scaleEffect(showMessage ? 1 : 0)
            .rotationEffect(.degrees(showMessage ? 0 : 30))
            .offset(y: showMessage ? 0 : 500)
            .blur(radius: showMessage ? 0 : 20)
            .dynamicTypeSize(.xSmall ... .xxxLarge)
    }
}

private extension MessageView {
    var content: some View {
        VStack(spacing: 20) {
            Image(systemName: "timelapse", variableValue: time)
                .imageScale(.large)
                .foregroundStyle(.tint)
                .font(.system(size: 50, weight: .thin))
                .onReceive(timer, perform: { value in
                    if time < 1.0 {
                        time += 0.1
                    } else {
                        time = 0.0
                    }
                })
            
            Text("Switching Apps".uppercased())
                .font(.largeTitle.width(.compressed))
                .fontWeight(.bold)
            
            Text("Tap and hold any part of the acreen for 1 second to show the menu for switching between apps.")
                .foregroundStyle(.secondary)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            
            Button {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showMessage.toggle()
                }
            } label: {
                Text("Got it")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white.opacity(0.2).gradient)
                    .clipShape(.rect(cornerRadius: 10))
                    .background(stroke)
            }
            .shadow(radius: 10)
        }
        .padding(30)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 10))
        .overlay(stroke)
        .shadow(color: .black.opacity(0.3), radius: 20, y: 20)
        .frame(maxWidth: 500)
        .padding(10)
    }
    
    var stroke: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke()
            .foregroundStyle(
                .linearGradient(
                    colors: [
                        .white.opacity(0.5),
                        .clear,
                        .white.opacity(0.5),
                        .clear
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }
}

#Preview {
    MessageView()
        .background(Image("Background 1"))
}
