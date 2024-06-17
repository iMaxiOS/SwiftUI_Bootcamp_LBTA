//
//  CategoriesView.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by iMac on 04.06.2024.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var transacationListVM: TransactionListModelView
    
    var transaction: Transaction
    
    var body: some View {
        List {
            ForEach(Category.categories) { category in
                Section {
                    ForEach(category.subcategories ?? []) { subcategory in
                        let isSelected = transaction.categoryId == subcategory.id
                        
                        CategoryRow(category: subcategory, isSelected: isSelected)
                            .background(.black.opacity(0.0001))
                            .onTapGesture {
                                transacationListVM.updateCategory(
                                    transaction: transaction,
                                    category: subcategory
                                )
                            }
                    }
                } header: {
                    let isSelected = transaction.categoryId == category.id
                    
                    CategoryRow(category: category, isSelected: isSelected)
                        .background(.black.opacity(0.0001))
                        .onTapGesture {
                            transacationListVM.updateCategory(
                                transaction: transaction,
                                category: category
                            )
                        }
                }
            }
            .listSectionSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle("Category")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CategoriesView(transaction: transactionMock)
        .environmentObject(TransactionListModelView())
}
