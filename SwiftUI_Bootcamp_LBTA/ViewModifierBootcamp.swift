//
//  ViewModifierBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 01.11.2023.
//

import SwiftUI

struct DefaultViewModifier: ViewModifier {
    var foreground: Color
    var bg: Color
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(foreground)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(bg)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(radius: 10)
            .padding()
    }
}

struct ViewModifierBootcamp: View {
    var body: some View {
        Text("Hello, everyone!")
            .modifier(DefaultViewModifier(foreground: .white, bg: .pink))
        
        Text("Hello, World!")
            .modifier(DefaultViewModifier(foreground: .white, bg: .red))
        
        Text("Hello!!!!")
            .modifier(DefaultViewModifier(foreground: .pink, bg: .yellow))
    }
}

#Preview {
    ViewModifierBootcamp()
}
