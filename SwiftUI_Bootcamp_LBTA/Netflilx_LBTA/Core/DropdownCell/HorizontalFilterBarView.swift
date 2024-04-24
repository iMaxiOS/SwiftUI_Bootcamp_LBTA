//
//  HorizontalFilterBarView.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by iMac on 24.04.2024.
//

import SwiftUI

struct FilterModel: Hashable, Equatable {
    let title: String
    let dropdown: Bool
    
    static var mockModel: [FilterModel] = [
        FilterModel(title: "TV Show", dropdown: false),
        FilterModel(title: "Sports", dropdown: false),
        FilterModel(title: "Categories", dropdown: true)
    ]
}

struct HorizontalFilterBarView: View {
    
    var filters: [FilterModel] = FilterModel.mockModel
    var selectedFilter: FilterModel? = nil
    var onFilterPressed: ((FilterModel) -> Void)? = nil
    var onXPressed: (() -> Void)? = nil
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                if selectedFilter != nil {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .background(Color.black.opacity(0.0001))
                        .foregroundStyle(.gray)
                        .onTapGesture {
                            onXPressed?()
                        }
                        .transition(.move(edge: .leading))
                        .padding(.leading, 16)
                }
                
                ForEach(filters, id: \.self) { filter in
                    if selectedFilter == nil || selectedFilter == filter {
                        DropdownFilterCell(
                            title: filter.title,
                            isDropdown: filter.dropdown,
                            isSelected: selectedFilter == filter
                        )
                        .background(Color.black.opacity(0.001))
                        .onTapGesture {
                            onFilterPressed?(filter)
                        }
                        .padding(.leading, ((selectedFilter == nil) && filter == filters.first) ? 16 : 0)
                    }
                }
            }
            .padding(.vertical, 2)
        }
        .scrollIndicators(.hidden)
        .animation(.bouncy, value: selectedFilter)
        .padding(.top, 16)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        HorizontalFilterBarView()
    }
}
