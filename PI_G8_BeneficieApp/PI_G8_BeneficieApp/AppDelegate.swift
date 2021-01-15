//
//  AppDelegate.swift
//  PI_G8_BeneficieApp
//
//  Created by Juan Souza on 09/11/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    static func isLogged() -> Bool {
            return Auth.auth().currentUser != nil
    }
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        
//        if AppDelegate.isLogged() {
////            guard let windowScene = (scene as? UIWindowScene) else { return }
////            window = UIWindow(windowScene: windowScene)
//
//            // Seta a rootview, a primeira tela a ser exibida
//            let storyboard = UIStoryboard(name: "User_Subscription", bundle: Bundle(for: type(of: self)))
//            self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "User_Subscription")
            
//            let viewDefault = User_SubscriptionViewController()
//            window?.rootViewController = UINavigationController(rootViewController: viewDefault)
            window?.makeKeyAndVisible()
//        }
            
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

