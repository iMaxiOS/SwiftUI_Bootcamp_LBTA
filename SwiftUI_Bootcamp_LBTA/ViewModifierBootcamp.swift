//
//  ViewModifierBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 01.11.2023.
//

import SwiftUI

struct DefaultViewModifier: ViewModifier {
    var color: Color
    var bg: Color
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(color)
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
            .modifier(DefaultViewModifier(color: .white, bg: .pink))
        
        Text("Hello, World!")
            .modifier(DefaultViewModifier(color: .white, bg: .red))
        
        Text("Hello!!!!")
            .modifier(DefaultViewModifier(color: .pink, bg: .yellow))
    }
}

#Preview {
    ViewModifierBootcamp()
}
