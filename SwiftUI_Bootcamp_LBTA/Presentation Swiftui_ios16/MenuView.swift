//
//  MenuView.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 22.05.2024.
//

import SwiftUI

struct MenuView: View {
    @AppStorage("selectedMenu") var selectedMenu: NavigationItem.Menu = .compass
    @Environment(\.dismiss) var isPresented
    
    var body: some View {
        List(navigationItems) { item in
            Button {
                selectedMenu = item.menu
                isPresented.callAsFunction()
            } label: {
                Label(item.title, systemImage: item.icon)
                    .foregroundStyle(.primary)
                    .padding(8)
            }
        }
        .listStyle(.plain)
    }
}

private extension MenuView {
    
}

#Preview {
    MenuView()
}
