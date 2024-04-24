//
//  DropdownFilterCell.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by iMac on 24.04.2024.
//

import SwiftUI

struct DropdownFilterCell: View {
    var title = "Catigories"
    var isDropdown: Bool = true
    var isSelected: Bool = false
    
    var body: some View {
        HStack(spacing: 4) {
            Text(title)
            
            if isDropdown {
                Image(systemName: "chevron.down")
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            ZStack {
                Capsule(style: .circular)
                    .fill(.white.opacity(0.2))
                    .opacity(isSelected ? 1 : 0)
                
                Capsule(style: .circular)
                    .stroke(lineWidth: 1)
            }
        )
        .foregroundStyle(.gray)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack {
            DropdownFilterCell()
            DropdownFilterCell(isSelected: true)
            DropdownFilterCell(isDropdown: false)
        }
    }
}
