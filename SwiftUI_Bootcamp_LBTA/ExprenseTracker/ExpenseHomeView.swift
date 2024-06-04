//
//  ExpenseHomeView.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by iMac on 30.05.2024.
//

import SwiftUI
import SwiftUICharts

struct ExpenseHomeView: View {
    
    let mockData: [Double] = [0, 100, 40, 60, 120, 90, 130]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Overview")
                        .font(.title2.bold())
                    
                    LineChartView(data: mockData, title: "USDT $130", style: Styles.barChartStyleNeonBlueDark, form: ChartForm.extraLarge, rateValue: 10, valueSpecifier: "$%.01f")
                    
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
