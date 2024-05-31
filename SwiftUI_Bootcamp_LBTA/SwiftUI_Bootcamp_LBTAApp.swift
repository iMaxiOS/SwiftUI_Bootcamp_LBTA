//
//  SwiftUI_Bootcamp_LBTAApp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 26.10.2022.
//

import SwiftUI

@main
struct SwiftUI_Bootcamp_LBTAApp: App {
    
    @StateObject var viewModel = TransactionListModelView()
    
    var body: some Scene {
        WindowGroup {
            ExpenseHomeView()
                .environmentObject(viewModel)
            
//            ContentView()
        }
    }
}
