//
//  TaskBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 25.10.2023.
//

import SwiftUI

final class TaskViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    
    init() {}
    
    func fetchImage() async {
        do {
            guard let url = URL(string: "https://picsum.photos/1024/1024/?blur=2") else { return }
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let image = UIImage(data: data),
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else {
                return
            }
            
            await MainActor.run {
                self.image = image
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct TaskBootcamp: View {	
    
    @StateObject private var vm = TaskViewModel()
    
//    @State private var taskFetchImage: Task<(), Never>? = nil
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .clipped()
                    .scaledToFill()
                    .frame(width: 300, height: 200)
                    .clipShape(.rect(cornerRadius: 10))
                    .onTapGesture {
                        Task { await vm.fetchImage() }
                    }
            }
        }
//        .onDisappear {
//            taskFetchImage?.cancel()
//        }
        .task { // .task -> cancels the task if the view disappears 
            await vm.fetchImage()
        }
    }
}

#Preview {
    TaskBootcamp()
}
