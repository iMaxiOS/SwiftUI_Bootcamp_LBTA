//
//  DragGestureBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 27.10.2022.
//

import SwiftUI

struct DragGestureBootcamp: View {
    
    @State private var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            
            VStack {
                Text("\(offset.width)")
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 300, height: 500)
                .offset(offset)
                .scaleEffect(getScaleAmount())
                .rotationEffect(Angle(degrees: getRotationAmount()))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                                offset = value.translation
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                offset = .zero
                            }
                        }
            )
        }
    }
    
    private func getScaleAmount() -> CGFloat {
        let width = UIScreen.main.bounds.width / 2
        let currect = abs(offset.width)
        let percantage = currect / width
        return 1 - min(percantage, 0.5) * 0.5
    }
    
    private func getRotationAmount() -> Double {
        let width = UIScreen.main.bounds.width / 2
        let currect = offset.width
        let percantage = currect / width
        let percantageAsDouble = Double(percantage)
        let maxRotation: Double = 10.0
        return percantageAsDouble * maxRotation
        
    }
}

struct DragGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBootcamp()
    }
}
