//
//  CircleLabelView.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 27.05.2024.
//

import SwiftUI

struct CircleLabelView: View {
    private let text = "Latitude 25.0865 E • Longitude 21.4565 W • Elevation 64M • Incline 12 •".uppercased()
    private let degress: Double = 5
    
    var diameter: CGFloat = 300
    
    var body: some View {
        ZStack {
            ForEach(Array(text.enumerated()), id: \.offset) { index, letter in
                VStack {
                    Text("\(letter)")
                        .foregroundStyle(.white)
                    Spacer()
                }
                .rotationEffect(.degrees(degress * Double(index)))
            }
        }
        .frame(width: diameter, height: diameter)
        .font(.system(size: 13, weight: .bold, design: .monospaced))
    }
}

#Preview {
    CompassView()
}
