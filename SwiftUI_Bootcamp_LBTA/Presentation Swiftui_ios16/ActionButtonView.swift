//
//  ActionButtonView.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 23.05.2024.
//

import SwiftUI

struct ActionButtonView: View {
    @State private var show = false
    @State private var translation: CGSize = .zero
    
    @ObservedObject var manager = MotionManager()
    
    var body: some View {
        ZStack {
            Image(.UI_1)
                .resizable()
                .scaledToFill()
                .clipShape(.rect(cornerRadius: show ? 50 : 0))
                .overlay(motion)
                .scaleEffect(show ? 0.96 : 1)
//                .blur(radius: show ? 20 : 0)
            
            Rectangle()
                .fill(.ultraThinMaterial)
                .overlay {
                    Rectangle()
                        .fill(.black.opacity(0.5)).blendMode(.overlay)
                }
                .mask(canvas)
                .shadow(color: .white.opacity(0.2), radius: 0, x: -1, y: -1)
                .shadow(color: .black.opacity(0.2), radius: 0, x: 1, y: 1)
                .shadow(color: .black.opacity(0.5), radius: 10, x: 10, y: 10)
                .overlay(icons)
                .background(
                    circle.frame(width: 208)
                        .overlay(circle.frame(width: 60))
                        .overlay(circle.frame(width: 80))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        .offset(x: 60, y: 60)
                        .opacity(show ? 1 : 0)
                        .scaleEffect(show ? 1 : 0.8, anchor: .bottomTrailing)
                )
                .offset(y: -28)
                .onTapGesture {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                        show.toggle()
                    }
                }
                .gesture(drag)
        }
        .background(.black)
        .ignoresSafeArea()
    }
}

private extension ActionButtonView {
    var icons: some View {
        ZStack {
            Image(systemName: "plus")
                .font(.system(size: 30))
                .rotationEffect(.degrees(show ? 45 : 0))
                .offset(x: -28, y: -28)
            Group {
                Image(systemName: "bubble.left.fill")
                    .offset(x: -28, y: -129)
                Image(systemName: "moon.fill")
                    .offset(x: -128, y: -28)
                Image(systemName: "quote.opening")
                    .offset(x: -113, y: -114)
            }
            .opacity(show ? 1 : 0)
            .blur(radius: show ? 0 : 10)
            .scaleEffect(show ? 1 : 0.5)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
    
    var circle: some View {
        Circle().stroke().fill(
            .linearGradient(
                colors: [.white, .clear],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
    
    var motion: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50).stroke(.linearGradient(colors: [.white.opacity(0.2), .white.opacity(0.5), .clear], startPoint: .topLeading, endPoint: UnitPoint(x: abs(manager.roll) * 5 + 1, y: abs(manager.roll) * 5 + 1)))
            LinearGradient(colors: [.clear, .white.opacity(0.5), .clear], startPoint: .topLeading, endPoint: UnitPoint(x: abs(manager.roll) * 10 + 1, y: abs(manager.roll) * 10 + 1))
                .clipShape(.rect(cornerRadius: 50))
            LinearGradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                .blendMode(.softLight)
        }
        .opacity(show ? 1 : 0)
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                translation = value.translation
            }
            .onEnded { value in
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    translation = .zero
                }
            }
    }
    
    var canvas: some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.8))
            context.addFilter(.blur(radius: 10))
            context.drawLayer { context in
                for index in 1...5 {
                    if let symbol = context.resolveSymbol(id: index) {
                        context.draw(symbol, at: CGPoint(x: size.width - 44, y: size.height - 44))
                    }
                }
            }
        } symbols: {
            Circle()
                .frame(width: 76)
                .tag(1)
                .offset(y: show ? -100: 0)
                .onTapGesture {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                        show.toggle()
                    }
                }
            Circle()
                .frame(width: 76)
                .tag(2)
                .offset(x: show ? -100 : 0)
                .onTapGesture {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                        show.toggle()
                    }
                }
            Circle()
                .frame(width: 76)
                .tag(3)
                .offset(x: show ? -84 : 0, y: show ? -84 : 0)
                .onTapGesture {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                        show.toggle()
                    }
                }
            Circle()
                .frame(width: 76)
                .tag(4)
            Circle()
                .frame(width: 76)
                .tag(5)
                .offset(translation)
        }
    }
}

#Preview {
    ActionButtonView()
}
