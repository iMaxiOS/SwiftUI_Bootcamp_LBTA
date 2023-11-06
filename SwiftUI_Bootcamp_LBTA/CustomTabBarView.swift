//
//  CustomTabBarView.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 06.11.2023.
//

import SwiftUI

struct TabBarItem: Hashable {
    let icon: String
    let title: String
    let color: Color
}

struct TabBarItemPreferenceKey: PreferenceKey {
    static var defaultValue: [TabBarItem] = []
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
}

struct TabBarItemViewModifier : ViewModifier {
    let tab: TabBarItem
    @Binding var selection: TabBarItem
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1 : 0)
            .preference(key: TabBarItemPreferenceKey.self, value: [tab])
    }
}

struct CustomTabBarContainerView<Content: View>: View {
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                content
            }
            .ignoresSafeArea()
            
            CustomTabBar(tabs: tabs, selection: $selection)
        }
        .onPreferenceChange(TabBarItemPreferenceKey.self, perform: { value in
            tabs = value
        })
    }
}

struct CustomTabBar: View {
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
            }
        }
    }
}

struct CustomTabBarView: View {
    
    @State var selection: TabBarItem = TabBarItem(icon: "house.fill", title: "Home", color: .green)
    
    var body: some View {
        CustomTabBarContainerView(selection: $selection) {
            Color.red
                .tabBarItem(tab: .init(icon: "house.fill", title: "Home", color: .green), selection: $selection)
            
            Color.green
                .tabBarItem(tab: .init(icon: "heart.fill", title: "Heart", color: .red), selection: $selection)
            
            Color.yellow
                .tabBarItem(tab: .init(icon: "gear", title: "Settings", color: .black), selection: $selection)
        }
    }
}

extension View {
    func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}

extension CustomTabBar {
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.icon)
                .font(.subheadline)
            Text(tab.title)
                .font(.caption2)
        }
        .padding(.vertical, 4)
        .foregroundStyle(selection == tab ? tab.color : .gray)
        .frame(maxWidth: .infinity)
        .background(selection == tab ? tab.color.opacity(0.2) : .clear)
        .clipShape(.rect(cornerRadius: 10))
        .onTapGesture {
            withAnimation(.smooth) {
                selection = tab
            }
        }
    }
}

#Preview(body: {
    CustomTabBarView()
})
