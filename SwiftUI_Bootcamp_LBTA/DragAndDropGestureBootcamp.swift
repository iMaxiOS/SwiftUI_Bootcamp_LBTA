//
//  DragAndDropGestureBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 26.10.2023.
//

import SwiftUI
import UniformTypeIdentifiers
import Algorithms

// struct conformation Transferable protocol for uniq CodableRepresentation(contentType: .lid)
struct Lid: Identifiable, Codable, Hashable, Transferable {
    var id = UUID().uuidString
    let name: String
    let phone: String
    let comment: String
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .lid)
    }
}

extension UTType {
    static let lid = UTType(exportedAs: "DragAndDropGestureBootcamp")
}

struct DragAndDropGestureBootcamp: View {
    @State private var newLids: [Lid] = [
        Lid(name: "Oleg", phone: "+38077", comment: "#123"),
        Lid(name: "Ekaterina", phone: "+38088", comment: "#92"),
        Lid(name: "Vyacheslav", phone: "+38022", comment: "#12")
    ]
    @State private var newWorkLids: [Lid] = []
    @State private var newDoneLids: [Lid] = []
    
    @State private var isTargets: [Bool] = [false, false, false]
    
    var body: some View {
        NavigationStack {
            VStack {
                ColumnView(title: "Lids", lids: newLids, isTarget: $isTargets[0])
                    .dropDestination(for: Lid.self) { droppedLids, location in
                        droppedLids.forEach { lid in
                            newWorkLids.removeAll { $0.id == lid.id }
                            newDoneLids.removeAll { $0.id == lid.id }
                        }
                        
                        let lids = newLids + droppedLids
                        /// so that there is no duplicate, to import the algorithm
                        newLids = Array(lids.uniqued())
                        return true
                    } isTargeted: { isTarget in
                        isTargets[0] = isTarget
                    }
                ColumnView(title: "In Work", lids: newWorkLids, isTarget: $isTargets[1])
                    .dropDestination(for: Lid.self) { droppedLids, location in
                        droppedLids.forEach { lid in
                            newLids.removeAll { $0.id == lid.id }
                            newDoneLids.removeAll { $0.id == lid.id }
                        }
                        
                        let lids = newWorkLids + droppedLids
                        newWorkLids = Array(lids.uniqued())
                        return true
                    } isTargeted: { isTarget in
                        isTargets[1] = isTarget
                    }
                ColumnView(title: "Done Work", lids: newDoneLids, isTarget: $isTargets[2])
                    .dropDestination(for: Lid.self) { droppedLids, location in
                        droppedLids.forEach { lid in
                            newLids.removeAll { $0.id == lid.id }
                            newWorkLids.removeAll { $0.id == lid.id }
                        }
                        
                        let lids = newDoneLids + droppedLids
                        newDoneLids = Array(lids.uniqued())
                        return true
                    } isTargeted: { isTarget in
                        isTargets[2] = isTarget
                    }
                Spacer()
            }
            .padding()
            .navigationTitle("Lids")
        }
    }
}

struct ColumnView: View {
    let title: String
    let lids: [Lid]
    
    @Binding var isTarget: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
            
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(lids) { lid in
                        Text(lid.name)
                            .padding()
                            .background(Color(.systemGray4))
                            .clipShape(.rect(cornerRadius: 12))
                            .shadow(color: .blue, radius: 1)
                            .draggable(lid)
                    }
                }
                
                Spacer()
            }
            .padding()
            .frame(minHeight: 50)
            .background(isTarget ? Color(.systemGray2) : Color(.systemGray5))
            .clipShape(.rect(cornerRadius: 12))
        }
    }
}

#Preview {
    DragAndDropGestureBootcamp()
}
