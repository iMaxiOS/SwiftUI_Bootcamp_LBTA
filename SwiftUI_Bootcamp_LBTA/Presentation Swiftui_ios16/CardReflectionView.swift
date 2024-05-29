//
//  CardReflectionView.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 23.05.2024.
//

import SwiftUI

struct CardReflectionView: View {
    
    @State private var translation: CGSize = .zero
    @State private var isDragging: Bool = false
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            
            Image(.background1)
                .resizable()
                .scaledToFill()
                .frame(height: 600)
                .overlay {
                    Image(.logo1)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180)
                        .offset(x: translation.width / 8, y: translation.height / 15)
                    Image(.logo2)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400)
                        .offset(x: translation.width / 10, y: translation.height / 20)
                    
                    Image(.logo3)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 392, height: 600)
                        .blendMode(.overlay)
                        .offset(x: translation.width / 15, y: translation.height / 30)
                }
                .overlay(glass1.blendMode(.softLight))
                .overlay(glass2.blendMode(.luminosity))
                .overlay(glass2.blendMode(.overlay))
                .overlay(
                    LinearGradient(
                        colors: [.clear, .white.opacity(0.5), .clear],
                        startPoint: .topLeading,
                        endPoint: UnitPoint(x: abs(translation.height / 100 + 1), y: abs(translation.height / 100 + 1))
                    )
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 50)
                        .strokeBorder(
                            .linearGradient(
                                colors: [.clear, .white.opacity(0.75), .clear, .white.opacity(0.75), .clear],
                                startPoint: .topLeading,
                                endPoint: UnitPoint(x: abs(translation.width / 100 + 0.5), y: abs(translation.height / 100 + 0.5))
                            )
                        )
                }
                .overlay(
                    LinearGradient(
                        colors: [Color(#colorLiteral(red: 0.3647058824, green: 0.06666666667, blue: 0.968627451, alpha: 0.5)), Color(#colorLiteral(red: 0.3647058824, green: 0.06666666667, blue: 0.968627451, alpha: 0.5))],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                        .blendMode(.overlay)
                )
                .clipShape(.rect(cornerRadius: 50))
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(.black)
                        .offset(y: 50)
                        .blur(radius: 50)
                        .opacity(0.5)
                        .blendMode(.overlay)
                )
                .offset(translation)
                .padding(20)
                .rotation3DEffect(.degrees(isDragging ? 20 : 0), axis: (-translation.height, translation.width, 0))
                .gesture(DragGesture()
                    .onChanged { value in
                        translation = value.translation
                        isDragging = true
                    }
                    .onEnded { value in
                        withAnimation(.easeInOut(duration: 0.5)) {
                            translation = .zero
                            isDragging = false
                        }
                    }
                )
        }
    }
}

private extension CardReflectionView {
    var glass1: some View {
        Image(.gloss1)
            .resizable()
            .scaledToFill()
            .mask {
                LinearGradient(
                    colors: [.clear, .white, .clear, .white, .clear, .white, .clear],
                    startPoint: .topLeading,
                    endPoint: UnitPoint(x: abs(translation.height / 100 + 1), y: abs(translation.height / 100 + 1))
                )
                .frame(width: 392)
            }
    }
    
    var glass2: some View {
        Image(.gloss2)
            .resizable()
            .scaledToFill()
            .mask {
                LinearGradient(
                    colors: [.clear, .white, .clear, .white, .clear, .white, .clear],
                    startPoint: .topLeading,
                    endPoint:  UnitPoint(x: abs(translation.height / 100 + 1), y: abs(translation.height / 100 + 1))
                )
                .frame(width: 392)
            }
    }
}

#Preview {
    CardReflectionView()
}
