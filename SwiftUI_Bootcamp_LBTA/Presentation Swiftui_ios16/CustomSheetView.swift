//
//  CustomSheetView.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 27.05.2024.
//

import SwiftUI

struct CustomSheetView: View {
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 30) {
                Text("Incline\n".uppercased()).font(.caption) + Text("20º")
                Text("Elevation\n".uppercased()).font(.caption) + Text("64Mº")
                Text("Latitude\n".uppercased()).font(.caption) + Text("35.0858 E")
                Text("Longitude\n".uppercased()).font(.caption) + Text("48.1244 W")
                
                arrow
                Spacer()
            }
            .fontWeight(.medium)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(40)
        .background(.black.opacity(0.5))
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white.opacity(0.2))
                .frame(width: 40, height: 5)
                .frame(maxHeight: .infinity, alignment: .top)
                .offset(y: 10)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .strokeBorder(
                    .linearGradient(colors: [.white.opacity(0.2), .clear], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
        )
        .clipShape(.rect(cornerRadius: 50))
    }
}

private extension CustomSheetView {
    var arrow: some View {
        ZStack {
            Circle().strokeBorder(.primary.opacity(0.4), style: StrokeStyle(lineWidth: 5, dash: [1, 2]))
            
            Circle().strokeBorder(.primary.opacity(0.4), style: StrokeStyle(lineWidth: 15, dash: [1, 60]))
            
            Image(.arrow)
        }
        .frame(width: 93, height: 93)
    }
}

#Preview {
    CustomSheetView()
}
