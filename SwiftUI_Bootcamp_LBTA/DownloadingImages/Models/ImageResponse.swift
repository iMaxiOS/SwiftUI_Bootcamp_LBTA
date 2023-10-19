//
//  ImageResponse.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 19.10.2023.
//

import Foundation

struct ImageResponse: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: URL?
    let thumbnailUrl: URL?
    
    var urlString: String {
        return url?.absoluteString ?? ""
    }
}
