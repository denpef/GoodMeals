//
//  RootRouter.swift
//  GoodMeals
//
//  Created by Denis Efimov on 4/16/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import UIKit

protocol RootRouter {
    func attachMainController()
}

class RootRouterImpl: RootRouter {
    
    let factory: ViewControllerFactory
    
    private let window: UIWindow
    
    init(window: UIWindow, factory: ViewControllerFactory) {
        self.window = window
        self.factory = factory
    }
    
    func attachMainController() {
        self.animatedTransition(to: self.getMainController())
        window.makeKeyAndVisible()
    }
    
    // MARK: - Private methods
    
    private func animatedTransition(to vc: UIViewController) {
        guard let currentVC = window.rootViewController else {
            window.rootViewController = vc
            return
        }
        
        UIView.transition(from: currentVC.view,
                          to: vc.view,
                          duration: 0.4,
                          options: [.curveEaseOut, .transitionFlipFromLeft]) { _ in
                            self.window.rootViewController = vc
        }
    }
    
    private func getMainController() -> UIViewController {
        return factory.makeRecipesListViewController()
        
    }
}
