//
//  LongPressGustureBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 26.10.2022.
//

import SwiftUI

struct LongPressGustureBootcamp: View {
    
    @State var isComplete = false
    @State var complete = false
    
    var body: some View {
        
        VStack {
            Rectangle()
                .fill(complete ? Color.red : Color.blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            Text("RESET")
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        isComplete = false
                        complete = false
                    }
                }

        }
        .onLongPressGesture(minimumDuration: 1.0) {
            withAnimation {
                complete = true
            }
        } onPressingChanged: { isPressing in
            withAnimation(.easeInOut(duration: 1)) {
                if isPressing {
                    isComplete = true
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        if !isComplete {
                            isComplete = false
                        }
                    }
                }
            }
        }
        
        
//        Text(isComplete ? "Byu, World!".uppercased() : "Hello, World!".uppercased())
//            .foregroundColor(.white)
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? Color.red : Color.green)
//            .cornerRadius(isComplete ? 25 : 5)
//            .onLongPressGesture(minimumDuration: 1, maximumDistance: 200) {
//                withAnimation {
//                    isComplete.toggle()
//                }
//            }
    }
}

struct LongPressGustureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGustureBootcamp()
    }
}
