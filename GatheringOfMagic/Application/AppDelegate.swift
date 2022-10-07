//
//  AppDelegate.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import UIKit

@main class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = {
        return UIWindow()
    }()
    
    static var windowView: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        createContext()
        return true
    }
    
    func createContext() {
        guard let window = self.window else { fatalError("No Window") }
        window.rootViewController = SplashScreenRouter.makeModule()
        window.makeKeyAndVisible()
        AppDelegate.windowView = window
    }
}

