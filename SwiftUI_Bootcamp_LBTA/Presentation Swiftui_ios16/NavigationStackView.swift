//
//  NavigationStackView.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 22.05.2024.
//

import SwiftUI

struct NavigationStackView: View {
    var body: some View {
        NavigationStack {
            List(navigationItems) { item in
                NavigationLink(value: item) {
                    Label(item.title, systemImage: item.icon)
                        .foregroundStyle(.primary)
                }
            }
            .navigationDestination(for: NavigationItem.self) { item in
                NavigationDestination(item)
            }
            .navigationTitle("Presentation App")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
        }
    }
}

private extension NavigationStackView {
    @ViewBuilder
    func NavigationDestination(_ item: NavigationItem) -> some View {
        switch item.menu {
        case .compass: ContentView()
        case .card: ContentView()
        case .charts: ContentView()
        case .radial: ContentView()
        case .actionbutton: ContentView()
        }
    }
}

#Preview {
    NavigationStackView()
}
