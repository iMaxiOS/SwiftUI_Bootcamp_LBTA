//
//  CloudKitNotificationBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 14.11.2023.
//

import SwiftUI
import CloudKit

final class CloudKitNotificationViewModel: ObservableObject {
    
    @Published var statusError: String = ""
    
    init() {
        
    }
    
    func requestNotificationPermissions() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { isSuccess, error in
            if let error = error {
                print("Error: Auth notification center - \(error)")
            } else if isSuccess {
                print("Notification Permissions Success!!")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Notification Permissions Failure.")
            }
        }
    }
    
    func subscribeToNotifications() {
        let predicate = NSPredicate(value: true)
        let subscription = CKQuerySubscription(recordType: "Fruits", predicate: predicate, subscriptionID: "fruits_added_to_database", options: .firesOnRecordCreation)
        let notification = CKSubscription.NotificationInfo()
        notification.title = "There is a new fruit."
        notification.alertBody = "Open the app to check your fruit."
        notification.soundName = "default"
        
        subscription.notificationInfo = notification
        
        CKContainer.default().publicCloudDatabase.save(subscription) { subscription, error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Successful subscribed to notification.")
            }
        }
    }
    
    func unsubscribeToNotification() {
        CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: "fruits_added_to_database") { returnString, error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Unsuccessful subscribed to notification.")
            }
        }
    }
}

struct CloudKitNotificationBootcamp: View {
    
    @StateObject private var vm = CloudKitNotificationViewModel()
    
    var body: some View {
        VStack {
            Button {
                vm.requestNotificationPermissions()
            } label: {
                Text("Request Notification Permissions")
                    .modifier(ButtonModifier())
            }
            
            
            Button {
                vm.subscribeToNotifications()
            } label: {
                Text("Subscribe To Notifications")
                    .modifier(ButtonModifier())
            }
            
            Button {
                vm.unsubscribeToNotification()
            } label: {
                Text("Unsubscribe To Notifications")
                    .modifier(ButtonModifier())
            }
        }
    }
}

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline.bold())
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
            .blendMode(.difference)
    }
}

#Preview {
    CloudKitNotificationBootcamp()
}
