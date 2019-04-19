//
//  Coordinator.swift
//  GoodMeals
//
//  Created by Denis Efimov on 4/16/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import Foundation

final class Coordinator {
    var rootRouter: RootRouter
    
    init(rootRouter: RootRouter) {
        self.rootRouter = rootRouter
    }
    
    func presentRootViewController() {
        self.rootRouter.attachMainController()
    }
}
