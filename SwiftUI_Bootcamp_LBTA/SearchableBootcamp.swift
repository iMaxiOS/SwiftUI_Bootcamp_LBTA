//
//  SearchableBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 30.10.2023.
//

import SwiftUI
import Combine

enum PlaceType: String {
    case kharkiv, dnipro, kiev, lviv
}

enum SearchScopeOption: Hashable {
    case all
    case place(option: PlaceType)
    
    var title: String {
        switch self {
        case .all:
            return "All"
        case .place(let option):
            return option.rawValue.capitalized
        }
    }
}

struct Restaurant: Identifiable {
    let id: Int
    let name: String
    let place: PlaceType
}

final class SearchableDataManager {
    
    static let shared = SearchableDataManager()
    
    func getRestaurant() async throws -> [Restaurant] {
        return [
            .init(id: 0, name: "Pasta Place", place: .kharkiv),
            .init(id: 1, name: "Burger Shack", place: .dnipro),
            .init(id: 2, name: "Ace kaffe", place: .kiev),
            .init(id: 3, name: "Local Market", place: .lviv),
            .init(id: 4, name: "Pasta", place: .kharkiv),
            .init(id: 5, name: "Shtick", place: .dnipro),
            .init(id: 6, name: "Kaffe", place: .kiev),
            .init(id: 7, name: "Market", place: .lviv),
        ]
    }
}

@MainActor
final class SearchableViewModel: ObservableObject {
    @Published var allRestaurants: [Restaurant] = []
    @Published var filterRestaurants: [Restaurant] = []
    @Published var searchText: String = ""
    @Published var searchOption: SearchScopeOption = .all
    @Published var allSearchOption: [SearchScopeOption] = []
    
    private let manager = SearchableDataManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    private func addSubscriber () {
        $searchText
            .combineLatest($searchOption)
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] searchText, searchScope in
                guard let self else { return }
                self.filterRestaurants = self.searchPlace(searchText, searchScope)
//                self.searchPlace(searchText, searchScope)
            }
            .store(in: &cancellables)
    }
    
//    var searchRestaurants: [Restaurant] {
//        if !searchText.isEmpty {
//            return allRestaurants.filter {
//                $0.name.lowercased().contains(searchText.lowercased()) ||
//                $0.place.rawValue.lowercased().contains(searchText.lowercased())
//            }
//        } else {
//            return allRestaurants
//        }
//    }
    
//    func filterRestaurants(_ searchText: String, _ searchScope: SearchScopeOption) {
//        guard !searchText.isEmpty else {
//            filterRestaurants = []
//            searchOption = .all
//            return
//        }
//        
//        var restaurantInScope = allRestaurants
//        
//        switch searchScope {
//        case .all:
//            break
//        case .place(option: let option):
//            restaurantInScope = allRestaurants.filter { $0.place == option }
//        }
//        
//        let search = searchText.lowercased()
//        filterRestaurants = restaurantInScope.filter {
//            $0.name.lowercased().contains(search) ||
//            $0.place.rawValue.lowercased().contains(search)
//        }
//    }
    
    func searchPlace(_ searchText: String, _ searchScope: SearchScopeOption) -> [Restaurant] {
        var restaurantInScope = allRestaurants
        
        switch searchScope {
        case .all:
            break
        case .place(option: let option):
            restaurantInScope = allRestaurants.filter { $0.place == option }
        }
        
        return restaurantInScope.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    func getData() async {
        do {
            self.allRestaurants = try await manager.getRestaurant()
            let places = Set(allRestaurants.map { $0.place })
            self.allSearchOption = [.all] + places.map { SearchScopeOption.place(option: $0) }
        } catch {
            print("Error get data...")
        }
    }
}

struct SearchableBootcamp: View {
    @StateObject private var vm = SearchableViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(!vm.searchText.isEmpty ? vm.filterRestaurants : vm.allRestaurants) { restaurant in
                        restaurantRow(restaurant: restaurant)
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Restaurants")
            .searchable(text: $vm.searchText, placement: .automatic, prompt: Text("Search place..."))
            .searchScopes($vm.searchOption, scopes: {
                ForEach(vm.allSearchOption, id: \.self) { item in
                    Text(item.title)
                        .tag(item)
                }
            })
            .task {
                await vm.getData()
            }
        }
    }
    
    private func restaurantRow(restaurant: Restaurant) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(restaurant.name)
                .font(.headline)
                .fontWeight(.heavy)
                .tracking(1.0)
            Text(restaurant.place.rawValue.capitalized)
                .font(.footnote)
                .fontWeight(.bold)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    SearchableBootcamp()
}
