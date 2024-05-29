//
//  ContentView.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 21.05.2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedMenu") private var selectedMenu: NavigationItem.Menu = .compass
    
    @State private var showMenu = false
    @State private var completedLongPress = false
    @GestureState private var isDetectingLongPress = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            switch selectedMenu {
            case .compass: CompassView(isShow: $showMenu)
            case .card: CardView()
            case .charts: ChartView()
            case .radial: RadialLayoutView()
            case .actionbutton: ActionButtonView()
            }
        }
        .overlay(MessageView())
        .onTapGesture {}
        .gesture(longPress)
        .sheet(isPresented: $showMenu, content: {
            MenuView()
                .presentationDetents([.medium, .large])
        })
    }
}

private extension ContentView {
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 1)
            .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                gestureState = currentState
                transaction.animation = Animation.easeIn(duration: 2.0)
            }
            .onEnded { finished in
                showMenu = true
            }
    }
}

#Preview {
    ContentView()
}
