//
//  ViewBuilderBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 03.11.2023.
//

import SwiftUI

struct HeaderViewRegular: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .font(.title)
                .bold()
            Text("Description")
                .font(.subheadline)
            
            RoundedRectangle(cornerRadius: 1)
                .frame(height: 1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

struct HeaderViewGeneric<Content: View> : View {
    let title: String
    let content: Content
    
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .bold()
            
            content
            
            RoundedRectangle(cornerRadius: 1)
                .frame(height: 1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

struct ViewBuilderBootcamp: View {
    var body: some View {
        VStack {
            HeaderViewRegular()
            HeaderViewGeneric(title: "New title") {
                HStack {
                    Text("HI")
                    Text("HI")
                    Image(systemName: "heart.fill")
                    Text("HI")
                }
            }
            
            HeaderViewGeneric(title: "Other title") {
                VStack {
                    Image(systemName: "heart.fill")
                    Text("HI")
                    Image(systemName: "heart.fill")
                    Text("HI")
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    ViewBuilderBootcamp()
}
