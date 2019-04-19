final class Coordinator {
    private var rootRouter: RootRouter
    
    init(rootRouter: RootRouter) {
        self.rootRouter = rootRouter
    }
    
    func presentRootViewController() {
        self.rootRouter.presentMainController()
    }
}
