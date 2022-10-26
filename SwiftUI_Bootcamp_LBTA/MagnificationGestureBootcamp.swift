//
//  MagnificationGestureBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 26.10.2022.
//

import SwiftUI

struct MagnificationGestureBootcamp: View {
    
    @State var currentValue: CGFloat = 0.0
    @State var lastValue: CGFloat = 0.0
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Circle()
                    .frame(width: 35, height: 35)
                Text("Swiftui Leran")
                    .font(.title2)
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentValue)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            currentValue += value - 1
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                currentValue = 0                                
                            }
                        }
                )
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "heart.fill")
                    Image(systemName: "text.bubble.fill")
                    Spacer()
                }
                
                Text("This is the caption for my photo!")
            }
            .padding(.horizontal)
        }
        
        
        
        
        
//        Text("Hello, World!")
//            .font(.title)
//            .padding(40)
//            .background(Color.red.opacity(0.5).cornerRadius(10))
//            .scaleEffect(1 + currentValue + lastValue)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged { value in
//                        currentValue = value - 1
//                    }
//                    .onEnded { value in
//                        lastValue += currentValue
//                        currentValue = 0
//                    }
//            )

    }
}

struct MagnificationGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureBootcamp()
    }
}
