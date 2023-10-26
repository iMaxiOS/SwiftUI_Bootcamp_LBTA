//
//  RotationGestureBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 27.10.2022.
//

import SwiftUI

struct RotationGestureBootcamp: View {
    
    @State private var angle: Angle = Angle(degrees: 0)
    
    var body: some View {
        Text("Hello, World!")
            .padding(50)
            .font(.system(.title, weight: .bold))
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(10)
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged { value in
                        angle = value
                    }
                    .onEnded { value in
                        withAnimation(.snappy) {
                            angle = Angle(degrees: 0)
                        }
                    }
            )
    }
}

struct RotationGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureBootcamp()
    }
}
