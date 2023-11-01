//
//  MatchedGeometryEffectBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 01.11.2023.
//

import SwiftUI

struct MatchedGeometryEffectBootcamp: View {
    
    let categories: [String] = ["Home", "Popular", "Settings"]
    
    @State private var selected: String = "Home"
    @State private var isClicked: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            HStack {
                ForEach(categories, id: \.self) { category in
                    ZStack() {
                        if selected == category {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.red)
                                .matchedGeometryEffect(id: "ID", in: namespace)
                                .frame(width: 50, height: 2)
                                .offset(y: 15)
                        }
                        
                        Text(category)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(selected == category ? .red : .black)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .onTapGesture {
                        withAnimation(.smooth) {
                            selected = category
                        }
                    }
                }
            }
            .padding()
            
//            if !isClicked {
//                RoundedRectangle(cornerRadius: 10)
//                    .frame(width: 100, height: 100)
//                    .matchedGeometryEffect(id: "isClicked", in: namespace)
//                    .onTapGesture {
//                        withAnimation(.smooth) {
//                            isClicked.toggle()
//                        }
//                    }
//            }
//            
//            Spacer()
//            
//            if isClicked {
//                RoundedRectangle(cornerRadius: 10)
//                    .frame(width: 100, height: 100)
//                    .matchedGeometryEffect(id: "isClicked", in: namespace)
//                    .onTapGesture {
//                        withAnimation(.smooth) {
//                            isClicked.toggle()
//                        }
//                    }
//            }
            
            
        }
    }
}

#Preview {
    MatchedGeometryEffectBootcamp()
}
