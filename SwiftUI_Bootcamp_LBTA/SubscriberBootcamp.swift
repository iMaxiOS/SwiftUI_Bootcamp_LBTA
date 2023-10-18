//
//  SubscriberBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 18.10.2023.
//

import SwiftUI
import Combine

private class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        updateTimer()
        changeTextField()
    }
    
    private func changeTextField() {
        $textFieldText
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .map { text -> Bool in
                text.count >= 3
            }
            .assign(to: &$textIsValid)
//            .sink { [weak self] isValid in
//                self?.textIsValid = isValid
//            }
//            .store(in: &cancelables)
    }
    
    private func updateTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                self.count += 1
            }
            .store(in: &cancelables)
    }
}

struct SubscriberBootcamp: View {
    @StateObject private var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.system(size: 70))
            
            Text(vm.textIsValid.description)
            
            TextField("Write something here...", text: $vm.textFieldText)
                .padding(.horizontal)
                .font(.caption)
                .frame(height: 55)
                .tint(.gray)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
            
            Button(action: {
                
            }, label: {
                Text("Tap Me...")
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(vm.textIsValid ? Color(.systemGray3) : Color(.systemGray6))
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.horizontal)
            })
            .disabled(!vm.textIsValid)
        }
    }
}

#Preview {
    SubscriberBootcamp()
}
