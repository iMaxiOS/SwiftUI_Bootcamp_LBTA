//
//  TransactionModel.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by iMac on 30.05.2024.
//

import Foundation
import SwiftUIFontIcon

struct Transaction: Identifiable, Decodable, Hashable {
    let id: Int
    let date: String
    let institution: String
    let account: String
    let merchant: String
    let amount: Double
    let type: TransactionType.RawValue
    var categoryId: Int
    var category: String
    let isPending: Bool
    let isTransfer: Bool
    let isExpense: Bool
    var isEdited: Bool
    
    var icon: FontAwesomeCode {
        if let category = Category.all.first(where: { $0.id == categoryId }) {
            return category.icon
        }
        
        return .question
    }
    
    var categoryItem: Category {
        if let category = Category.all.first(where: { $0.id == categoryId }) {
            return category
        }
        
        return .shopping
    }
    
    var dateParsed: Date {
        date.dateParsed()
    }
    
    var signedAmount: Double {
        type == TransactionType.credit.rawValue ? amount : -amount
    }
    
    var month: String {
        dateParsed.formatted(.dateTime.year().month(.wide))
    }
}

enum TransactionType: String {
    case debit, credit
}

struct Category: Identifiable {
    let id: Int
    let name: String
    let icon: FontAwesomeCode
    var mainCategoryID: Int?
    
    var subcategories: [Category]? {
        Category.subCategories.filter { $0.mainCategoryID == id }
    }
}

extension Category {
    static let autoAndTransport = Category(id: 1, name: "Auto & Transport", icon: .car_alt)
    static let billsAndUtilities = Category(id: 2, name: "Bills & Utilities", icon: .file_invoice_dollar)
    static let entertainment = Category(id: 3, name: "Entertainment", icon: .film)
    static let feesAndCharges = Category(id: 4, name: "Fees & Charges", icon: .hand_holding_usd)
    static let foodAndDining = Category(id: 5, name: "Food & Dining", icon: .hamburger)
    static let home = Category(id: 6, name: "Home", icon: .home)
    static let income = Category(id: 7, name: "Income", icon: .dollar_sign)
    static let shopping = Category(id: 8, name: "Shopping", icon: .shopping_cart)
    static let transfer = Category(id: 9, name: "Transfer", icon: .exchange_alt)
    
    static let publicTransportation = Category(id: 101, name: "Public Transportation", icon: .car_alt, mainCategoryID: 1)
    static let taxi = Category(id: 102, name: "Taxi", icon: .file_invoice_dollar, mainCategoryID: 1)
    static let mobilePhone = Category(id: 201, name: "Mobile Phone", icon: .film, mainCategoryID: 2)
    static let moviesAndDVDs = Category(id: 301, name: "Movies & DVDs", icon: .hand_holding_usd, mainCategoryID: 3)
    static let bankFee = Category(id: 401, name: "Bank Fee", icon: .hamburger, mainCategoryID: 4)
    static let financeCharge = Category(id: 402, name: "Finance Charge", icon: .home, mainCategoryID: 4)
    static let groceries = Category(id: 501, name: "Groceries", icon: .dollar_sign, mainCategoryID: 5)
    static let restaurants = Category(id: 502, name: "Restaurants", icon: .shopping_cart, mainCategoryID: 5)
    static let rent = Category(id: 601, name: "Rent", icon: .exchange_alt, mainCategoryID: 6)
    static let homeSupplies = Category(id: 602, name: "Home Supplies", icon: .exchange_alt, mainCategoryID: 6)
    static let paycheque = Category(id: 701, name: "Paycheque", icon: .exchange_alt, mainCategoryID: 7)
    static let software = Category(id: 801, name: "Software", icon: .exchange_alt, mainCategoryID: 8)
    static let creditCardPayment = Category(id: 901, name: "Credit Card Payment", icon: .exchange_alt, mainCategoryID: 9)
}

extension Category {
    static let categories: [Category] = [
        .autoAndTransport,
        .billsAndUtilities,
        .entertainment,
        .feesAndCharges,
        .foodAndDining,
        .home,
        .income,
        .shopping,
        .transfer
    ]
    
    static let subCategories: [Category] = [
        .publicTransportation,
        .taxi,
        .mobilePhone,
        .moviesAndDVDs,
        .bankFee,
        .financeCharge,
        .groceries,
        .restaurants,
        .rent,
        .homeSupplies,
        .paycheque,
        .software,
        .creditCardPayment
    ]
    
    static let all: [Category] = categories + subCategories
}

var transactionMock = Transaction(
    id: 1,
    date: "01/24/2022",
    institution: "Desjardins",
    account: "Visa Desjardins",
    merchant: "Apple",
    amount: 11.44,
    type: "debit",
    categoryId: 1,
    category: "Software",
    isPending: false,
    isTransfer: false,
    isExpense: false,
    isEdited: false
)

var transactionList = Array(repeating: transactionMock, count: 10)
