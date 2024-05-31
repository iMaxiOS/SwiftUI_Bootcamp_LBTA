//
//  TransactionRow.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by iMac on 30.05.2024.
//

import SwiftUI

struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        HStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    .linearGradient(
                        colors: [.teal, .clear],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 44, height: 44)
                .overlay {
                    Image(
                        systemName: transaction.type == TransactionType.credit.rawValue ?
                        "arrow.up.square.fill" : "arrow.down.square.fill"
                    )
                    .font(.title)
                    .blendMode(.overlay)
                }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(transaction.marchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                Text(transaction.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                
                
            }
            
            Spacer()
            
            Text(transaction.signedAmount, format: .currency(code: "USD"))
                .bold()
                .foregroundStyle(
                    transaction.type == TransactionType.credit.rawValue ? Color.teal : .primary
                )
        }
        .padding([.top, .bottom], 8)
    }
}

#Preview {
    TransactionRow(transaction: transactionMock)
}
