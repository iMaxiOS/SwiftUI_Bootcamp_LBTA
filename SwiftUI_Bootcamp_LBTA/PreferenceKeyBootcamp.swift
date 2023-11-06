//
//  PreferenceKeyBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 03.11.2023.
//

import SwiftUI

struct GeometrySizePreferenceKey : PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct GeometryPreferenceKey: View {
    @State private var offset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Geometry Preference Key")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 55)
                    .opacity(Double(offset) / 100)
                    .background(
                        GeometryReader { geo in
                            Text("")
                                .preference(
                                    key: GeometrySizePreferenceKey.self,
                                    value: geo.frame(in: .global).maxY
                                )
                        }
                    )
                
                ForEach(0..<20) { index in
                    RoundedRectangle(cornerRadius: 15)
                        .frame(height: 200)
                }
                .overlay {
                    Text("\(offset)")
                        .foregroundStyle(.white)
                }
            }
            .padding(.top, 40)
            
        }
        .padding()
        .onPreferenceChange(GeometrySizePreferenceKey.self, perform: { value in
            self.offset = value
        })
        .ignoresSafeArea()

    }
}

extension View {
    func updateGeometrySize(_ size: CGFloat) -> some View {
        preference(key: GeometrySizePreferenceKey.self, value: size)
    }
}

#Preview {
    GeometryPreferenceKey()
}
