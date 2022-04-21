//
//  AppDelegate.swift
//  test-rappi-movies
//
//  Created by Sergio Zorrilla Arellano on 11/04/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var realDelegate: AppDelegate?
    static var appDelegate: AppDelegate {
        if Thread.isMainThread {
            return UIApplication.shared.delegate as! AppDelegate
        }
        let dg = DispatchGroup()
        dg.enter()
        DispatchQueue.main.async {
            realDelegate = UIApplication.shared.delegate as? AppDelegate
            dg.leave()
        }
        dg.wait()
        return realDelegate!
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().customNavigationBar()
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    // MARK: - Core Data stack
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "test_rappi_movies")
        
        container.loadPersistentStores { description, error in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error {
                print("CORE DATA", "App store not loaded")
            }
            print("CORE DATA", "App store loaded")
        }
        
        return container
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        return Self.persistentContainer.viewContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = Self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}
