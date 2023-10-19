//
//  DownloadingImagesNetworkManager.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 19.10.2023.
//

import Foundation
import Combine

final class DownloadingImagesNetworkManager {
    
    static let shared = DownloadingImagesNetworkManager()
    
    private var cancelables = Set<AnyCancellable>()
    
    private init() {}
    
    func fetch(url: URL, compliteon: @escaping (Result<[ImageResponse], Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            guard let data = data else {
                print("Error: No data!!!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Error: Invalid response")
                return
            }
        
            do {
                let resultImages = try JSONDecoder().decode([ImageResponse].self, from: data)
                compliteon(.success(resultImages))
            } catch {
                print(error)
                compliteon(.failure(error))
            }
        }.resume()
    }
    
    func downloadData(url: URL, comletion: @escaping ([ImageResponse]) -> Void) {
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [ImageResponse].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    comletion([])
                    print("Error: downloading data. \(error)")
                }
            } receiveValue: { value in
                comletion(value)
            }
            .store(in: &cancelables)

    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200,
              response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }
}
