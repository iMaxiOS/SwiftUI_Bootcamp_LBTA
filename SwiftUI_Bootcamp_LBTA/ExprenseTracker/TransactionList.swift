//
//  TransactionList.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by iMac on 31.05.2024.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM: TransactionListModelView
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(transactionListVM.groupTransactionsByMonth()), id: \.key) { month, transactions in
                    
                    Section {
                        ForEach(transactions) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    } header: {
                        Text(month)
                            .foregroundStyle(Color(.accent))
                            .padding(.vertical, 10)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Transactions")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TransactionList()
        .environmentObject(TransactionListModelView())
}
