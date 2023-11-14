//
//  TimelineViewBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 14.11.2023.
//

import SwiftUI

struct TimelineViewBootcamp: View {
    @State private var pauseAnimation: Bool = false
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 1, paused: pauseAnimation)) { context in
            let seconds = Calendar.current.component(.second, from: context.date)
            
            Text(seconds.description)
                .bold()
            
            RoundedRectangle(cornerRadius: 10)
                .frame(
                    width: seconds < 10 ? 50 : seconds < 20 ? 100 : 150,
                    height: seconds < 10 ? 50 : seconds < 20 ? 100 : 150
                )
                .frame(height: 300)
                .rotationEffect(.degrees(seconds < 10 ? 50 : seconds < 20 ? 100 : 150))
                .animation(.spring, value: seconds)
        }
        
        Button {
            withAnimation(.spring) {
                pauseAnimation.toggle()
            }
        } label: {
            Text(pauseAnimation ? "PAUSE" : "PLAY")
        }
        .modifier(ButtonModifier())

    }
}

#Preview {
    TimelineViewBootcamp()
}
