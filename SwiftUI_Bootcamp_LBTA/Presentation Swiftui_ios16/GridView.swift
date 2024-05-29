//
//  GridView.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 22.05.2024.
//

import SwiftUI

struct GridView: View {
    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 12, verticalSpacing: 12) {
            GridRow {
                Text("Votes")
                    .gridCellColumns(2)
                Text("Rating")
                
            }
            .gridColumnAlignment(.trailing)
            
            Divider()
                .gridCellUnsizedAxes(.horizontal)
            
            GridRow {
                Text("4")
                ProgressView(value: 0.1)
                    .frame(maxWidth: 250)
                RatingView(rating: 1)
            }
            
            GridRow {
                Text("21")
                ProgressView(value: 0.5)
                    .frame(maxWidth: 250)
                RatingView(rating: 2)
            }
            
            GridRow {
                Text("25")
                ProgressView(value: 0.2)
                    .frame(maxWidth: 250)
                RatingView(rating: 3)
            }
            
            GridRow {
                Text("26")
                ProgressView(value: 0.33)
                    .frame(maxWidth: 250)
                RatingView(rating: 4)
            }
            
            GridRow {
                Text("28")
                ProgressView(value: 0.7)
                    .frame(maxWidth: 250)
                RatingView(rating: 5)
            }
        }
        .padding()
    }
}

struct RatingView: View {
    var rating = 3
    let list = [1, 2, 3, 4, 5]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(list, id: \.self) { item in
                Image(systemName: rating >= item ? "star.fill" : "star")
            }
        }
    }
}

#Preview {
    GridView()
}
