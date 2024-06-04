//
//  RecentTransactionList.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by iMac on 31.05.2024.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var transactionsVM: TransactionListModelView
    
    var body: some View {
        VStack {
            HStack {
                Text("Recent Transactions")
                    .bold()
                
                Spacer()
                
                NavigationLink {
                    TransactionList()
                } label: {
                    HStack(spacing: 4) {
                        Text("See all")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(.teal)
                }
            }
            .padding(.top)
            
            ForEach(Array(transactionsVM.transactions.prefix(5).enumerated()), id: \.element) { index, transaction in
                TransactionRow(transaction: transaction)
                
                Divider()
                    .opacity(index == 4 ? 0 : 1)
                
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .primary.opacity(0.5), radius: 10, x: 0.0, y: 5.0)
    }
}

#Preview {
    RecentTransactionList()
        .environmentObject(TransactionListModelView())
}
