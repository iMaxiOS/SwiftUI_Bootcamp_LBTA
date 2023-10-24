//
//  DownloadImageUseAsyncAwaitBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 24.10.2023.
//

import SwiftUI
import Combine

private class DownloadImageUseAsyncAwaitNetworkManager {
    
    static let instance = DownloadImageUseAsyncAwaitNetworkManager()
    let url = URL(string: "https://picsum.photos/1024/1024/?blur=2")!
    
    func fetchWithImage(complition: @escaping(UIImage?, Error?) -> Void) {
        guard let url = URL(string: "https://picsum.photos/1024/1024/?blur=2") else { return }
        let request = URLRequest(url: url)
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil,
                  let data = data,
                  let image = UIImage(data: data),
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else {
                complition(nil, error)
                return
            }
            
                complition(image, nil)
        }
        
        session.resume()
    }
    
    func fetchWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleOutput)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
    private func handleOutput(data: Data?, response: URLResponse?) -> UIImage? {
        guard let data,
              let image = UIImage(data: data),
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200,
              response.statusCode < 300 else {
            return nil
        }
        
        return image
    }
    
    func downloadWithAsyncAwait() async -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let image = UIImage(data: data),
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else {
                return nil
            }
            
            return image
        } catch {
            print(error)
            return nil
        }
    }
}

@MainActor
private class DownloadImageUseAsyncAwaitViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let manager = DownloadImageUseAsyncAwaitNetworkManager.instance
    
    func downloadImageEscaping() {
        manager.fetchWithImage { [weak self] image, error  in
            guard let self else { return }
            
            if let image {
                self.image = image
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func donwloadImageCombine() {
        manager.fetchWithCombine()
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] image in
                guard let self else { return }
                self.image = image
            }
            .store(in: &cancellables)
    }
    
    func downloadImageAsync() {
        Task {
           image = await manager.downloadWithAsyncAwait()
            
        }
    }
}
struct DownloadImageUseAsyncAwaitBootcamp: View {
    
    @StateObject private var vm = DownloadImageUseAsyncAwaitViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .clipped()
                        .frame(width: 300, height: 200)
                        .clipShape(.rect(cornerRadius: 10))
                }
            }
            .refreshable {
                vm.downloadImageAsync()
            }
        }
        .onAppear {
            vm.downloadImageAsync()
        }
    }
}

#Preview {
    DownloadImageUseAsyncAwaitBootcamp()
}
