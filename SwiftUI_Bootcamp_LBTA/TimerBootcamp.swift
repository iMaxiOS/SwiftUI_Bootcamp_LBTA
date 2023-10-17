//
//  TimerBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 17.10.2023.
//

import SwiftUI

struct TimerBootcamp: View {
   
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    ///Time Remaining
    @State private var timeRemaining: String = ""
    private let nowDate = Calendar.current.date(byAdding: .day, value: 1, to: .now) ?? Date()
    
    ///Countdown
    @State private var countDown: Int = 10
    @State private var finishedText: String? = nil
    
    ///Current Date
    @State private var currentDate = Date()
//    var dateFormatter: DateFormatter {
//        let date = DateFormatter()
//        date.dateStyle = .long
//        date.dateFormat = "yyyy / d / MMMM"
//        date.timeStyle = .medium
//        return date
//    }
    
    ///Animation counter
    @State private var counter = 0
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [Color(.white), Color(.blue)],
                center: .center,
                startRadius: 10,
                endRadius: 500
            )
            .ignoresSafeArea()
            
            ///Time page
            TabView(selection: $counter,
                    content:  {
                Rectangle()
                    .foregroundColor(Color.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(Color.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(Color.orange)
                    .tag(3)
                Rectangle()
                    .foregroundColor(Color.black)
                    .tag(4)
                Rectangle()
                    .foregroundColor(Color.pink)
                    .tag(5)
            })
            .frame(height: 200)
            .tabViewStyle(.page)
            
            ///Counter animation
//            HStack(spacing: 15) {
//                Circle()
//                    .offset(y: counter == 1 ? -20 : 0)
//                Circle()
//                    .offset(y: counter == 2 ? -20 : 0)
//                Circle()
//                    .offset(y: counter == 3 ? -20 : 0)
//            }
//            .frame(width: 200)
//            .foregroundColor(Color.red)
            
        }
        .onReceive(timer, perform: { value in
//            updateTimeRamaining()
//            countdown()
            counterPageAnimation()
        })
    }
    
    ///Time page
    private func counterPageAnimation() {
        withAnimation {
            counter = counter == 5 ? 1 : counter + 1
        }
    }
    
    ///Counter animation
    private func counterAnimation() {
        withAnimation(.easeIn(duration: 0.5)) {
            counter = counter == 3 ? 0 : counter + 1
        }
    }
    
    ///Countdown
    private func countdown() {
        if countDown <= 1 {
            finishedText = "Wow!!"
        } else {
            countDown -= 1
        }
    }
    
    ///Time Remaining
    private func updateTimeRamaining() {
        let timeRamening = Calendar.current.dateComponents([.hour, .minute, .second], from: .now, to: nowDate)
        let hour = timeRamening.hour ?? 0
        let minutes = timeRamening.minute ?? 0
        let second = timeRamening.second ?? 0
        
        timeRemaining = "\(hour):\(minutes):\(second)"
    }
}

#Preview {
    TimerBootcamp()
}
