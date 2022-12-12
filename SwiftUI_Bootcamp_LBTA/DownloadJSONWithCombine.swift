//
//  DownloadJSONWithCombine.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 12.12.2022.
//

import SwiftUI
import Combine

struct Download: Identifiable, Codable {
    var userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadViewModel: ObservableObject {
    @Published var list: [Download] = []
    
    private var subscriber = Set<AnyCancellable>()
    
    init() {
        getArticles(completion: { result in
            switch result {
            case .success(let success):
                self.list = success
            case .failure(let failure):
                print(failure)
            }
        })
    }
    
    private func getArticles(completion: @escaping (Result<[Download], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { data, response -> Data in
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    print(URLError(.badServerResponse))
                }
                
                return data
            }
            .decode(type: [Download].self, decoder: JSONDecoder())
            .sink { (resultCompletion) in
                switch resultCompletion {
                case .failure(let error):
                    completion(.failure(error))
                case .finished:
                    return
                }
            } receiveValue: { (resultArr) in
                completion(.success(resultArr))
            }
            .store(in: &subscriber)
    }
    
}

struct DownloadJSONWithCombine: View {
    
    @StateObject private var vm = DownloadViewModel()
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(vm.list) { item in
                        Text(item.body)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .lineLimit(2)
                            .foregroundColor(.textFieldColor)
                        
                        Text(item.body)
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Articles")
        }
    }
}

struct DownloadJSONWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadJSONWithCombine()
    }
}
