//
//  MaskBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 28.10.2022.
//

import SwiftUI

struct MaskBootcamp: View {
    
    @State private var offset: CGSize = .zero
    @State private var rating: Int = 0
    
    var body: some View {
        ZStack {
            ratingStar
                .overlay {
                    overlayView
                        .mask(ratingStar)
                }
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geomentry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(LinearGradient(colors: [Color.yellow, Color.red], startPoint: .leading, endPoint: .trailing))
                    .frame(width: CGFloat(rating) / 5 * geomentry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var ratingStar: some View {
        HStack(spacing: 10) {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        withAnimation {
                            rating = index
                        }
                    }
            }
        }
    }
}

struct MaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MaskBootcamp()
    }
}
