//
//  ExpenseHomeView.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by iMac on 30.05.2024.
//

import SwiftUI

struct ExpenseHomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Overview")
                        .font(.title2.bold())
                    
                    
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .renderingMode(.original)
                        .foregroundStyle(Color(.accent), .primary)
                }
            }
        }
    }
}

#Preview {
    ExpenseHomeView()
        .environmentObject(TransactionListModelView())
}
