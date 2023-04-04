//
//  YouDecideApp.swift
//  YouDecide
//
//  Created by Daniel Jones on 24/09/2022.
//

import SwiftUI
import Firebase

@main
struct YouDecideApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
        
        //Request notification permissions
        let notifCenter = UNUserNotificationCenter.current()
        notifCenter.getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("DEBUG: Notification permissions authorized")
                    } else if let error = error {
                        print("DEBUG: Error when requesting notification permissions - \(error.localizedDescription)")
                    }
                }
            } else if settings.authorizationStatus == .denied {
                print("DEBUG: Notification permissions have been previously denied")
                
            } else if settings.authorizationStatus == .authorized {
                print("DEBUG: Notification permissions have been previously authorized")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }.environmentObject(viewModel)
        }
    }
}
