//
//  AppDelegate.swift
//  Myles Contact List
//
//  Created by Myles Young on 11/2/19.
//  Copyright © 2019 Myles Young. All rights reserved.
//
import CoreData
import UIKit
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let settings = UserDefaults.standard
        
        if(settings.string(forKey: Constants.kSortField) == nil ) {
            settings.set("City", forKey: Constants.kSortField)
        }
        if(settings.string(forKey: Constants.kSortDirection) == nil) {
            settings.set(true, forKey: Constants.kSortDirection)
        }
        settings.synchronize()
        
        NSLog("Sort field : %@", settings.string(forKey: Constants.kSortField)!)
        NSLog("Sort direction : \(settings.bool(forKey: Constants.kSortDirection))")

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

    // MARK: - Core Data stack
    /*
      The persistent container for the application. This implementation
      creates and returns a container, having loaded the store for the
      application to it. This property is optional since there are legitimate
      error conditions that could cause the creation of the store to fail.
    */
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyContactListModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should
                // not use this function in a shipping application, although it may be useful during
                // development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when
                 * the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
        
    // MARK: - Core Data Saving support
    //called whenever data changes need to be saved to the persistent container.
    func saveContext () {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}



