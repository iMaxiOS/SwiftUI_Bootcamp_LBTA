//
//  TaskGroupBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 25.10.2023.
//

import SwiftUI

final class TaskGroupNetworkManager {
    
    func fetchImagesAsyncLet() async throws -> [UIImage] {
        async let fetchImages1 = fetchImages(url: "https://picsum.photos/1024/1024/?blur=2")
        async let fetchImages2 = fetchImages(url: "https://picsu.photos/1024/1024/?blur=2")
        async let fetchImages3 = fetchImages(url: "https://picsum.photos/1024/1024/?blur=2")
        async let fetchImages4 = fetchImages(url: "https://picsum.photos/1024/1024/?blur=2")
        
        let (image1, image2, image3, image4) = await (try fetchImages1, try fetchImages2, try fetchImages3, try fetchImages4)
        
        return [image1, image2, image3, image4]
    }
    
    func fetchImagesWithGroup() async throws -> [UIImage] {
        return try await withThrowingTaskGroup(of: UIImage?.self) { [weak self] group in
            guard let self else { return [] }
            let url = "https://picsum.photos/1024/1024"
            var images: [UIImage] = []
            
            for _ in 1 ... 10 {
                group.addTask {
                    try await self.fetchImages(url: url)
                }
            }
            
            for try await image in group {
                if let image = image {
                    images.append(image)
                } else {
                    print("Error: loading image")
                }
            }
            
            return images
        }
    }
    
    func fetchImages(url: String) async throws -> UIImage {
        guard let url = URL(string: url) else { throw URLError(.badURL) }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
}

final class TaskGroupViewModel: ObservableObject {
    @Published var images: [UIImage] = []
    
    private let manager = TaskGroupNetworkManager()
    
    func fetchImages() async {
        do {
            images = try await manager.fetchImagesWithGroup()
        } catch {
            print(error)
        }
    }
}

struct TaskGroupBootcamp: View {
    
    @StateObject private var vm = TaskGroupViewModel()
    
    private let columns = [GridItem(.adaptive(minimum: 100, maximum: 200)), GridItem(.adaptive(minimum: 100, maximum: 200))]
                                                                                    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(vm.images, id: \.self) { item in
                        Image(uiImage: item)
                            .resizable()
                            .frame(height: 200)
                            .clipShape(.rect(cornerRadius: 10))
                            .clipped()
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Task Group!!")
            .task {
                await vm.fetchImages()
            }
        }
    }
}

#Preview {
    TaskGroupBootcamp()
}
