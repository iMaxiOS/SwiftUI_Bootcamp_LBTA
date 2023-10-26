//
//  DownloadWithEscapingBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 16.10.2023.
//

import SwiftUI

struct PostsModel: Identifiable, Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

final class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostsModel] = []
    
    init() {
        Task {
            await getPosts()
        }
    }
    
    @MainActor
    func getPosts() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        self.getPosts(fromURL: url) { [weak self] data in
            guard let data = data else {
                print("No data....")
                return
            }
            
            do {
                self?.posts = try JSONDecoder().decode([PostsModel].self, from: data)
            } catch {
                print(error)
            }
        }
    }
    
    func getPosts(fromURL: URL, completion: @escaping (_ data: Data?) -> Void) {
        let request = URLRequest(url: fromURL)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil,
                  let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error downloading data.")
                completion(nil)
                return
            }
            
            completion(data)
        }
        .resume()
    }
}

struct DownloadWithEscapingBootcamp: View {
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.posts) { post in
                    NavigationLink(destination: Text(post.title)) {
                        VStack(alignment: .leading) {
                            Text(post.title)
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                            
                            Text(post.body)
                                .font(.system(size: 10))
                                .fontWeight(.semibold)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Posts")
        }
    }
}

#Preview {
    DownloadWithEscapingBootcamp()
}
