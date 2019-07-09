import RxSwift
import UIKit

/**
 Shopping list screen
 */
final class ShoppingListViewController: ViewController<ShoppingListViewModel> {
    private lazy var tableView = UITableView(style: Stylesheet.ShoppingList.tableView)
    private let onboardingLabel = UILabel(style: Stylesheet.Common.onboarding)

    override func setupInterface() {
        title = "Shopping list"
        setupNavigation()
        setupTableView()
        setupOnboarding()
    }

    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic

        let delelteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: nil)
        navigationItem.rightBarButtonItem = delelteItem
    }

    private func setupTableView() {
        view.addSubview(tableView)

        tableView.register(GroceryCell.self, forCellReuseIdentifier: GroceryCell.reuseIdentifier)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func setupOnboarding() {
        view.addSubview(onboardingLabel)
        onboardingLabel.translatesAutoresizingMaskIntoConstraints = false
        onboardingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        onboardingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        onboardingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        onboardingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
    }

    override func bind() {
        viewModel.hideOnboarding
            .drive(onboardingLabel.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.onboardingText
            .drive(onboardingLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.items
            .drive(tableView.rx.items(cellIdentifier: GroceryCell.reuseIdentifier,
                                      cellType: GroceryCell.self)) { _, item, cell in
                let vm = GroceryCellViewModel()

                cell.configure(with: vm)

                vm.itemMarked
                    .bind(to: self.viewModel.markedItem)
                    .disposed(by: cell.disposeBag)

                vm.itemDeleted
                    .bind(to: self.viewModel.deleteItem)
                    .disposed(by: cell.disposeBag)

                vm.shoppingItem.accept(item)
            }.disposed(by: disposeBag)

        navigationItem.rightBarButtonItem?.rx
            .tap
            .bind(to: viewModel.deleteAllList)
            .disposed(by: disposeBag)

        viewModel.reload.accept(())
    }
}
