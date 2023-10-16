//
//  CodableBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 12.12.2022.
//

import SwiftUI

struct CustomerModel: Identifiable, Codable/*, Decodable, Encodable */ {
    let id: Int
    let name: String
    let points: Int
    let isPremium: Bool
    
//    init(id: Int, name: String, points: Int, isPremium: Bool) {
//        self.id = id
//        self.name = name
//        self.points = points
//        self.isPremium = isPremium
//    }
//
//    enum CodingKeys: CodingKey {
//        case id
//        case name
//        case points
//        case isPremium
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.name, forKey: .name)
//        try container.encode(self.points, forKey: .points)
//        try container.encode(self.isPremium, forKey: .isPremium)
//    }
}

final class CustomerViewModel: ObservableObject {
    @Published var customer: CustomerModel? = nil
    
    init() {
        getData()
    }
    
    private func getData() {
        guard let json = fetchJSONData() else { return }
        customer = try? JSONDecoder().decode(CustomerModel.self, from: json)
        
//        do {
//            let data = try JSONDecoder().decode(CustomerModel.self, from: json)
//            customer = data
//        } catch {
//            print(error.localizedDescription)
//        }
    }
    
    private func fetchJSONData() -> Data? {
        let customer = CustomerModel(id: 2, name: "Alex", points: 44, isPremium: false)
        let data = try? JSONEncoder().encode(customer)
        
//        let dictionary: [String: Any] = [
//            "id": 1,
//            "name": "Joy",
//            "points": 10,
//            "isPremium": true
//        ]
//        let data = try? JSONSerialization.data(withJSONObject: dictionary)
        return data
    }
}

struct CodableBootcamp: View {
    
    @StateObject private var vm = CustomerViewModel()
     
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text("\(customer.id)")
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
        }
    }
}

struct CodableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CodableBootcamp()
    }
}
