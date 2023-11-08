//
//  DependencyInjectionBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 08.11.2023.
//

import SwiftUI
import Combine

protocol DataServiceProtocol {
    func combineGetPosts() -> AnyPublisher<[DependencyResponse], Error>
//    func getPosts() async -> [DependencyResponse]
}

struct DependencyResponse: Identifiable, Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

final class MockData: DataServiceProtocol {
    let testData: [DependencyResponse] = [
        .init(userId: 1, id: 1, title: "Title", body: "Body"),
        .init(userId: 2, id: 2, title: "Title2", body: "Body2"),
        .init(userId: 3, id: 3, title: "Title3", body: "Body3"),
        .init(userId: 4, id: 4, title: "Title4", body: "Body4")
    ]
    
    func combineGetPosts() -> AnyPublisher<[DependencyResponse], Error> {
        Just(testData)
            .tryMap { $0 }
            .eraseToAnyPublisher()
    }
}

final class ProductionDataManager: DataServiceProtocol {
    
//    static let shared = ProductionDataManager()
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func combineGetPosts() -> AnyPublisher<[DependencyResponse], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [DependencyResponse].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getPosts() async -> [DependencyResponse] {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode([DependencyResponse].self, from: data)
            return result
        } catch {
            print("Error get posts")
        }
        
        return []
    }
}

final class DependencyInjectionViewModel: ObservableObject {
    @Published var array: [DependencyResponse] = []
    
//    private let manager = ProductionDataManager.shared
    let manager: DataServiceProtocol
    private var cancellable = Set<AnyCancellable>()
    
    
    init(manager: DataServiceProtocol) {
        self.manager = manager
        
        Task {
            await combineLoadPosts()
        }
    }
    
    func combineLoadPosts() async {
        manager.combineGetPosts()
            .sink { completion in
                switch completion {
                case .finished: print("Finished")
                case .failure(let error): print(error)
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                self.array = response
            }
            .store(in: &cancellable)

    }
    
//    func loadPosts() async {
//        array = await manager.getPosts()
//    }
}
    
struct DependencyInjectionBootcamp: View {
    
    @StateObject private var vm: DependencyInjectionViewModel
    
    init(manager: DataServiceProtocol) {
        _vm = StateObject(wrappedValue: DependencyInjectionViewModel(manager: manager))
    }
    
    var body: some View {
        VStack {
            List(vm.array) { item in
                Text(item.title)
            }
        }
    }
}

#Preview {
    let manager = ProductionDataManager(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    let mock = MockData()
    
    return DependencyInjectionBootcamp(manager: manager)
}
