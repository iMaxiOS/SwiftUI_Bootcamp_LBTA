//
//  ScrollViewReaderBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 27.10.2022.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    
    @State private var index: Int = 0
    @State private var yourNumner: String = ""
    @FocusState private var nameIsFocused: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    TextField("Enter your number...", text: $yourNumner)
                        .focused($nameIsFocused)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                        .keyboardType(.numberPad)
                    
                    Button {
                        nameIsFocused = false
                        withAnimation(.spring()) {
                            if let index = Int(yourNumner) {
                                self.index = index
                            }
                        }
                    } label: {
                        Text("Tap button position")
                            .font(.headline)
                    }
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    
                    ScrollView {
                        ScrollViewReader { proxy in
                            ForEach(0..<50) { index in
                                Text("This is item \(index)")
                                    .font(.headline)
                                    .frame(height: 200)
                                    .frame(maxWidth: .infinity)
                                    .background(.white)
                                    .cornerRadius(20)
                                    .shadow(color: .black.opacity(0.4), radius: 10)
                                    .padding()
                                    .id(index)
                            }
                            .onChange(of: index) { newValue in
                                withAnimation(.spring()) {
                                    proxy.scrollTo(newValue, anchor: .center)
                                }
                            }
                        }
                    }
                    .navigationTitle("Scroll View")
                }
            }
        }
    }
}

struct ScrollViewReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderBootcamp()
    }
}
