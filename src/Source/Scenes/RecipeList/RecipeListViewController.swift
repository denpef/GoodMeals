import RxSwift
import UIKit

final class RecipesListViewController: ViewController<RecipesListViewModel> {
    private lazy var tableView = UITableView(style: Stylesheet.RecipeList.table)

    override func setupInterface() {
        title = "Recipes"

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    override func bind() {
        viewModel.items
            .drive(tableView.rx.items(cellIdentifier: RecipeCell.reuseIdentifier,
                                      cellType: RecipeCell.self)) { _, recipe, cell in
                cell.configure(with: recipe)
            }.disposed(by: disposeBag)

        tableView.rx.modelSelected(Recipe.self)
            .bind(to: viewModel.selectItem)
            .disposed(by: disposeBag)

        viewModel.reload.accept(())
    }
}
