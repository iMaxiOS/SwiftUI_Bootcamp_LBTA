//
//  CustomCurvesBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 02.11.2023.
//

import SwiftUI

struct Curve: Shape {
    var heightSize: CGFloat
    
    var animatableData: CGFloat {
        get { heightSize }
        set { heightSize = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            ///Arc shape
            
//            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
//            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.height / 2, startAngle: Angle.degrees(180), endAngle: Angle.degrees(0), clockwise: true)
            
            
            ///Shape with Arc
            
//            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
//            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
//            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
//            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: 150, startAngle: .degrees(0), endAngle: .degrees(180), clockwise: false)
//            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))

            ///Quad Curve shape

//            path.move(to: .zero)
//            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY),
//                              control: CGPoint(x: rect.minX, y: rect.maxY))
//            path.addQuadCurve(to: CGPoint(x: rect.minX, y: .zero),
//                              control: CGPoint(x: rect.maxX, y: .zero))
            
            ///Water quad curve shape
            
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY),
                              control: CGPoint(x: rect.width * 0.25, y: rect.height * heightSize))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY),
                              control: CGPoint(x: rect.width * 0.75, y: rect.height * heightSize))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}

struct CustomCurvesBootcamp: View {
    @State private var animation: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack(alignment: .bottom) {
                Curve(heightSize: animation ? 0.4 : 0.55)
                    .fill(
                        LinearGradient(colors: [Color.blueCircle, Color.blue],
                                       startPoint: .topLeading,
                                       endPoint: .trailing)
                    )
                Curve(heightSize: animation ? 0.4 : 0.55)
                    .fill(
                        LinearGradient(colors: [Color.yellow.opacity(0.7), Color.yellow],
                                       startPoint: .topLeading,
                                       endPoint: .trailing)
                    )
                    .frame(height: 300)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 600)
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.smooth.repeatForever()) {
                animation.toggle()
            }
        }
    }
}

#Preview {
    CustomCurvesBootcamp()
}
