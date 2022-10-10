//
//  AppDelegate.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import UIKit
import CoreData

@main class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = {
        return UIWindow()
    }()
    
    static var windowView: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        isFirstOpen()
        createContext()
        return true
    }
    
    func createContext() {
        guard let window = self.window else { fatalError(ErrorMessages.noWindow.localized()) }
        window.rootViewController = SplashScreenRouter.makeModule()
        window.makeKeyAndVisible()
        AppDelegate.windowView = window
    }
    
    func isFirstOpen() {
        if let firstOpen = UserDefaults.standard.object(forKey: "FirstOpen") as? Date {
            print("\(FirstOpenTexts.notFirstOpen.localized()) \(firstOpen)")
        } else {
            print(FirstOpenTexts.firstOpen.localized())
            _ = DataManager.shared.createDeck(name: "Favorites", coverId: "", format: "Favorites")
            DataManager.shared.save()
            
            UserDefaults.standard.set(Date(), forKey: "FirstOpen")
        }
    }
}

