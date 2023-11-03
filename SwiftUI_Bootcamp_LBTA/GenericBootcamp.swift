//
//  GenericBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 02.11.2023.
//

import SwiftUI

struct ModelResponse<T> {
    var info: T?
    
    func removeInfo() -> ModelResponse {
        ModelResponse(info: nil)
    }
}

struct GenericView<T: View>: View {
    
    var title: String
    var content: T
    
    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}

final class GenericViewModel: ObservableObject {
    @Published var array: [String] = []
    @Published var stringGeneric: ModelResponse = ModelResponse(info: "Hello")
    @Published var boolGeneric: ModelResponse = ModelResponse(info: false)
    
//    init() {
//        getArray()
//    }
//    
//    private func getArray() {
//        array.append(contentsOf: ["One", "Two", "Free"])
//    }
    
    func removeDataFromGeneric() {
        stringGeneric = stringGeneric.removeInfo()
        boolGeneric = boolGeneric.removeInfo()
    }
}

struct GenericBootcamp: View {
    @StateObject private var vm = GenericViewModel()
    
    var body: some View {
        VStack {
            GenericView(title: "New View!", content: Text("Content View!"))
            
            Text(vm.stringGeneric.info ?? "No data")
            Text(vm.boolGeneric.info?.description ?? "No data")
        }
        .onTapGesture {
            vm.removeDataFromGeneric()
        }
    }
}

#Preview {
    GenericBootcamp()
}
