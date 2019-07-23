import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.Common.mintCream
        self.window = window

        let serviceContainer = ServiceContainer()

        let factory = DependencyContainer(serviceContainer: serviceContainer)
        let router = RootRouter(window: window, factory: factory)
        router.showRootViewController()
        return true
    }
}
