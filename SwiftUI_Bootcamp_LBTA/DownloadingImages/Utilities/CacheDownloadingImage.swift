//
//  CacheDownloadingImage.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 19.10.2023.
//

import Foundation
import SwiftUI

final class CacheDownloadingImage {
    static let shared = CacheDownloadingImage()
    
    private var cacheImage: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200 // 200mb
        return cache
    }()
    
    func add(image: UIImage, name: String) {
        cacheImage.setObject(image, forKey: name as NSString)
    }
    
    func remove(name: String) {
        cacheImage.removeObject(forKey: name as NSString)
    }
    
    func get(name: String) -> UIImage? {
        if let image = cacheImage.object(forKey: name as NSString) {
            return image
        }
        
        return nil
    }
}
