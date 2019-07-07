import RxSwift
import UIKit

final class MealPlanConfirmationViewController: ViewController<MealPlanConfirmationViewModel> {
    private let infoLabel = UILabel(style: Stylesheet.MealPlanConfirmation.infoLabel)
    private let planImageView = UIImageView(style: Stylesheet.MealPlanConfirmation.planImage)
    private let acceptButton = UIButton(style: Stylesheet.MealPlanConfirmation.acceptButton)

    override func setupInterface() {
        view.backgroundColor = UIColor.Common.white

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
        viewModel.title
            .drive(rx.title)
            .disposed(by: disposeBag)

        viewModel.planImage
            .drive(onNext: { [weak self] image in
                self?.planImageView.loadImage(from: image)
            }).disposed(by: disposeBag)

        acceptButton.rx
            .tap
            .debounce(0.2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.acceptAction)
            .disposed(by: disposeBag)
    }
}
