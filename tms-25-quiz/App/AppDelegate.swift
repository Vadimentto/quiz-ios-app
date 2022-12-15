//
//  AppDelegate.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 18.10.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureFirebase()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if Auth.auth().currentUser == nil {
            let authVC = ScreenFactoryImpl().makeAuthScreen()
            let navigation = UINavigationController(rootViewController: authVC)
            window?.rootViewController = navigation
        }
        else {
            let mainVC = ScreenFactoryImpl().makeMainScreen()
            let navi = UINavigationController(rootViewController: mainVC)
            window?.rootViewController = navi
        }
       
      
//        window?.rootViewController = TotalScoreVC()

        window?.makeKeyAndVisible()
        
        return true
    }
    
    func configureFirebase() {
        FirebaseApp.configure()
    }

}

