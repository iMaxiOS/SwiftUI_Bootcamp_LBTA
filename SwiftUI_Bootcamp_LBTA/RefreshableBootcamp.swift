//
//  RefreshableBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 30.10.2023.
//

import SwiftUI

final class RefreshableDataService {
    
    static let shared = RefreshableDataService()
    
    func getData() async throws -> [String] {
        try await Task.sleep(nanoseconds: 5_000_000_000)
        return ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"].shuffled()
    }
}

@MainActor
final class RefreshableViewModel: ObservableObject {
    @Published var data: [String] = []
    
    private let manager = RefreshableDataService.shared
    
    func getData() async {
        do {
            data = try await manager.getData()
        } catch {
            print("Error, get data")
        }
    }
}

struct RefreshableBootcamp: View {
    @StateObject private var vm = RefreshableViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List(vm.data, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                }
            }
            .navigationTitle("Refreshable")
            .refreshable {
                await vm.getData()
            }
            .task {
                await vm.getData()
            }
        }
    }
}

#Preview {
    RefreshableBootcamp()
}
