//
import RxDataSources
import RxSwift
//  RecipeViewController.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/21/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//
import UIKit

final class MealPlanViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: MealPlanViewModel

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.rowHeight = 264
        view.backgroundColor = .clear
        view.separatorStyle = .none
        return view
    }()

    private var selectButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.Common.controlText
        button.backgroundColor = UIColor.Common.controlBackground
        button.setTitle("Select plan", for: .normal)
        return button
    }()

    init(viewModel: MealPlanViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title

        view.addSubview(selectButton)
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        selectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        selectButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        selectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        tableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: selectButton.topAnchor).isActive = true

        bind()
    }

    func bind() {
        selectButton.rx
            .tap
            .debounce(0.2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.tap)
            .disposed(by: disposeBag)

        let dataSource = RxTableViewSectionedReloadDataSource<MealPlanTableViewSection>(configureCell: { _, tableView, _, recipe in
            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.reuseIdentifier) as! RecipeCell
            cell.configure(with: recipe)
            return cell
        })

        dataSource.titleForHeaderInSection = { dataSource, index in
            dataSource.sectionModels[index].header
        }

        Observable.just(viewModel.sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
