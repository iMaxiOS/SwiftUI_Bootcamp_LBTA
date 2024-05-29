//
//  DetailView.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 22.05.2024.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        ScrollView {
            Text("12 transactions".uppercased())
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)
                .padding(.top, 20)
            
            Text("Entertainment")
                .font(.largeTitle.width(.expanded).weight(.bold))
            
            ViewThatFits {
                HStack(alignment: .top, spacing: 20) {
                    VStack {
                        ChartView()
                        GridView()
                    }
                    VStack {
                        CardView()
                        GridView()
                    }
                    .frame(width: 400)
                }
                VStack {
                    ChartView()
                    CardView()
                    GridView()
                }
            }
        }
    }
}

#Preview {
    DetailView()
}
