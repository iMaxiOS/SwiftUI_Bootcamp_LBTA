//
//  HashableBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 10.11.2022.
//

import SwiftUI

struct MyHashable: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

extension MyHashable {
    static let data: [MyHashable] = [
        MyHashable(title: "ONE"),
        MyHashable(title: "TWO"),
        MyHashable(title: "THREE"),
        MyHashable(title: "FOUR"),
        MyHashable(title: "FIVE"),
        MyHashable(title: "SIX")
    ]
}

struct HashableBootcamp: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                ForEach(MyHashable.data, id: \.title) { item in
                    Text(item.title)
                }
            }
        }
    }
}

struct HashableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HashableBootcamp()
    }
}
