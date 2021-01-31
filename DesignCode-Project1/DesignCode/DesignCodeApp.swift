//
//  DesignCodeApp.swift
//  DesignCode
//
//  Created by Alison Oentoro on 1/3/21.
//

import SwiftUI
import Firebase

@main
struct DesignCodeApp: App {
    @UIApplicationDelegateAdaptor (AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        return true
    }
}
