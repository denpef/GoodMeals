import UIKit

final class ___VARIABLE_productName: identifier___Assembly {
    static func createModule(serviceLocator: PayServiceLocator) -> UIViewController {
        let view = ___VARIABLE_productName: identifier___ViewController()
        let interactor = ___VARIABLE_productName: identifier___InteractorImpl()
        let router = ___VARIABLE_productName: identifier___RouterImpl(serviceLocator: serviceLocator)
        let state = ___VARIABLE_productName: identifier___State()
        let presenter = ___VARIABLE_productName: identifier___PresenterImpl(view: view,
                                                                            interactor: interactor,
                                                                            router: router,
                                                                            state: state)

        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view

        return view
    }
}
