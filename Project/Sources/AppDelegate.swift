//
//  AppDelegate.swift
//  BooksKeeper
//
//  Created by Viktoriya on 17.12.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
// MARK: - Properties
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.setInitialViewController()
        return true
    }
    
// MARK: - Set Initial View Controller
    private func setInitialViewController() {
        let controller = StartPageViewController.create()
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
    }

}

