//
//  DownloadingImageView.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 19.10.2023.
//

import SwiftUI

struct DownloadingImageView: View {
    
    @StateObject private var loader: ImageLoadingViewModel
    
    init(url: String, imageKey: String) {
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url, imageKey: imageKey))
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
            }
        }
        .frame(width: 70, height: 70)
    }
}

#Preview {
    DownloadingImageView(url: "https://via.placeholder.com/600/92c952", imageKey: "1231")
}
