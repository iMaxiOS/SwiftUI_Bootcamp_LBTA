//
//  NetflixHomeView.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by iMac on 24.04.2024.
//

import SwiftUI

struct NetflixHomeView: View {
    
    @State private var filters: [FilterModel] = FilterModel.mockModel
    @State private var selectedFilter: FilterModel? = nil
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                
                HorizontalFilterBarView(
                    filters: filters,
                    selectedFilter: selectedFilter) { filter in
                        selectedFilter = filter
                    } onXPressed: {
                        selectedFilter = nil
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .foregroundColor(.white)
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
            
            HStack(spacing: 16) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        
                    }
            }
            .font(.title2)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    NetflixHomeView()
}
