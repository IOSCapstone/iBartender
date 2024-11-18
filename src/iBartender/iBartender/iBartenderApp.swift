//
//  iBartenderApp.swift
//  iBartender
//
//  Created by Amin Carbonell on 11/9/24.
//

import SwiftUI
import FirebaseCore

@main
struct iBartenderApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                WelcomePageView()
            }
        }
    }
}
