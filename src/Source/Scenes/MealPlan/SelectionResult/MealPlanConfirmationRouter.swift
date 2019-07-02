import UIKit

// sourcery:begin: AutoMockable
protocol MealPlanConfirmationRouterType {
    func dismiss()
}

class MealPlanConfirmationRouter: MealPlanConfirmationRouterType {
    weak var viewController: UIViewController?

    func dismiss() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
