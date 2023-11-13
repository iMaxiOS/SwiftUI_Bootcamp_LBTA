//
//  CombineBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 13.11.2023.
//

import SwiftUI
import Combine

final class CombineDataService {
//    @Published var basicData: [String] = []
    private let items: [Int] = [1,2,3,4,5,6,7,8,9,10]
    
    let currentValuePublisher = CurrentValueSubject<[String], Never>(["one", "two", "one", "two", "one", "two", "one", "two", "one", "two"])
    let passValuePublisher = PassthroughSubject<Int, Error>()
    let boolPublisher = PassthroughSubject<Bool, Error>()
    let intPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        funcPassValuePublisher()
    }
    
    func publishedData() -> AnyPublisher<[String], Error> {
        Just(["one", "two", "one", "two", "one", "two", "one", "two", "one", "two"])
            .tryMap { $0 }
            .eraseToAnyPublisher()
    }
    
    func funcPassValuePublisher() {
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.passValuePublisher.send(self.items[x])
                
                if x > 4 && x < 9 {
                    self.boolPublisher.send(true)
                    self.intPublisher.send(999)
                } else {
                    self.boolPublisher.send(false)
                    self.intPublisher.send(-999)
                }
            }
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
//            self.passValuePublisher.send(1)
//        }
//            
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.passValuePublisher.send(2)
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.passValuePublisher.send(3)
//        }
    }
}

final class CombineViewModel: ObservableObject {
    
    @Published var data: [Int] = []
    
    private let manager = CombineDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribed()
    }
    
    func addSubscribed() {
//        manager.passValuePublisher
        
        ///Sequence Operations
        /*
            .map { String($0) }
            .first()
            .last()
            .first(where: { $0 > 4 })
            .tryFirst(where: { int in
                if int == 3 {
                    throw URLError(.badServerResponse)
                }
                
                return int > 1
            })
            .last()
            .last(where: { $0 < 4 })
            .tryLast(where: { int in
                if int == 13 {
                    throw URLError(.badServerResponse)
                }
                
                return int > 1
            })
            .dropFirst()
            .dropFirst(3)
            .tryDrop(while: { int in
                if int == 15 {
                    throw URLError(.badServerResponse)
                }
                
                return int > 5
            })
            .prefix(5)
            .prefix(while: { $0 < 5 })
            .tryPrefix(while: { })
            .output(at: 5)
            .output(in: 2..<5)
        */
        
        ///Mathematic Operations
        /*
            .max()
            .max(by: { $0 < $1 })
            .tryMax(by: )
            .min()
            .min(by: )
            .tryMin(by: )
          */
        
        ///Filter / Reducing Operations
        /*
            .map { $0 }
            .tryMap({ int in
                if int == 5 {
                    throw URLError(.badServerResponse)
                }
                
                return int
            })
            .compactMap({ int in
                if int == 5 {
                    return nil
                }
                
                return int
            })
            .tryCompactMap()
            .filter { $0 > 3 && $0 < 7 }
            .tryFilter()
            .removeDuplicates()
            .removeDuplicates(by: { int1, int2 in
                return int1 == int2
            })
            .tryRemoveDuplicates(by: )
            .replaceNil(with: 5)
            .replaceEmpty(with: [])
            .replaceError(with: 11111)
            .scan(0, { exist, nextValue in
                return exist + nextValue
            })
            .tryScan(0, { exist, nextValue in
                if exist == 5 {
                    throw URLError(.badServerResponse)
                }
                return exist + nextValue
            })
            .scan(0, +)
            .reduce(0, { $0 + $1 })
            .reduce(0, +) // find max value
            .collect() // send all element when finished
            .collect(3) // send of 3 element when finished
            .allSatisfy({ $0 < 50 }) // $0 < 50 true  // $0 == 5 false
            .tryAllSatisfy()
        */
        
        ///Timing Operations
        /*
//            .debounce(for: 0.5, scheduler: RunLoop.main)
//            .delay(for: 2, scheduler: RunLoop.main)
//            .measureInterval(using: RunLoop.main)
//            .throttle(for: 5, scheduler: RunLoop.main, latest: true)
//            .retry(3)
//            .timeout(0.75, scheduler: RunLoop.main)
        */
        
        ///Multiple Publisher / Subscribe
        /*
            .combineLatest(manager.boolPublisher)
            .merge(with: manager.intPublisher)
            .zip(manager.boolPublisher, manager.intPublisher)
                .map( { $0.0 + $0.1.description + $0.2 }) // Int, Bool, Int
            .catch({ error in
                return self.manager.intPublisher // if error, we can input next value
            })
        */
        
        ///Multiple Publisher / Subscribe
        
        manager.passValuePublisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Success")
                case .failure(let failure):
                    print("ERROR: \(failure)")
                }
            }, receiveValue: { [weak self] int1 in
//                self?.data = items
                    self?.data.append(int1)
            })
            .store(in: &cancellables)
    }
}

struct CombineBootcamp: View {
    
    @State private var vm = CombineViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(vm.data, id: \.self) {
                        Text("\($0)")
                            .font(.title)
                            .bold()
                        Divider()
                    }
                }
            }
            .navigationTitle("Combine")
        }
    }
}

#Preview {
    CombineBootcamp()
}
