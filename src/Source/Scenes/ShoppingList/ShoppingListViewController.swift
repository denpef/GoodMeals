import RxSwift
import UIKit

/**
 Shopping list screen
 */
final class ShoppingListViewController: ViewController<ShoppingListViewModel> {
    private lazy var tableView = UITableView(style: Stylesheet.ShoppingList.tableView)

    override func setupInterface() {
        title = "Shopping list"

        tableView.register(GroceryCell.self, forCellReuseIdentifier: GroceryCell.reuseIdentifier)

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic

        let delelteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: nil)
        navigationItem.rightBarButtonItem = delelteItem

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    override func bind() {
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
