//
//  Constants.swift
//  SharkVPN
//
//  Created by Maxim Hranchenko on 31.10.2022.
//

import Foundation
import SwiftUI

struct Constants {
    static let widthScreen = UIScreen.main.bounds.width
    static let heightScreen = UIScreen.main.bounds.height
    static let smallDevice = UIScreen.main.bounds.width < 375
    static let device_5_5s_5SE = UIScreen.main.bounds.width == 320
    static let device_6_6s_7_8 = UIScreen.main.bounds.width == 375
}

//MARK: - Fonts
extension Font {
    struct Lato {
        static let black = "Lato-Black"
        static let blackItalic = "Lato-BlackItalic"
        static let bold = "Lato-Bold"
        static let boldItalic = "Lato-BoldItalic"
        static let italic = "Lato-Italic"
        static let light = "Lato-Light"
        static let lightItalic = "Lato-LightItalic"
        static let regular = "Lato-Regular"
        static let thin = "Lato-Thin"
        static let thinItalic = "Lato-ThinItalic"
    }
}
