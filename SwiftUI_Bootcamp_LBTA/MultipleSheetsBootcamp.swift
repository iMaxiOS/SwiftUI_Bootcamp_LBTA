//
//  MultipleSheetsBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 28.10.2022.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

struct MultipleSheetsBootcamp: View {
    
    @State private var model: RandomModel? = nil
    @State private var showSheet: Bool = false
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 10) {
                ForEach(0..<50) { index in
                    Button("Button \(index)") {
                        model = RandomModel(title: "\(index)")
                    }
                }
            }
            .sheet(item: $model) { model in
                SheetView(model: model)
            }
        }
//        VStack(spacing: 20) {
//            Button("Button 1") {
//                model = RandomModel(title: "ONE")
//                showSheet = true
//            }
//            .padding()
//            .background(Color.red)
//            .cornerRadius(10)
//
//            Button("Button 2") {
//                model = RandomModel(title: "TWO")
//                showSheet = true
//            }
//            .padding()
//            .background(Color.blue)
//            .cornerRadius(10)
//        }
//        .foregroundColor(.white)
//        .sheet(isPresented: $showSheet) {
//            SheetView(model: $model)
//        }
    }
}

struct SheetView: View {
    var model: RandomModel
    
    var body: some View {
        Text(model.title)
            .font(.largeTitle)
    }
}

struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}
