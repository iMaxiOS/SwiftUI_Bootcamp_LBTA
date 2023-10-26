//
//  GlobalActorsBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 26.10.2023.
//

import SwiftUI

@globalActor final class MyFirstGlobalActor {
    static let shared = GlobalActorManager()
}

actor GlobalActorManager {
    
    func getDataFromDatabase() -> [String] {
        ["one", "two", "three", "four", "five", "six"]
    }
}

@MainActor final class GlobalActorViewModel: ObservableObject {
    @Published var arrayData: [String] = []
    
    private let manager = MyFirstGlobalActor.shared
    
    func getData() async {
        let array = await manager.getDataFromDatabase()
        
        await MainActor.run {
            self.arrayData = array
        }
    }
}

struct GlobalActorsBootcamp: View {
    @StateObject private var vm = GlobalActorViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.arrayData, id: \.self) { item in
                    Text(item)
                }
            }
        }
        .task {
            await vm.getData()
        }
    }
}

#Preview {
    GlobalActorsBootcamp()
}
