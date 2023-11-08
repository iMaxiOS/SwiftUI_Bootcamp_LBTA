//
//  UnitTestingViewModel.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 08.11.2023.
//

import Foundation
import Combine

protocol UnitTestingProtocol {
    func downloadWithEscaping(completion: @escaping ([String]) -> Void)
    func downloadingWithCombine() -> AnyPublisher<[String], Error>
}

final class NewMockDataSource: UnitTestingProtocol {
    let arrayItems: [String]
    
    init(items: [String]?) {
        self.arrayItems = items ?? ["ONE", "TWO", "THREE"]
    }
    
    func downloadWithEscaping(completion: @escaping ([String]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(["ONE", "TWO", "THREE"])
        }
    }
    
    func downloadingWithCombine() -> AnyPublisher<[String], Error> {
        Just(arrayItems)
            .tryMap { $0 }
            .eraseToAnyPublisher()
    }
}

final class UnitTestingViewModel: ObservableObject {
    @Published var isPremium: Bool
    @Published var arrayData: [String] = []
    @Published var selectedItem: String? = nil
    
    let manager: NewMockDataSource
    var cancellable = Set<AnyCancellable>()
    
    init(isPremium: Bool, manager: NewMockDataSource = NewMockDataSource(items: nil)) {
        self.isPremium = isPremium
        self.manager = manager
    }
    
    func appendItem(_ item: String) {
        guard !item.isEmpty else { return }
        arrayData.append(item)
    }
    
    func selectedItem(_ item: String) {
        if let index = arrayData.first(where: { $0 == item }) {
            selectedItem = index
        }
    }
    
    func saveItem(_ item: String) throws {
        guard !item.isEmpty else { throw ErrorData.noData }
        
        if let i = arrayData.first(where: { $0 == item }) {
            print("Save Item \(i)")
        } else {
            throw ErrorData.itemNotFound
        }
    }
    
    func downloadWithEscaping() {
        manager.downloadWithEscaping { [weak self] items in
            guard let self else { return }
            self.arrayData = items
        }
    }
    
    func downloadWithCombine() {
        manager.downloadingWithCombine()
            .sink { completion in
                switch completion {
                case .finished: print("Finished")
                case .failure(let error): print(error)
                }
            } receiveValue: { [weak self] items in
                self?.arrayData = items
            }
            .store(in: &cancellable)

    }
    
    enum ErrorData: LocalizedError {
        case noData
        case itemNotFound
    }
}
