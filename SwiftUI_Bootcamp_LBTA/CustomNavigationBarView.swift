//
//  CustomNavigationBarView.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 06.11.2023.
//

import SwiftUI

struct NavTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

struct NavSubtitlePreferenceKey: PreferenceKey {
    static var defaultValue: String? = nil
    
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
}

struct NavButtonHiddenPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

struct AppNavBarView: View {
    var body: some View {
        CustomNavBar {
            ZStack {
                Color.orange.ignoresSafeArea()
                
                CustomNavLink(
                    destination: Text("Other screen")
                        .customTitle("Second Title")
                        .customSubtitle("Hello world!!!")
                ) {
                    Text("Push tap")
                }
                
            }
            .customTitle("Custom Title")
            .customSubtitle("Custom Subtitle!!!")
            .customHiddenButton(true)
        }
    }
}

struct CustomNavLink<Label: View, Destination: View>: View {
    
    let destination: Destination
    let label: Label
    
    init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        NavigationLink {
            CustomNavigationContainerView {
                destination
            }
            .navigationBarBackButtonHidden()
        } label: {
            label
        }
    }
}

struct CustomNavBar<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack {
            CustomNavigationContainerView {
                content
            }
            .navigationBarBackButtonHidden()
        }
    }
}

struct CustomNavigationBarView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let showBackButton: Bool
    let title: String
    let subtitle: String?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if showBackButton {
                    backButton
                }
                
                Spacer()
                titleView
                Spacer()
                
                if showBackButton {
                    backButton
                        .opacity(0)
                }
            }
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
        }
    }
}

struct CustomNavigationContainerView<Content: View>: View {
    
    let content: Content
    
    @State private var showBackButton: Bool = true
    @State private var title: String = ""
    @State private var subtitle: String? = nil
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBarView(showBackButton: showBackButton, title: title, subtitle: subtitle)
            
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onPreferenceChange(NavTitlePreferenceKey.self, perform: { value in
            self.title = value
        })
        .onPreferenceChange(NavSubtitlePreferenceKey.self, perform: { value in
            self.subtitle = value
        })
        .onPreferenceChange(NavButtonHiddenPreferenceKey.self, perform: { value in
            self.showBackButton = !value
        })
    }
}

extension CustomNavigationBarView {
    
    private var backButton: some View {
        Button {
            dismiss.callAsFunction()
        } label: {
            Image(systemName: "chevron.left")
                .bold()
        }
    }
    
    private var titleView: some View {
        VStack {
            Text(title)
                .font(.headline)
                .bold()
            
            if let subtitle {
                Text(subtitle)
            }
        }
    }
}

extension View {
    func customTitle(_ title: String) -> some View {
        preference(key: NavTitlePreferenceKey.self, value: title)
    }
    func customSubtitle(_ subtitle: String?) -> some View {
        preference(key: NavSubtitlePreferenceKey.self, value: subtitle)
    }
    func customHiddenButton(_ hidden: Bool) -> some View {
        preference(key: NavButtonHiddenPreferenceKey.self, value: hidden)
    }
    func customNavBarItems(title: String = "", subtitle: String? = nil, hidden: Bool = false) -> some View {
        self
            .customTitle(title)
            .customSubtitle(subtitle)
            .customHiddenButton(hidden)
    }
}

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}

#Preview {
    AppNavBarView()
}
