//
//  AppDelegate.swift
//  WorldWeb
//
//  Created by Ilya Turin on 18.03.2022.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = MainScreenAssembly.assembleModule()
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

}

