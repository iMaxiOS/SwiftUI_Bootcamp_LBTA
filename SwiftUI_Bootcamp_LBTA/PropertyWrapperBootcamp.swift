//
//  PropertyWrapperBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 16.11.2023.
//

import SwiftUI

extension FileManager {
    
    static func documentsPath() -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appending(path: "custom_file.txt")
    }
}

@propertyWrapper
struct FileManagerProperty: DynamicProperty {
    @State var title: String
    
    var wrappedValue: String {
        get {
            title
        }
        nonmutating set {
            save(newValue: newValue)
        }
    }
    
    init() {
        do {
            title = try String(contentsOf: FileManager.documentsPath(), encoding: .utf8)
        } catch {
            title = "Starting title"
            print("Error: get title \(error)")
        }
    }
    
    func save(newValue: String) {
        do {
            try newValue.write(to: FileManager.documentsPath(), atomically: false, encoding: .utf8)
            title = newValue
            print("Save successful.")
        } catch {
            print("Error: save \(error)")
        }
    }
}

struct PropertyWrapperBootcamp: View {
//    private var fileManager = FileManagerProperty()
    @FileManagerProperty private var title: String
    
    var body: some View {
        VStack {
            Text(title)
                .bold()
            
            Button {
                title = "TITLE 1"
//                fileManager.wrappedValue = "TITLE 1"
//                fileManager.save(newValue: "TITLE 1")
            } label: {
                Text("Save title 1")
                    .modifier(ButtonModifier())
            }
            
            Button {
                title = "TITLE 2"
//                fileManager.wrappedValue = "TITLE 2"
//                fileManager.save(newValue: "TITLE 2")
            } label: {
                Text("Save title 2")
                    .modifier(ButtonModifier())
            }
        }
    }
}

#Preview {
    PropertyWrapperBootcamp()
}
