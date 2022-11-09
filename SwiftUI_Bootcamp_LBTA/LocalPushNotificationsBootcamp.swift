//
//  LocalPushNotificationsBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 04.11.2022.
//

import SwiftUI
import UserNotifications
import CoreLocation

final class LocalNotification {
    static let instance = LocalNotification()
    
    func notification() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print(success)
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first local notification"
        content.body = "This was soooo yesy"
        content.sound = .default
        content.badge = 1
        
        //Time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        //Calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 16
//        dateComponents.minute = 6
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
            //Location
        let location = CLCircularRegion(
            center: .init(latitude: .infinity, longitude: .infinity),
            radius: 100,
            identifier: UUID().uuidString)
        location.notifyOnEntry = true
        location.notifyOnExit = false
        let trigger = UNLocationNotificationTrigger(region: location, repeats: true)
        
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotificationCenter() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}
struct LocalPushNotificationsBootcamp: View {
    var body: some View {
        VStack {
            Button {
                LocalNotification.instance.notification()
            } label: {
                Text("Request permission")
            }
            
            Button {
                LocalNotification.instance.scheduleNotification()
            } label: {
                Text("Schedule permission")
            }
            
            Button {
                LocalNotification.instance.cancelNotificationCenter()
            } label: {
                Text("Schedule permission")
            }

        }
    }
}

struct LocalPushNotificationsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalPushNotificationsBootcamp()
    }
}
