//
//  UserDefaults.swift
//  SharkVPN
//
//  Created by Alena Klysa on 18.10.2022.
//

import Foundation

extension UserDefaults {
    
    func valueExists(forKey key: String) -> Bool {
        return object(forKey: key) == nil
    }
    
}
