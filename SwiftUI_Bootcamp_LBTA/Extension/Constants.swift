//
//  Constants.swift
//  SharkVPN
//
//  Created by Maxim Hranchenko on 31.10.2022.
//

import SwiftUI

struct Constants {
    static let widthScreen = UIScreen.main.bounds.width
    static let heightScreen = UIScreen.main.bounds.height
    static let smallDevice = UIDevice.current.screenType == .iPhones_5_5s_5c_SE
    static let middleDevice = UIDevice.current.screenType == .iPhones_5_5s_5c_SE
    static let highDevice = UIDevice.current.screenType == .iPhones_5_5s_5c_SE
    
    static let safeAreaTop = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
    static let isSafeAreaTop = (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0) > 20
    
}
