//
//  AppDelegate.swift
//  GoodMeals
//
//  Created by Denis Efimov on 3/17/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        self.window = window
        
        let serviceLocator = ServiceLocator()
        let factory = DependencyContainer(serviceLocator: serviceLocator)
        let router = RootRouter(window: window, factory: factory)
        router.showRootViewController()
        return true
    }
}
