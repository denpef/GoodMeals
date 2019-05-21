import UIKit

final class SceneCoordinator {
    private let factory: ViewControllerFactory
    private let window: UIWindow
    
    init(window: UIWindow, factory: ViewControllerFactory) {
        self.window = window
        self.factory = factory
    }
    
    func showRootViewController() {
        let ingredientsListViewController = factory.makeIngredientsListViewController()
        transition(to: factory.makeNavigationController(rootViewController: ingredientsListViewController))
    }
    
    func showIngredient(sender: UIViewController, ingredientId: String? = nil) {
        show(target: factory.makeIngredientViewController(ingredientId: ingredientId), sender: sender)
    }
    
    private func show(target: UIViewController, sender: UIViewController) {
        if let nav = sender as? UINavigationController {
            //push root controller on navigation stack
            nav.pushViewController(target, animated: false)
            return
        }
        
        if let nav = sender.navigationController {
            //add controller to navigation stack
            nav.pushViewController(target, animated: true)
        } else {
            //present modally
            sender.present(target, animated: true, completion: nil)
        }
    }
    // MARK: - Private methods
    
    private func transition(to newViewController: UIViewController) {
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
