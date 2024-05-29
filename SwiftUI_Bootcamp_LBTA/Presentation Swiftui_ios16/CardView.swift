//
//  CardView.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 22.05.2024.
//

import SwiftUI

struct CardView: View {
    
    var body: some View {
        Grid {
            GridRow {
                card
                card
            }
            
            GridRow {
                card.gridCellColumns(2)
            }
            
            GridRow {
                card
                card
            }
        }
        .padding(20)
    }
}

private extension CardView {
    var card: some View {
        VStack {
            Image(systemName: "aspectratio")
                .frame(width: 44, height: 44)
                .foregroundStyle(
                    .linearGradient(
                        colors: [.white, .clear],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .background(
                    IconSVG()
                        .stroke(
                            .linearGradient(
                                colors: [.white.opacity(0.5), .clear],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .background(
                    IconSVG()
                        .foregroundStyle(
                            .linearGradient(
                                colors: [.clear, .white.opacity(0.3)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
            
            Text("Up to 8k Resolution".uppercased())
                .font(.title3.width(.condensed))
            Text("From huge monitors to the phone, your wallpaper will look great anywhere.")
                .font(.footnote)
                .opacity(0.7)
                .frame(maxWidth: .infinity)
        }
        .frame(maxHeight: .infinity)
        .padding().padding(.vertical)
        .background(.black)
        .foregroundStyle(.white)
        .clipShape(.rect(cornerRadius: 20))
        .multilineTextAlignment(.center)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke()
                .fill(.white.opacity(0.2))
        }
    }
}

#Preview {
    CardView()
}
