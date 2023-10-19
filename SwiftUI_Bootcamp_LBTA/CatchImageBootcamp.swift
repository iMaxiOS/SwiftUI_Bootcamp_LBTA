//
//  CatchImageBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 19.10.2023.
//

import SwiftUI

final class CacheManager {
    static let shared = CacheManager()
    
    init() {}
    
    let imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100mb
        return cache
    }()
    
    func add(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "Successful, image put to cache!!"
    }
    
    func delete(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Successful, image delete from cache!!"
    }
    
    func get(name: String) -> UIImage? {
        guard let image = imageCache.object(forKey: name as NSString) else { return nil }
        return image
    }
}

final class CatchViewModel: ObservableObject {
    
    @Published var startingImage: UIImage? = nil
    @Published var infoMessage: String = ""
    
    private let manager = CacheManager.shared
    let nameImage: String = "USA"
    
    init() {
        getImageFromAssetsFolder()
    }
    
    private func getImageFromAssetsFolder() {
        startingImage = UIImage(named: nameImage)
    }
    
    func saveImageToCache() {
        if let image = startingImage {
            infoMessage = manager.add(image: image, name: nameImage)
        } else {
            infoMessage = "Error: Image not found!!!"
        }
    }
    
    func getImageFromCache() {
        if let image = manager.get(name: nameImage) {
            infoMessage = "Successful, get image from cache!!"
            startingImage = image
        } else {
            infoMessage = "Failed, Image not found in Cache!!!"
        }
    }
    
    func deleteImageFromCache() {
        infoMessage = manager.delete(name: nameImage)
    }
    
    func clearImage() {
        startingImage = nil
    }
    
}

struct CatchImageBootcamp: View {
    
    @StateObject private var vm = CatchViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 200)
                        .clipShape(.rect(cornerRadius: 10))
                } else {
                    Spacer()
                        .frame(height: 200)
                }
                
                Text(vm.infoMessage)
                    .font(.headline)
                    .font(.system(size: 40))
                    .foregroundStyle(.red)
                
                VStack {
                    HStack {
                        Button {
                            vm.saveImageToCache()
                        } label: {
                            Text("Save to Catch")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.blue)
                                .clipShape(.rect(cornerRadius: 10))
                        }
                        
                        Button {
                            vm.getImageFromCache()
                        } label: {
                            Text("Get from Cache")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.blue)
                                .clipShape(.rect(cornerRadius: 10))
                        }
                        
                    }
                    
                    HStack {
                        Button {
                            vm.deleteImageFromCache()
                        } label: {
                            Text("Delete from Catch")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.red)
                                .clipShape(.rect(cornerRadius: 10))
                        }
                        
                        Button {
                            vm.clearImage()
                        } label: {
                            Text("Clear image")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.gray)
                                .clipShape(.rect(cornerRadius: 10))
                        }
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Catch Bootcamp")
        }
    }
}

#Preview {
    CatchImageBootcamp()
}
