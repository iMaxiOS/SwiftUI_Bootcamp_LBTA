//
//  RadialLayoutView.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 22.05.2024.
//

import SwiftUI

struct RadialLayoutView: View {
    private let icons = ["calendar", "message", "figure.walk", "music.note"]
    private let numbers = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var isRadial: Bool = true
    @State private var hour = 0
    @State private var minute = 0
    
    var body: some View {
        
        let layout = isRadial ? AnyLayout(RadialLayout()) : AnyLayout(CustomLayout())
        
        ZStack {
            Rectangle()
                .fill(.gray.gradient)
                .ignoresSafeArea()
            
            clockCase
            
            layout {
                ForEach(icons, id: \.self) { item in
                    Circle()
                        .frame(width: 44)
                        .foregroundStyle(.primary)
                        .overlay {
                            Image(systemName: item)
                                .foregroundStyle(Color(.systemBackground))
                    }
                }
            }
            .frame(width: 120 )
            
            layout {
                ForEach(numbers, id: \.self) { item in
                    Text("\(item)")
                        .font(.system(.title, design: .rounded)).bold()
                        .foregroundStyle(.primary)
                        .offset(x: isRadial ? 0 : 50)
                }
            }
            .frame(width: 240)
            
            layout {
                ForEach(numbers, id: \.self) { item in
                    Text("\(item * 5)")
                        .font(.system(.caption, design: .rounded))
                        .foregroundStyle(.primary)
                        .offset(x: isRadial ? 0 : 100)
                }
            }
            .frame(width: 360)
            
            clockHands
        }
        .onTapGesture {
            withAnimation(.spring) {
                isRadial.toggle()
            }
        }
        .onAppear {
            hour = 360
            minute = 360
        }
//        .onReceive(timer, perform: { _ in
//            if minute >= 360 {
//                hour += 6
//            }
//            minute += 6
//        })
    }
}

private extension RadialLayoutView {
    var clockCase: some View {
        ZStack {
            Circle()
                .foregroundStyle(
                    .white
                        .shadow(.inner(color: .gray, radius: 30, x: 30, y: 30))
                        .shadow(.inner(color: .white.opacity(0.2), radius: 0, x: 1, y: 1))
                        .shadow(.inner(color: .black.opacity(0.2), radius: 0, x: -1, y: -1))
                )
                .frame(width: 360)
            
            Circle()
                .foregroundStyle(
                    .white
                        .shadow(.inner(color: .gray, radius: 30, x: -30, y: -30))
                        .shadow(.drop(color: .black.opacity(0.3), radius: 30, x: 30, y: 30))
                )
                .frame(width: 320)
            
            Circle()
                .foregroundStyle(.white.shadow(.inner(color: .gray, radius: 30, x: 30, y: 30)))
                .frame(width: 280)
        }
    }
    
    var clockHands: some View {
        ZStack {
            Circle()
                .strokeBorder(style: StrokeStyle(lineWidth: 10, dash: [1, 10]))
                .frame(width: 220)
            
            RoundedRectangle(cornerRadius: 1)
                .foregroundStyle(.red)
                .frame(width: 2, height: 100)
                .overlay {
                    RoundedRectangle(cornerRadius: 1)
                        .stroke().fill(.white)
                }
                .offset(y: -50)
                .rotationEffect(.degrees(Double(minute)))
                .animation(.linear(duration: 12).repeatCount(12, autoreverses: false), value: minute)
            
            RoundedRectangle(cornerRadius: 4)
                .foregroundStyle(.black)
                .frame(width: 8, height: 70)
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke().fill(.white)
                }
                .offset(y: -32)
                .rotationEffect(.degrees(Double(hour)))
                .shadow(radius: 5, y: 5)
                .animation(.linear(duration: 120), value: hour)
                .overlay {
                    Circle()
                        .foregroundStyle(.white)
                        .frame(width: 3)
                }
        }
    }
}

struct CustomLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        for (index, subview) in subviews.enumerated() {
            var point = CGPoint(x: 20 * index, y: 20 * index).applying(
                CGAffineTransform(rotationAngle: CGFloat(6 * index + 6))
            )
            
            point.x += bounds.midX
            point.y += bounds.midY
            
            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}

struct RadialLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        
        let radius = bounds.width / 3.0
        let angle = Angle.degrees(Double(360 / subviews.count)).radians
        
        
        for (index, subview) in subviews.enumerated() {
            var point = CGPoint(x: 0, y: -radius).applying(
                CGAffineTransform(rotationAngle: angle * Double(index))
            )
            
            point.x += bounds.midX
            point.y += bounds.midY
            
            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}

#Preview {
    RadialLayoutView()
}
