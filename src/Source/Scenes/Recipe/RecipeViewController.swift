//
//  RecipeViewController.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/21/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class RecipeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: RecipeViewModel
    private var dataSource: RxCollectionViewSectionedReloadDataSource<RecipeSection>?
    
    let collectionView: UICollectionView = {
        let flowLayout = StretchyHeaderLayout()
        flowLayout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .white
        view.alwaysBounceVertical = true
        view.alwaysBounceHorizontal = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    init(viewModel: RecipeViewModel) {
        self.viewModel = viewModel
        collectionView.register(IngredientCollectionViewCell.self, forCellWithReuseIdentifier: IngredientCollectionViewCell.reuseIdentifier)
        collectionView.register(RecipeInfoCell.self, forCellWithReuseIdentifier: RecipeInfoCell.reuseIdentifier)
        collectionView.register(RecipeServingCell.self, forCellWithReuseIdentifier: RecipeServingCell.reuseIdentifier)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.recipe.name
        navigationItem.largeTitleDisplayMode = .never
        configureCollectionView()
        configureDataSource()
        bind()
    }
    
    private func configureDataSource() {
        dataSource = RxCollectionViewSectionedReloadDataSource<RecipeSection>(
            configureCell: { dataSource, collectionView, indexPath, item in
                switch item {
                case let .IngredientItem(ingredient: ingredientAmount):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientCollectionViewCell.reuseIdentifier, for: indexPath) as! IngredientCollectionViewCell
                    cell.configure(ingredientAmount: ingredientAmount)
                    self.viewModel.serving
                        .bind(to: cell.serving)
                        .disposed(by: self.disposeBag)
                    return cell
                case let .RecipeInfoItem(calorific: calorific, timeForPreparing: time):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeInfoCell.reuseIdentifier, for: indexPath) as! RecipeInfoCell
                    cell.configure(calorifical: calorific, timeForPreparing: time)
                    return cell
                case .ServingItem:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeServingCell.reuseIdentifier, for: indexPath) as! RecipeServingCell
                    cell.countOfServing
                        .bind(to: self.viewModel.serving)
                        .disposed(by: self.disposeBag)
                    return cell
                }
        }, configureSupplementaryView: { dataSource, collectionView, kind, indexPath -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: "HeaderId",
                                                                         for: indexPath) as! RecipeHeaderView
            header.setImage(self.viewModel.recipe.image)
            
            return header
        })
    }
    
    func bind() {
        
        viewModel.items
            .bind(to: collectionView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
        
//        addToShoppingListButton.rx
//            .tap
//            .debounce(0.2, scheduler: MainScheduler.instance)
//            .bind(to: viewModel.addToShoppingList)
//            .disposed(by: disposeBag)
        
//        viewModel.isAdded
//            .asDriver()
//            .drive(saveButton.rx.isHidden)
//            .disposed(by: disposeBag)
        
        
//        let sections: [MultipleSectionModel] = [
//            .ImageProvidableSection(title: "Section 1",
//                                    items: [.ImageSectionItem(image: UIImage(named: "settings")!, title: "General")]),
//            .ToggleableSection(title: "Section 2",
//                               items: [.ToggleableSectionItem(title: "On", enabled: true)]),
//            .StepperableSection(title: "Section 3",
//                                items: [.StepperSectionItem(title: "1")])
//        ]
//
//        let dataSource = MultipleSectionModelViewController.dataSource()
//
//        viewModel.sections
//            .bind(to: tableView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
//        collectionView.dataSource = self
        
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        
        collectionView.register(RecipeHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HeaderId")
    }
}

extension RecipeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}
