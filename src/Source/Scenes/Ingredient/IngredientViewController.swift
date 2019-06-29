//
import RxSwift
//  IngredientViewController.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/21/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//
import UIKit

final class IngredientViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: IngredientViewModel

    private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.adjustsFontSizeToFitWidth = true
        textField.textColor = UIColor.Common.controlText
        textField.backgroundColor = UIColor.Common.controlBackground
        return textField
    }()

    private var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.Common.controlText
        button.backgroundColor = UIColor.Common.controlBackground
        button.setTitle("Save", for: .normal)
        return button
    }()

    init(viewModel: IngredientViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ingredient"

        view.addSubview(nameTextField)
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true

        view.addSubview(saveButton)
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -26).isActive = true

        nameTextField.text = viewModel.name.value

        bind()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.becomeFirstResponder()
    }

    func bind() {
        nameTextField.rx
            .text
            .orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)

        saveButton.rx
            .tap
            .debounce(0.2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.tap)
            .disposed(by: disposeBag)

        viewModel.isSaved
            .asDriver()
            .drive(saveButton.rx.isHidden)
            .disposed(by: disposeBag)
    }
}
