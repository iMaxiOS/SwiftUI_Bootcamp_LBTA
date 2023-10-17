//
//  BackgroundTraeadBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 02.12.2022.
//

import SwiftUI

class BackgroundViewModel: ObservableObject {
    
    @Published var list: [String] = []
    
    func fetchData() {
        DispatchQueue.global(qos: .background).async {
            let newData = self.loadingData()
            DispatchQueue.main.async {
                self.list = newData
            }
        }
    }
    
    private func loadingData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
        }
        return data
    }
}

struct BackgroundTraeadBootcamp: View {
    
    @StateObject private var vm = BackgroundViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Text("LOAD DATA")
                    .fontWeight(.bold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                    
                ForEach(vm.list, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(Color(.textField))
                }
            }
        }
    }
}

struct BackgroundTraeadBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundTraeadBootcamp()
    }
}
