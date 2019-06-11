//
//  RecipeViewController.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/21/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//
import UIKit
import RxSwift

final class MealPlanViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: MealPlanViewModel
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Common.controlText
        label.backgroundColor = UIColor.Common.controlBackground
        return label
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meal plan"
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        view.addSubview(selectButton)
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            selectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            selectButton.heightAnchor.constraint(equalToConstant: 24),
            selectButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24)
            ])
        
        bind()
    }
    
    func bind() {
        viewModel.plan
            .asObservable()
            .map { $0.id }
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        selectButton.rx
            .tap
            .debounce(0.2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.tap)
            .disposed(by: disposeBag)
    }
}
