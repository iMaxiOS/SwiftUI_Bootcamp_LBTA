//
//  DownloadingImagesViewModel.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 19.10.2023.
//

import SwiftUI

@MainActor
final class DownloadingImagesViewModel: ObservableObject {
    @Published var arrayModel: [ImageResponse] = []
    
    private let manager = DownloadingImagesNetworkManager.shared
    let urlLink = "https://jsonplaceholder.typicode.com/photos"
    
    init() {}
    
    func fetchImages() async {
        guard let url = URL(string: urlLink) else { return }
        
        manager.fetch(url: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                self.arrayModel = response
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func downloadingImages() async {
        guard let url = URL(string: urlLink) else { return }
        
        manager.downloadData(url: url) { [weak self] data in
            self?.arrayModel = data
        }
    }
}
