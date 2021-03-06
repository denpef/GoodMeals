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
        todayMenu.tabBarItem = UITabBarItem(title: "Today menu", image: Asset.tabbarMenu.image, tag: 3)
        todayMenu.navigationBar.apply(Stylesheet.Bars.common)

        let recipesList = UINavigationController(rootViewController: factory.makeRecipesListViewController())
        recipesList.tabBarItem = UITabBarItem(title: "Recipes", image: Asset.tabbarRecipes.image, tag: 2)
        recipesList.navigationBar.apply(Stylesheet.Bars.common)

        let shoppingList = UINavigationController(rootViewController: factory.makeShoppingListViewController())
        shoppingList.tabBarItem = UITabBarItem(title: "Shopping list", image: Asset.tabbarShopping.image, tag: 1)
        shoppingList.navigationBar.apply(Stylesheet.Bars.common)

        let tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.viewControllers = [todayMenu, shoppingList, recipesList]
        tabBarController.tabBar.apply(Stylesheet.Bars.common)

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
