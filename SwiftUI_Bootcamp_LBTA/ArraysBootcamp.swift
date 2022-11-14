//
//  ArraysBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 14.11.2022.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    @Published var userModel: [UserModel] = []
    @Published var sortedUsersModel: [UserModel] = []
    @Published var stringUsersModel: [String] = []
    @Published var mappedUsersModel: [UserModel] = []
    
    init() {
        getUsers()
        sortedUsers()
//        deleteItem()
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Max", points: 100, isVerified: true)
        let user2 = UserModel(name: "Olya", points: 12, isVerified: false)
        let user3 = UserModel(name: nil, points: 45, isVerified: true)
        let user4 = UserModel(name: "Lena", points: 77, isVerified: true)
        let user5 = UserModel(name: nil, points: 98, isVerified: false)
        let user6 = UserModel(name: "Mamut", points: 45, isVerified: true)
        let user7 = UserModel(name: "Oleg", points: 100, isVerified: false)
        let user8 = UserModel(name: nil, points: 25, isVerified: true)
        let user9 = UserModel(name: "Kolya", points: 84, isVerified: false)
        let user10 = UserModel(name: "Andrey", points: 14, isVerified: true)
        
        userModel.append(contentsOf: [user1, user2, user3, user4, user5, user6, user7, user8, user9, user10])
    }
    
    func sortedUsers() {
//        sortedUsersModel = userModel.sorted(by: { $0.points < $1.points })
//        sortedUsersModel = sortedUsersModel.compactMap { $0 }.filter { $0.isVerified }
//        stringUsersModel = sortedUsersModel.compactMap { $0.name }
//        sortedUsersModel = sortedUsersModel.filter { $0.name?.contains("a".lowercased()) ?? false }
        
        mappedUsersModel = userModel
            .sorted(by: { $0.points < $1.points })
            .filter { $0.isVerified }
            .compactMap { $0 }
        
    }
}

struct ArraysBootcamp: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    //                ForEach(vm.stringUsersModel, id: \.self) { name in
                    //                    Text(name)
                    //                }
                    ForEach(vm.mappedUsersModel) { user in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(user.name ?? "")
                                .font(.headline)
                            
                            HStack {
                                Text("points: \(user.points)")
                                Spacer()
                                if user.isVerified {
                                    Image(systemName: "flame.fill")
                                }
                            }
                        }
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.blue.cornerRadius(10))
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Users")
        }
    }
}

struct ArraysBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootcamp()
    }
}
