//
//  ButtonView.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 27.05.2024.
//

import SwiftUI

struct ButtonView: View {
    @State private var appear = false
    @GestureState private var isPressed = false
    @State private var show = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .frame(width: 64, height: 44)
            .foregroundStyle(
                .linearGradient(
                    colors: [Color(#colorLiteral(red: 0.1780736373, green: 0.1556764568, blue: 0.2118287102, alpha: 1)), Color(#colorLiteral(red: 0.08541313559, green: 0.09838479012, blue: 0.1084858105, alpha: 1))],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .shadow(.inner(color: isPressed ? .black : .white, radius: 0, x: 1, y: 1))
                .shadow(.inner(color: isPressed ? .black : .white.opacity(0.05), radius: 4, x: 0, y: -4))
                .shadow(.drop(color: .black.opacity(0.5), radius: 30, x: 0, y: 30))
            )
            .overlay(
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.black, lineWidth: 1)
                    RoundedRectangle(cornerRadius: 30)
                        .trim(from: isPressed ? 0.0 : 1.0, to: isPressed ? 1.0 : 0.0)
                        .stroke(.white, lineWidth: 2)
                        .blendMode(.luminosity)
                }
            )
            .overlay(Image(systemName: "circle").foregroundStyle(.white))
            .background(
                ZStack {
                    AngularGradient(colors: [.red, .blue, .teal, .red], center: .center)
                        .clipShape(.rect(cornerRadius: 30))
                        .blur(radius: 15)
                    AngularGradient(colors: [.white, .blue, .teal, .white], center: .center, angle: .degrees(appear ? 360 : 0))
                        .clipShape(.rect(cornerRadius: 30))
                        .blur(radius: 15)
                        .blendMode(.overlay)
                }
                    .opacity(show ? 1 : 0)
            )
            .scaleEffect(isPressed ? 1.1 : 1)
            .animation(.spring(duration: 0.6), value: isPressed)
            .gesture(longPress)
            .overlay {
                TooltipView()
                    .offset(y: -160)
                    .opacity(show ? 1 : 0)
                    .rotation3DEffect(
                        .degrees(show ? 0 : 10), axis: (x: -1.0, y: -1.0, z: 0.0)
                    )
                    .scaleEffect(show ? 1 : 0.1)
                    .animation(.spring(response: 0.5, dampingFraction: 0.8), value: isPressed)
            }
            .onAppear {
                withAnimation(.linear(duration: 2).repeatCount(10, autoreverses: false)) {
                    appear = true
                }
            }
    }
}

struct ButtonViewOnTapped: View {
    @State private var appear = false
    
    var image: String
    var handle: (() -> ())
    
    var body: some View {
        Button { handle() } label: {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 64, height: 44)
                .foregroundStyle(
                    .linearGradient(
                        colors: [Color(#colorLiteral(red: 0.1780736373, green: 0.1556764568, blue: 0.2118287102, alpha: 1)), Color(#colorLiteral(red: 0.08541313559, green: 0.09838479012, blue: 0.1084858105, alpha: 1))],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .shadow(.drop(color: .black.opacity(0.5), radius: 30, x: 0, y: 30))
                )
                .overlay(
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.black, lineWidth: 1)
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.white, lineWidth: 2)
                            .blendMode(.luminosity)
                    }
                )
                .overlay(Image(systemName: image).foregroundStyle(.white))
                .background(
                    ZStack {
                        AngularGradient(colors: [.red, .blue, .teal, .red], center: .center)
                            .clipShape(.rect(cornerRadius: 30))
                            .blur(radius: 15)
                        AngularGradient(colors: [.white, .blue, .teal, .white], center: .center, angle: .degrees(appear ? 360 : 0))
                            .clipShape(.rect(cornerRadius: 30))
                            .blur(radius: 15)
                            .blendMode(.overlay)
                    }
                )
        }
        .onAppear {
            withAnimation(.linear(duration: 2).repeatCount(10, autoreverses: false)) {
                appear = true
            }
        }
    }
}

private extension ButtonView {
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 1)
            .updating($isPressed) { currentState, gestureState, transaction in
                gestureState = currentState
            }
            .onEnded { value in
                show.toggle()
            }
    }
}

#Preview {
    ButtonView()
}
