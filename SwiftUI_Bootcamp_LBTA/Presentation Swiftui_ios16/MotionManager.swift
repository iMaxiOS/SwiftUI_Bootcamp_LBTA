//
//  MonitoManager.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 24.05.2024.
//

import CoreMotion

final class MotionManager: ObservableObject {
    @Published var pinch: Double = 0.0
    @Published var roll: Double = 0.0
    @Published var rotation: Double = 0.0
    
    var motion: CMMotionManager
    
    init() {
        motion = CMMotionManager()
        motion.deviceMotionUpdateInterval = 1/60
        motion.startDeviceMotionUpdates(to: .main) { motionData, error in
            guard error == nil else { return }
            
            if let motionData = motionData {
                self.pinch = motionData.attitude.pitch
                self.roll = motionData.attitude.roll
                self.rotation = motionData.rotationRate.x
            }
        }
    }
}
