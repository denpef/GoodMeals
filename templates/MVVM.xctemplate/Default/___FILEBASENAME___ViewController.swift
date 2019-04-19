import UIKit

final class ___VARIABLE_productName: identifier___ViewController: UIViewController, ___VARIABLE_productName: identifier___View {
    // MARK: - Outlets

    // MARK: - Init

    public init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.didTriggerViewDidLoad()
    }

    // MARK: - Actions

    // MARK: - ___VARIABLE_productName:identifier___View

    var presenter: ___VARIABLE_productName: identifier___Presenter?
}
