//
//  FutureCombineBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 14.11.2023.
//

import SwiftUI
import Combine

final class FutureCombineViewModel: ObservableObject {
    @Published var title: String = "Start Future Combine"
    
    private let url = URL(string: "www.google.com")!
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        download()
    }
    
    private func download() {
//        getEscapingClosure { [weak self] returnString, error in
//            self?.title = returnString
//        }
//        getCombinePublisher()
        promiseErrorFuture()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] returnString in
                self?.title = returnString
            }
            .store(in: &cancellable)
    }
    
    private func getCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: RunLoop.main)
            .map { String(data: $0.data, encoding: .utf8) ?? "" }
            .eraseToAnyPublisher()
    }
    
    private func getEscapingClosure(completion: @escaping (String, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion("New Value 5", nil)
        }
        .resume()
    }
    
    private func promiseErrorFuture() -> Future<String, Error> {
        Future { promise in
            self.getEscapingClosure { returnString, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(returnString))
                }
            }
        }
    }
    
    func promiseNeverFuture() -> Future<String, Never> {
        Future { promise in
            self.getEscapingClosure { returnString, _ in
                promise(.success(returnString))
            }
        }
    }
}

struct FutureCombineBootcamp: View {
    
    @StateObject private var vm = FutureCombineViewModel()
    
    var body: some View {
        Text(vm.title)
    }
}

#Preview {
    FutureCombineBootcamp()
}
