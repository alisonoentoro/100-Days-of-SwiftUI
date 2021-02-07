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
            Home().environmentObject(UserStore())
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

class ScenceDelegate:UIResponder, UISceneDelegate{
    
    var window: UIWindow?
    
    func scene (_ scene: UIScene, willConnectTo session: UISceneSession, options connectingOptions: UIScene.ConnectionOptions){
        
        let contentView = Home()
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            window.rootViewController = UIHostingController(rootView:
            contentView.environmentObject(UserStore()))
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
