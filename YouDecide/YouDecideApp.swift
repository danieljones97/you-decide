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
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }.environmentObject(viewModel)
        }
    }
}
