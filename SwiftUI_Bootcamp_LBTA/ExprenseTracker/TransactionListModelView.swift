//
//  TransactionListModelView.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by iMac on 31.05.2024.
//

import Foundation

typealias GroupTransaction = [String: [Transaction]]

@MainActor
final class TransactionListModelView: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    init() {
        Task {
            try await getTransactions()
        }
    }
    
    func getTransactions() async throws {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid url")
            return
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([Transaction].self, from: data)
        
        transactions = result
    }
    
    func groupTransactionsByMonth() -> GroupTransaction {
        guard !transactions.isEmpty else { return [:] }
        
        let groupTransactions = GroupTransaction(grouping: transactions, by: { $0.month })
        
        return groupTransactions
    }
}
