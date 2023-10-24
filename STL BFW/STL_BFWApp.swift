//
//  STL_BFWApp.swift
//  STL BFW
//
//  Created by Roger ADT on 9/13/23.
//

import SwiftUI
import UserNotifications

@main
struct STL_BFWApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Request notification permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permissions granted")
            } else {
                print("Notification permissions denied")
            }
        }
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
}
