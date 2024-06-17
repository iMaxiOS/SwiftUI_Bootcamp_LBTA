//
//  TransactionRow.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by iMac on 30.05.2024.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        HStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    .linearGradient(
                        colors: [Color(.accent), .clear],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(
                        .awesome5Solid(code: transaction.icon),
                        fontsize: 20,
                        color: .white
                    )
                }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(transaction.merchant)
                    .foregroundStyle(.primary)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                Text(transaction.categoryItem.name)
                    .foregroundStyle(.red)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                Text(transaction.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(transaction.signedAmount, format: .currency(code: "USD"))
                .font(.footnote)
                .bold()
                .foregroundStyle(
                    transaction.type == TransactionType.credit.rawValue ? Color(.accent) : .primary
                )
        }
        .padding([.top, .bottom], 8)
    }
}

#Preview {
    TransactionRow(transaction: transactionMock)
}
