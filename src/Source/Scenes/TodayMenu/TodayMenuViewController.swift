import RxSwift
import UIKit

/**
 Screen show current meal plan recipes by days begin from today
 */
final class TodayMenuViewController: ViewController<TodayMenuViewModel> {
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.apply(Stylesheet.TodayMenu.table)
        return view
    }()

    private let onboardingLabel = UILabel(style: Stylesheet.Common.onboarding)
    private let selectPlanButton = UIButton(style: Stylesheet.TodayMenu.select)

    override func setupInterface() {
        tableView.register(TodayMenuCell.self, forCellReuseIdentifier: TodayMenuCell.reuseIdentifier)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        setupTableView()
        setupOnboarding()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func setupOnboarding() {
        view.addSubview(onboardingLabel)
        onboardingLabel.translatesAutoresizingMaskIntoConstraints = false
        onboardingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        onboardingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        onboardingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        onboardingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true

        view.addSubview(selectPlanButton)
        selectPlanButton.translatesAutoresizingMaskIntoConstraints = false
        selectPlanButton.topAnchor.constraint(equalTo: onboardingLabel.bottomAnchor, constant: 40).isActive = true
        selectPlanButton.heightAnchor.constraint(equalToConstant: 40)
        selectPlanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        selectPlanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
    }

    override func bind() {
        viewModel.title
            .drive(rx.title)
            .disposed(by: disposeBag)

        viewModel.hideOnboarding
            .drive(selectPlanButton.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.hideOnboarding
            .drive(onboardingLabel.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.onboardingText
            .drive(onboardingLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.selectPlanText
            .drive(selectPlanButton.rx.title())
            .disposed(by: disposeBag)

        viewModel.items
            .drive(tableView.rx
                .items(cellIdentifier: TodayMenuCell.reuseIdentifier, cellType: TodayMenuCell.self)) { [weak self] _, item, cell in
                guard let self = self else {
                    return
                }
                cell.configure(with: item.meals, dayNumber: item.dayNumber, numberOfPages: item.meals.count)
                cell.recipeSelected
                    .flatMap { Observable.from(optional: $0) }
                    .bind(to: self.viewModel.recipeSelected)
                    .disposed(by: cell.disposeBag)
            }.disposed(by: disposeBag)

        selectPlanButton.rx
            .tap
            .bind(to: viewModel.mealPlansAction)
            .disposed(by: disposeBag)

        if let item = navigationItem.rightBarButtonItem {
            viewModel.selectPlanText
                .drive(item.rx.title)
                .disposed(by: disposeBag)

            item.rx.tap
                .bind(to: viewModel.mealPlansAction)
                .disposed(by: disposeBag)
        }

        viewModel.reload.accept(())
    }
}
