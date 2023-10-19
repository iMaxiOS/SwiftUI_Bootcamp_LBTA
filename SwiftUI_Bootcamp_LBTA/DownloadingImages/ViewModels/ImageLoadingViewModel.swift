//
//  ImageLoadingViewModel.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 19.10.2023.
//

import Foundation
import SwiftUI
import Combine

final class ImageLoadingViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let manager = CacheDownloadingImage.shared
    private var cancellables = Set<AnyCancellable>()
    
    var url: String
    var imageKey: String
    
    init(url: String, imageKey: String) {
        self.url = url
        self.imageKey = imageKey
        
        getImage()
    }
    
    func getImage() {
        if let image = manager.get(name: imageKey) {
            self.image = image
        } else {
            downloadingImage()
        }
    }
    
    func downloadingImage() {
        isLoading = true

        guard let url = URL(string: self.url) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                self?.isLoading = false
            } receiveValue: { [weak self] image in
                guard let self, let image = image else { return }
                
                self.manager.add(image: image, name: self.imageKey)
                self.image = image
            }
            .store(in: &cancellables)

    }
}
