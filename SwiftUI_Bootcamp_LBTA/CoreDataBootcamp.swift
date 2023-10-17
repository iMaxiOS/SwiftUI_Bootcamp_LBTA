//
//  CoreDataBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 02.12.2022.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    
    @Published var fruits: [FruitsEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { persistent, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("SUCCESSFUL LOADING CORE DATA.")
            }
        }
        
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitsEntity>(entityName: "FruitsEntity")
        
        do {
            fruits = try container.viewContext.fetch(request)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func addFruit(text: String) {
        let fruit = FruitsEntity(context: container.viewContext)
        fruit.name = text
        fruits.append(fruit)
        
        saveFruit()
    }
    
    func deleteFruit(_ index: IndexSet) {
        guard let source = index.first else { return }
        let item = fruits[source]
        container.viewContext.delete(item)
        
        saveFruit()
    }
    
    func saveFruit() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch {
            print("Save error!!!")
        }
    }
}

struct CoreDataBootcamp: View {
    @StateObject private var vm = CoreDataViewModel()
    @State private var textFieldText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add Fruits...", text: $textFieldText)
                    .foregroundColor(Color(.systemBackground))
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .fontWeight(.semibold)
                
                Button {
                    guard !textFieldText.isEmpty else { return }
                    vm.addFruit(text: textFieldText)
                    textFieldText = ""
                } label: {
                    Text("Add fruit")
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBackground))
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(.red))
                        .cornerRadius(10)
                }
                
                List {
                    ForEach(vm.fruits) { fruit in
                        Text(fruit.name ?? "")
                            .font(.headline)
                            .foregroundColor(Color(.textField))
                    }
                    .onDelete { index in
                        vm.deleteFruit(index)
                    }
                }
                .listStyle(.plain)
            }
            .padding()
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp()
    }
}
