import RxSwift
import UIKit

final class MealPlanConfirmationViewController: ViewController<MealPlanConfirmationViewModel> {
    private var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Common.controlBackground
        label.text = "Would you like to choose this meal plan starting today?"
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()

    private let planImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()

    private var acceptButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.Common.controlText
        button.backgroundColor = UIColor.Common.controlBackground
        button.setTitle("Yes", for: .normal)
        button.layer.shadowOpacity = 0.15
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowRadius = 8
        button.layer.cornerRadius = 12
        button.layer.opacity = 0.95
        return button
    }()

    override func setupInterface() {
        title = "Select date"
        view.backgroundColor = UIColor.Common.white

        planImageView.loadImage(from: viewModel.mealPlan.image)

        view.addSubview(planImageView)
        planImageView.translatesAutoresizingMaskIntoConstraints = false
        planImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        planImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        planImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        planImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        planImageView.heightAnchor.constraint(equalTo: planImageView.widthAnchor, multiplier: 1 / 2).isActive = true

        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.topAnchor.constraint(equalTo: planImageView.bottomAnchor, constant: 24).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true

        view.addSubview(acceptButton)
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        acceptButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        acceptButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        acceptButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        acceptButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 24).isActive = true
    }

    override func bind() {
        acceptButton.rx
            .tap
            .debounce(0.2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.accept)
            .disposed(by: disposeBag)
    }
}
