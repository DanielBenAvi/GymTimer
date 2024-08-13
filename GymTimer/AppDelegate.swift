//
//  AppDelegate.swift
//  GymTimer
//
//  Created by דניאל בן אבי on 11/08/2024.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let accentColor = "MyAccent"
    let textColor = "MyText"
    let primaryColor = "MyPrimary"
    let secondaryColor = "MySecondary"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        // Navigation bar appearance
        UINavigationBar.appearance().tintColor = UIColor(named: secondaryColor)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: secondaryColor)!]
        
        
        // Button appearance
        UIButton.appearance().tintColor = UIColor(named: secondaryColor)
        
        
        // Textfield appearance
        UITextField.appearance().tintColor = UIColor(named: secondaryColor)
        
        
        
        return true
    }
    
    
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

