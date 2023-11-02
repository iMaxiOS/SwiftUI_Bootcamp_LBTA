//
//  CustomShapeBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 02.11.2023.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            
//            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
//            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
//            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            let horizontalOffset = rect.width * 0.2
//            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
//            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
//            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
//            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
//            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            
            path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + horizontalOffset))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - horizontalOffset))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX , y: rect.maxY - horizontalOffset))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + horizontalOffset))
        }
    }
}

struct CustomShapeBootcamp: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 300, height: 300)
                .clipShape(Triangle())
        }
    }
}

#Preview {
    CustomShapeBootcamp()
}
