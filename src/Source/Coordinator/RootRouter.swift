import UIKit

protocol RootRouter {
    func presentMainController()
}

class RootRouterImpl: RootRouter {
    private let factory: ViewControllerFactory
    private let window: UIWindow
    
    init(window: UIWindow, factory: ViewControllerFactory) {
        self.window = window
        self.factory = factory
    }
    
    func presentMainController() {
        transition(to: factory.makeRecipesListViewController())
    }
    
    // MARK: - Private methods
    
    func transition(to newViewController: UIViewController) {
        guard let rootViewController = window.rootViewController else {
            showWindow(with: newViewController)
            return
        }
        UIView.transition(from: rootViewController.view,
                          to: newViewController.view,
                          duration: 3,
                          options: [.curveEaseOut, .transitionFlipFromLeft]) { _ in
                            self.showWindow(with: newViewController)
        }
    }
    
    private func showWindow(with viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
