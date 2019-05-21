//
//  IngredientViewController.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/21/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//
import UIKit
import RxSwift

final class IngredientViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: IngredientViewModel
    
    init(viewModel: IngredientViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ingredient"
        
        bind()
    }
    
    func bind() {
        
    }
}
