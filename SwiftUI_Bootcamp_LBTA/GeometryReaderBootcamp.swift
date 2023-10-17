//
//  GeometryReaderBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 27.10.2022.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geomentry in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.pink)
                            .frame(height: 250)
                            .shadow(color: .gray, radius: 10)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geomentry) * 20),
                                axis: (x: 0, y: 1, z: 0)
                            )
                    }
                    .frame(width: 300, height: 270)
                    .padding(22)
                }
            }
        }
        
//        GeometryReader { geomentry in
//            HStack(spacing: 0) {
//                Rectangle()
//                    .fill(Color.blue)
//                    .frame(width: geomentry.size.width * 0.6666)
//
//                Rectangle()
//                    .fill(Color.red)
//            }
//            .ignoresSafeArea()
//        }
    }
    
    func random() -> Color {
        Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - currentX / maxDistance)
    }
}

struct GeometryReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderBootcamp()
    }
}
