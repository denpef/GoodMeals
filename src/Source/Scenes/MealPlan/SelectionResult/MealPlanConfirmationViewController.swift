import RxSwift
import UIKit

final class MealPlanConfirmationViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: MealPlanConfirmationViewModel

    private var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Common.controlText
        label.text = "Would you like to choose this meal plan starting today?"
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()

    private var acceptButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.Common.controlText
        button.backgroundColor = UIColor.Common.controlBackground
        button.setTitle("Yes", for: .normal)
        return button
    }()

    init(viewModel: MealPlanConfirmationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select date"
        view.backgroundColor = UIColor.Common.white

        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        infoLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true

        view.addSubview(acceptButton)
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        acceptButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        acceptButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        acceptButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        acceptButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        bind()
    }

    func bind() {
        acceptButton.rx
            .tap
            .debounce(0.2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.accept)
            .disposed(by: disposeBag)
    }
}
