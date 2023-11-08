//
//  UnitTestingBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 08.11.2023.
//

import SwiftUI

struct UnitTestingBootcamp: View {
    @StateObject var vm: UnitTestingViewModel
    
    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: UnitTestingViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        VStack {
            Text(vm.isPremium.description)
        }
    }
}

#Preview {
    UnitTestingBootcamp(isPremium: false)
}
