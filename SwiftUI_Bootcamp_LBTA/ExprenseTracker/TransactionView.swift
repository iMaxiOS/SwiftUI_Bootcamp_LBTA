//
//  TransactionView.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by iMac on 04.06.2024.
//

import SwiftUI

struct TransactionView: View {
    
    var transaction: Transaction
    
    var body: some View {
        List {
            VStack(spacing: 6) {
                Text(transaction.signedAmount, format: .currency(code: "USD"))
                    .font(.largeTitle)
                    .bold()
                
                Text(transaction.merchant)
                    .lineLimit(1)
                
                Text(transaction.dateParsed, format: .dateTime.year().month(.wide).day())
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowSeparator(.hidden, edges: /*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            TransactionDetailRow(
                icon: .store,
                title: "Merchant",
                text: transaction.merchant
            )
            
            TransactionDetailRow(
                icon: .calendar,
                title: "Date",
                text: transaction.dateParsed.formatted(.dateTime.year().month(.wide).day().weekday(.wide))
            )
            
            TransactionDetailRow(
                icon: .landmark,
                title: "Financial Institution",
                text: transaction.institution
            )
            
            TransactionDetailRow(
                icon: .credit_card,
                title: "Account",
                text: transaction.account
            )
            
            NavigationLink {
                
            } label: {
                TransactionDetailRow(
                    icon: .list,
                    title: "Category",
                    text: transaction.category
                )
            }
            
            
        }
        .listStyle(.plain)
        .navigationTitle("Transaction")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    TransactionView(transaction: transactionMock)
}
