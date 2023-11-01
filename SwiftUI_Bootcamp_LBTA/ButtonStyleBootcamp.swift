//
//  ButtonStyleBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 01.11.2023.
//

import SwiftUI

struct DefaultButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .brightness(configuration.isPressed ? 0.05 : 0)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
    }
}

struct ButtonStyleBootcamp: View {
    var body: some View {
        Button(action: {}, label: {
            Text("Click me")
                .modifier(DefaultViewModifier(foreground: .white, bg: .blue))
        })
        .buttonStyle(DefaultButtonStyle())
        .padding(40)
    }
}

#Preview {
    ButtonStyleBootcamp()
}
