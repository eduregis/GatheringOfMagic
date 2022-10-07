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
        guard let window = self.window else { fatalError("No Window") }
        window.rootViewController = SplashScreenRouter.makeModule()
        window.makeKeyAndVisible()
        AppDelegate.windowView = window
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "DataModel")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
        
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func isFirstOpen() {
        if let firstOpen = UserDefaults.standard.object(forKey: "FirstOpen") as? Date {
            print("The app was first opened on \(firstOpen)")
        } else {
            print("First Open!")
            _ = DataManager.shared.createDeck(name: "Favorites", coverId: "", format: "favorites")
            DataManager.shared.save()
            
            UserDefaults.standard.set(Date(), forKey: "FirstOpen")
        }
    }
}

