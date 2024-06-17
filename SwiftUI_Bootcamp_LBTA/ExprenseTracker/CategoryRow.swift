//
//  CategoryRow.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by iMac on 04.06.2024.
//

import SwiftUI
import SwiftUIFontIcon

struct CategoryRow: View {
    var category: Category
    var isSelected: Bool = false
    
    var  isMain: Bool {
        category.mainCategoryID == nil
    }
    
    var body: some View {
        HStack(spacing: 20) {
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        .linearGradient(
                            colors: [Color(.accent), .clear],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: isMain ? 44 : 32, height: isMain ? 44 : 32)
                    .overlay {
                        FontIcon.text(
                            .awesome5Solid(code: category.icon),
                            fontsize: isMain ? 24 : 16,
                            color: .white
                        )
                }
            }
            .frame(width: 50)
            
            if isMain {
                Text(category.name)
                    .foregroundStyle(.primary)
            } else {
                Text(category.name)
                    .font(.subheadline)
            }
            
            if isSelected {
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 16))
                    .foregroundStyle(
                        .linearGradient(
                            colors: [Color(.accent), .white.opacity(0.2)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 1)
                            .fill(
                                .linearGradient(
                                    colors: [Color(.accent), .white.opacity(0.3)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }
            }
            
            
        }
    }
}

#Preview {
    CategoryRow(category: .billsAndUtilities, isSelected: true)
}
