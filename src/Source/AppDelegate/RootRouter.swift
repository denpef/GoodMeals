import UIKit

final class RootRouter {
    private let factory: ViewControllerFactory
    private let window: UIWindow
    
    init(window: UIWindow, factory: ViewControllerFactory) {
        self.window = window
        self.factory = factory
    }
    
    func showRootViewController() {
        let todayMenu = UINavigationController(rootViewController: factory.makeTodayMenuViewController())
        todayMenu.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 3)
        
        let recipesList = UINavigationController(rootViewController: factory.makeRecipesListViewController())
        recipesList.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        let shoppingList = UINavigationController(rootViewController: factory.makeShoppingListViewController())
        shoppingList.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        
        let mealPlansList = UINavigationController(rootViewController: factory.makeMealPlansListViewController())
        mealPlansList.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 4)
        
        let tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.viewControllers = [todayMenu, shoppingList, recipesList, mealPlansList]
        
        transition(to: tabBarController)
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
