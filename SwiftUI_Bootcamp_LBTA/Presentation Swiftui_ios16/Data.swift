//
//  Data.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 22.05.2024.
//

import Foundation

struct NavigationItem: Identifiable, Hashable {
    
    enum Menu: String {
        case compass, card, charts, radial, actionbutton
    }
    
    var id = UUID()
    var title: String
    var icon: String
    var menu: Menu
}

var navigationItems: [NavigationItem] = [
    .init(title: "Compass App", icon: "safari", menu: .compass),
    .init(title: "3D Card", icon: "lanyardcard", menu: .card),
    .init(title: "Charts", icon: "chart.xyaxis.line", menu: .charts),
    .init(title: "Radial Layout", icon: "clock", menu: .radial),
    .init(title: "Gooey Action Button", icon: "plus.circle", menu: .actionbutton),
]
