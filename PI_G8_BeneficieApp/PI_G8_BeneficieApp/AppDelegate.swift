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
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // Use Firebase library to configure APIs
        
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                let authError = error as NSError
                if (authError.code == AuthErrorCode.secondFactorRequired.rawValue) {
                    // The user is a multi-factor user. Second factor challenge is required.
                    let resolver = authError.userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                    var displayNameString = ""
                    for tmpFactorInfo in (resolver.hints) {
                        displayNameString += tmpFactorInfo.displayName ?? ""
                        displayNameString += " "
                    }
                    
                    self.showTextInputPrompt(withMessage: "Select factor to sign in\n\(displayNameString)", completionBlock: { userPressedOK, displayName in
                        var selectedHint: PhoneMultiFactorInfo?
                        for tmpFactorInfo in resolver.hints {
                            if (displayName == tmpFactorInfo.displayName) {
                                selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
                            }
                        }
                        PhoneAuthProvider.provider().verifyPhoneNumber(with: selectedHint!, uiDelegate: nil, multiFactorSession: resolver.session) { verificationID, error in
                            if error != nil {
                                print("Multi factor start sign in failed. Error: \(error.debugDescription)")
                            } else {
                                self.showTextInputPrompt(withMessage: "Verification code for \(selectedHint?.displayName ?? "")", completionBlock: { userPressedOK, verificationCode in
                                    let credential: PhoneAuthCredential? = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode!)
                                    let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator.assertion(with: credential!)
                                    resolver.resolveSignIn(with: assertion!) { authResult, error in
                                        if error != nil {
                                            print("Multi factor finanlize sign in failed. Error: \(error.debugDescription)")
                                        } else {
//                                            self.navigationController?.popViewController(animated: true)
                                        }
                                    }
                                })
                            }
                        }
                    })
                } else {
                    self.showMessagePrompt(error.localizedDescription)
                    return
                }
                // ...
                return
            }
            
            
            let storyboard = UIStoryboard(name: "User_Subscription", bundle: nil)
            UIViewController.replaceRootViewController(viewController: storyboard.instantiateInitialViewController()!)
            
//            let navi = UINavigationController()
//            navi.pushViewController(storyboard.instantiateViewController(withIdentifier: "User_Subscription"), animated: true)
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
            // Perform any operations when the user disconnects from app here.
            // ...
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    
    static func isLogged() -> Bool {
            return Auth.auth().currentUser != nil
    }
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()

        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        
        
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
    
    func showTextInputPrompt(withMessage: String, completionBlock: (_ userPressedOK: Bool, _ displayName: String?) -> Void){
        print(withMessage)
    }
    
    func showMessagePrompt(_ message: String) {
        print(message)
    }

    func signInWithGoogle(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        
        
    }
}



