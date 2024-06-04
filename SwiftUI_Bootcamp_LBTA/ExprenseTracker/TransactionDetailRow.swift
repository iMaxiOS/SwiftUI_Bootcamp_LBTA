//
//  TransactionDetailRow.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by iMac on 04.06.2024.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionDetailRow: View {
    var icon: FontAwesomeCode
    var title: String
    var text: String
    
    var body: some View {
        HStack(spacing: 12) {
            FontIcon.text(.awesome5Solid(code: icon), fontsize: 24, color: .accent)
            
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                
                Text(text)
                    .lineLimit(1)
                
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    TransactionDetailRow(icon: .store, title: "Apple", text: "THis is apple logo")
}
