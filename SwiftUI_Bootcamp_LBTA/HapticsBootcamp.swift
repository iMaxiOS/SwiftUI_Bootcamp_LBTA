//
//  HapticsBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 04.11.2022.
//

import SwiftUI

final class HapticsManager {
    
    static let instance = HapticsManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticsBootcamp: View {
    var body: some View {
        VStack(spacing: 10) {
            Button("Success") { HapticsManager.instance.notification(type: .success) }
            Button("Warning") { HapticsManager.instance.notification(type: .warning) }
            Button("Error") { HapticsManager.instance.notification(type: .error) }
            Divider()
            Button("Soft") { HapticsManager.instance.impact(style: .soft) }
            Button("Light") { HapticsManager.instance.impact(style: .light) }
            Button("Medium") { HapticsManager.instance.impact(style: .medium) }
            Button("Rigid") { HapticsManager.instance.impact(style: .rigid) }
            Button("Heave") { HapticsManager.instance.impact(style: .heavy) }
        }
        .padding()
    }
}

struct HapticsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HapticsBootcamp()
    }
}
