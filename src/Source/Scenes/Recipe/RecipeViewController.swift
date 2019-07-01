//
import RxCocoa
import RxDataSources
import RxSwift
//  RecipeViewController.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/21/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//
import UIKit

final class RecipeViewController: ViewController<RecipeViewModel> {
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

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(IngredientCollectionViewCell.self, forCellWithReuseIdentifier: IngredientCollectionViewCell.reuseIdentifier)
        collectionView.register(RecipeServingCell.self, forCellWithReuseIdentifier: RecipeServingCell.reuseIdentifier)
        title = viewModel.recipe.name
        navigationItem.largeTitleDisplayMode = .never
        configureCollectionView()
        configureDataSource()
        bind()
    }

    // swiftlint:disable force_cast
    private func configureDataSource() {
        dataSource = RxCollectionViewSectionedReloadDataSource<RecipeSection>(configureCell: { _, collectionView, indexPath, item in
            switch item {
            case let .ingredientItem(ingredient: ingredientAmount):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientCollectionViewCell.reuseIdentifier, for: indexPath) as! IngredientCollectionViewCell
                cell.configure(ingredientAmount: ingredientAmount)
                self.viewModel.serving
                    .bind(to: cell.serving)
                    .disposed(by: self.disposeBag)
                return cell
            case let .servingItem(calorific, time):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeServingCell.reuseIdentifier, for: indexPath) as! RecipeServingCell
                cell.configure(calorifical: calorific, timeForPreparing: time)
                cell.countOfServing
                    .bind(to: self.viewModel.serving)
                    .disposed(by: cell.disposeBag)
                cell.addToShoppingListButton.rx
                    .tap
                    .bind(to: self.viewModel.addToShoppingList)
                    .disposed(by: cell.disposeBag)
                return cell
            }
        }, configureSupplementaryView: { _, collectionView, kind, indexPath -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: "HeaderId",
                                                                         for: indexPath) as! RecipeHeaderView
            header.setImage(self.viewModel.recipe.image)

            return header
        })
    }

    override func bind() {
        viewModel.items
            .bind(to: collectionView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
    }

    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self

        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")

        collectionView.register(RecipeHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HeaderId")
    }
}

extension RecipeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection _: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width, height: 70)
        } else {
            return CGSize(width: collectionView.frame.width, height: 40)
        }
    }
}
