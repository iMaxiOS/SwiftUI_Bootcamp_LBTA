//
//  AsyncAwaitActorBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 24.10.2023.
//

import SwiftUI

final class DoCatchTryNetworkManager {
    let isActive: Bool = false
    
//    func getTitle() -> (title: String?, error: Error?) {
//        if isActive {
//            return ("Fetch Susscessful!", nil)
//        } else {
//            return (nil, URLError(.badURL))
//        }
//    }
    
//    func getTitle() -> Result<String, Error> {
//        if isActive {
//            return .success("Fetch Susscessful!")
//        } else {
//            return .failure(URLError(.badURL))
//        }
//    }
    
    func getTitle() throws -> String {
        if isActive {
            return "Fetch Susscessful"
        } else {
            throw URLError(.badServerResponse)
        }
    }
}

final class DoCatchTryViewModel: ObservableObject {
    @Published var title: String = "THIS IS TITLE"
    
    let manager = DoCatchTryNetworkManager()
    
    func getTitle() {
//        if let title = manager.getTitle().title {
//            self.title = title
//        } else if let error = manager.getTitle().error {
//            self.title = "Error: \(error.localizedDescription)"
//        }
        
//        switch manager.getTitle() {
//        case .success(let success):
//            self.title = success
//        case .failure(let failure):
//            self.title = failure.localizedDescription
//        }
        
        do {
            let title = try manager.getTitle()
            self.title = title
        } catch {
            self.title = error.localizedDescription
        }
    }
}

struct DoCatchTryBootcamp: View {
    @StateObject private var vm = DoCatchTryViewModel()
    
    var body: some View {
        Text(vm.title)
            .font(.footnote)
            .fontWeight(.semibold)
            .frame(width: 300, height: 300)
            .background(Color.red)
            .foregroundStyle(.white)
            .onTapGesture {
                vm.getTitle()
            }
    }
}

#Preview {
    DoCatchTryBootcamp()
}
