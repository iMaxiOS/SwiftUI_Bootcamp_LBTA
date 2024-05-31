//
//  TransactionModel.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by iMac on 30.05.2024.
//

import Foundation

struct Transaction: Identifiable {
    let id: Int
    let date: String
    let institution: String
    let account: String
    let marchant: String
    let amount: Double
    let type: TransactionType.RawValue
    let category: String
    let isPending: Bool
    let isTransfer: Bool
    let isExpense: Bool
    let isEdited: Bool
    
    var dateParsed: Date {
        date.dateParsed()
    }
    
    var signedAmount: Double {
        type == TransactionType.credit.rawValue ? amount : -amount
    }
}

enum TransactionType: String {
    case debit, credit
}

var transactionMock = Transaction(
    id: 1,
    date: "01/24/2022",
    institution: "Desjardins",
    account: "Visa Desjardins",
    marchant: "Apple",
    amount: 11.44,
    type: "debit",
    category: "Software",
    isPending: false,
    isTransfer: false,
    isExpense: false,
    isEdited: false
)

var transactionList = Array(repeating: transactionMock, count: 10)
