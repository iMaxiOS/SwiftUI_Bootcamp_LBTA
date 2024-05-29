//
//  CompassView.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 24.05.2024.
//

import SwiftUI
import CoreLocationUI

struct CompassView: View {
    @ObservedObject private var locationManager = LocationManager()
    
    @State private var location: CGPoint = .zero
    @State private var isDragging = false
    @State private var show = false
    
    @Binding var isShow: Bool
    
    var body: some View {
        ZStack {
            background
            outerCircles
                .rotation3DEffect(.degrees(show ? 26 : 0), axis: (x: 1.0, y: 0.0, z: 0.0))
            innerCircles
                .rotation3DEffect(.degrees(show ? 15 : 0), axis: (x: 1.0, y: 0.0, z: 0.0))
            
            if !show { fleshLight }
            
            waypoints
                .rotationEffect(.degrees(locationManager.degrees))
                .scaleEffect(show ? 0.9 : 1)
            circleLabel
                .rotation3DEffect(.degrees(show ? 10 : 0), axis: (x: 1.0, y: 0.0, z: 0.0))
            stroks
                .rotation3DEffect(.degrees(show ? 15 : 0), axis: (x: 1.0, y: 0.0, z: 0.0))
            light
            title
            sheet
        }
        .overlay { if !show { buttons} }
        .onTapGesture {
            withAnimation {
                show.toggle()
            }
        }
        .gesture(drag)
    }
}

private extension CompassView {
    
    var buttons: some View {
        HStack(spacing: 40) {
            ButtonViewOnTapped(image: "menucard") {
                isShow = true
            }
            ButtonView()
            ButtonViewOnTapped(image: "house") {
                isShow = true
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom, 40)
    }
    
    var sheet: some View {
        CustomSheetView()
            .offset(y: show ? 340 : 1000)
    }
    
    var title: some View {
        VStack {
            Text("\(String(format: "%.0f", locationManager.degrees))º \(compassDirection(locationManager.degrees))")
                .font(.title)
            Text("San Francisco".uppercased())
            
            if let myLocation = locationManager.location {
                Text(
                    "Latitude: \(myLocation.latitude.formatted(.number.precision(.fractionLength(2)))), Longiture: \(myLocation.longitude.formatted(.number.precision(.fractionLength(2))))"
                )
            } else {
                LocationButton {
                    locationManager.requestLocation()
                }
                .labelStyle(.iconOnly)
                .clipShape(.rect(cornerRadius: 20))
            }
        }
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    var stroks: some View {
        ZStack {
            Circle().strokeBorder(gradient, style: StrokeStyle(lineWidth: 5, dash: [1, 1]))
            Circle().strokeBorder(gradient, style: StrokeStyle(lineWidth: 10, dash: [1, 6]))
            Circle().strokeBorder(gradient, style: StrokeStyle(lineWidth: 15, dash: [1, 62]))
        }
        .frame(width: 315)
    }
    
    var circleLabel: some View {
        CircleLabelView(diameter: 225)
            .offset(x: 1)
    }
    
    var waypoints: some View {
        ZStack {
            Circle()
                .fill(.blue)
                .frame(width: 16)
                .offset(x: 100, y: 210)
            Circle()
                .fill(.red)
                .frame(width: 16)
                .offset(x: -120, y: -200)
            Circle()
                .fill(.green)
                .frame(width: 16)
                .offset(x: 100, y: -150)
        }
        .rotationEffect(.degrees(locationManager.degrees))
    }
    
    var fleshLight: some View {
        GeometryReader { proxy in
            Circle()
                .foregroundStyle(
                    .radialGradient(
                        colors: [.white.opacity(0.1), .clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 200
                    )
                )
                .offset(
                    x: location.x - proxy.size.width / 2,
                    y: location.y - proxy.size.height / 2
                )
                .frame(
                    width: proxy.frame(in: .global).width,
                    height: proxy.frame(in: .global).height
                )
                .opacity(isDragging ? 1 : 0)
            Circle()
                .foregroundStyle(
                    .radialGradient(
                        colors: [.white, .clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 200
                    )
                )
                .offset(
                    x: location.x - proxy.size.width / 2,
                    y: location.y - proxy.size.height / 2
                )
                .frame(
                    width: proxy.frame(in: .global).width,
                    height: proxy.frame(in: .global).height
                )
                .opacity(isDragging ? 1 : 0)
                .mask(
                    ZStack {
                        Circle().stroke().scaleEffect(1.2)
                        Circle().stroke().scaleEffect(1.5)
                        Circle().stroke().padding(20)
                        Circle().stroke().padding(80)
                        Circle().stroke().padding(100)
                        Circle().stroke().padding(120)
                        Circle().stroke().padding(145)
                        Circle().stroke().padding(170)
                        Group {
                            Text("Home")
                                .offset(x: 0, y: -210)
                                .rotationEffect(.degrees(-31))
                            Text("Tent")
                                .rotationEffect(.degrees(35))
                                .offset(x: 115, y: -170)
                            Text("Parked Car")
                                .rotationEffect(.degrees(150))
                                .offset(x: 80, y: 190)
                            Text("N")
                                .rotationEffect(.degrees(0))
                                .offset(x: 0, y: -135)
                            Text("E")
                                .rotationEffect(.degrees(90))
                                .offset(x: 135, y: 0)
                            Text("S")
                                .rotationEffect(.degrees(180))
                                .offset(x: 0, y: 135)
                            Text("W")
                                .rotationEffect(.degrees(270))
                                .offset(x: -135, y: 0)
                        }
                        .rotationEffect(.degrees(locationManager.degrees))
                    }
                        .frame(width: 393)
                )
        }
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                location = value.location
                isDragging = true
            }
            .onEnded { value in
                isDragging = false
            }
    }
    
    var light: some View {
        Circle()
            .trim(from: 0.6, to: 0.9)
            .stroke(
                .radialGradient(colors: [.white.opacity(0.2), .clear], center: .center, startRadius: 0, endRadius: 200),
                style: StrokeStyle(lineWidth: 200)
            )
            .frame(width: 200)
    }
    
    var innerCircles: some View {
        ZStack {
            innerCircle.padding(20)
            innerCircle2.padding(80)
            innerCircle3.padding(100)
            innerCircle4.padding(120)
            innerCircle4.padding(145)
            innerCircle4.padding(170)
            innerCircle5.padding(188)
        }
        .frame(width: 393)
    }
    
    var outerCircles: some View {
        ZStack {
            outerCircle.scaleEffect(show ? 1.5 : 1.2)
            outerCircle.scaleEffect(show ? 2 : 1.5)
        }
        .frame(width: 393)
    }
    
    var outerCircle: some View {
        Circle()
            .foregroundStyle(
                .linearGradient(
                    colors: [.black.opacity(0.5), .clear],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .shadow(.inner(color: .white.opacity(0.5), radius: 0, x: 0.5, y: 0.5))
            )
    }
    
    var innerCircle: some View {
        Circle()
            .foregroundStyle(
                .linearGradient(
                    colors: [.black, Color(#colorLiteral(red: 0.6196078431, green: 0.6274509804, blue: 0.7098039216, alpha: 1))],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .shadow(.inner(color: .white.opacity(0.25), radius: 0, x: 1, y: 1))
                .shadow(.drop(color: .black.opacity(0.25), radius: 0, x: 1, y: 1))
            )
    }
    
    var innerCircle2: some View {
        Circle()
            .foregroundStyle(
                .linearGradient(
                    colors: [.black.opacity(0.5), Color(#colorLiteral(red: 0.6196078431, green: 0.6274509804, blue: 0.7098039216, alpha: 1))],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .shadow(.drop(color: .white.opacity(0.25), radius: 0, x: 1, y: 1))
                .shadow(.inner(color: .black.opacity(0.25), radius: 0, x: 1, y: 1))
            )
    }
    
    var innerCircle3: some View {
        Circle()
            .foregroundStyle(
                .radialGradient(
                    colors: [.black, Color(#colorLiteral(red: 0.2970857024, green: 0.3072845936, blue: 0.4444797039, alpha: 1))],
                    center: .center,
                    startRadius: 0,
                    endRadius: 100
                )
                .shadow(.inner(color: .white.opacity(0.25), radius: 0, x: 1, y: 1))
                .shadow(.drop(color: .black.opacity(0.25), radius: 0, x: 1, y: 1))
            )
    }
    
    var innerCircle4: some View {
        Circle()
            .foregroundStyle(
                .linearGradient(
                    colors: [.black.opacity(0.5), .black.opacity(0.0)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .shadow(.inner(color: .white.opacity(0.5), radius: 0, x: 1, y: 1))
            )
    }
    
    var innerCircle5: some View {
        Circle()
            .foregroundStyle(.white)
    }
    
    var background: some View {
        RadialGradient(
            colors: [Color(#colorLiteral(red: 0.2970857024, green: 0.3072845936, blue: 0.4444797039, alpha: 1)), .black],
            center: .center,
            startRadius: 1,
            endRadius: 400
        )
        .ignoresSafeArea()
    }
    
    var gradient: LinearGradient {
        LinearGradient(colors: [Color(#colorLiteral(red: 0.6196078431, green: 0.6274509804, blue: 0.7098039216, alpha: 1)), .black], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

#Preview {
    CompassView(isShow: .constant(false))
}
