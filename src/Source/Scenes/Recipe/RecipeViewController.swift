import RxDataSources
import RxSwift
import UIKit

/**
 Recipe screen with list of ingredients and opportunity add them to shopping list
 */
final class RecipeViewController: ViewController<RecipeViewModel> {
    private let infoView = UIView(style: Stylesheet.Recipe.infoView)
    private let infoLabel = UILabel(style: Stylesheet.Recipe.infoLabel)
    private let collectionView: UICollectionView = {
        let flowLayout = StretchyHeaderLayout()
        flowLayout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.apply(Stylesheet.Recipe.collection)
        return view
    }()

    private var dataSource: RxCollectionViewSectionedReloadDataSource<RecipeSection>?
    private var infoTimer: Timer?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func setupInterface() {
        collectionView.register(IngredientCollectionViewCell.self, forCellWithReuseIdentifier: IngredientCollectionViewCell.reuseIdentifier)
        collectionView.register(RecipeServingCell.self, forCellWithReuseIdentifier: RecipeServingCell.reuseIdentifier)
        navigationItem.largeTitleDisplayMode = .never
        configureCollectionView()
        configureDataSource()
        configureInfoView()
    }

    private func configureDataSource() {
        dataSource = RxCollectionViewSectionedReloadDataSource<RecipeSection>(configureCell: { _, collectionView, indexPath, item in
            switch item {
            case let .ingredientItem(ingredient: ingredientAmount):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientCollectionViewCell.reuseIdentifier,
                                                              for: indexPath)
                if let cell = cell as? IngredientCollectionViewCell {
                    cell.configure(ingredientAmount: ingredientAmount)
                    self.viewModel.serving
                        .bind(to: cell.serving)
                        .disposed(by: self.disposeBag)
                }
                return cell
            case let .servingItem(calorific, time):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeServingCell.reuseIdentifier,
                                                              for: indexPath)
                if let cell = cell as? RecipeServingCell {
                    cell.configure(calorifical: calorific, timeForPreparing: time)
                    cell.countOfServing
                        .bind(to: self.viewModel.serving)
                        .disposed(by: cell.disposeBag)
                    cell.addShoppingButton.rx
                        .tap
                        .bind(to: self.viewModel.addToShoppingListAction)
                        .disposed(by: cell.disposeBag)
                }
                return cell
            }
        }, configureSupplementaryView: { _, collectionView, kind, indexPath -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderId", for: indexPath)
            if let header = header as? RecipeHeaderView {
                self.viewModel.image.subscribe(onNext: { image in
                    header.setImage(image)
                }).disposed(by: self.disposeBag)
            }
            return header
        })
    }

    override func bind() {
        viewModel.title
            .drive(rx.title)
            .disposed(by: disposeBag)

        guard let dataSource = dataSource else {
            return
        }
        viewModel.items
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.addToShoppingListAction.subscribe(onNext: { [weak self] _ in
            UIView.animate(withDuration: 1) {
                self?.showInfoView()
            }
        }).disposed(by: disposeBag)
    }

    private func showInfoView() {
        infoView.isHidden = false
        infoView.alpha = 1
        infoTimer?.invalidate()
        infoTimer = Timer.scheduledTimer(timeInterval: 2,
                                         target: self,
                                         selector: #selector(hideInfoView),
                                         userInfo: nil,
                                         repeats: true)
    }

    @objc private func hideInfoView() {
        infoTimer?.invalidate()
        UIView.animate(withDuration: 1,
                       animations: { self.infoView.alpha = 0 },
                       completion: { _ in self.infoView.isHidden = true })
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

    private func configureInfoView() {
        view.addSubview(infoView)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        infoView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        infoView.addSubview(infoLabel)
        infoLabel.text = "The recipe has been added"
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: infoView.centerYAnchor).isActive = true
    }
}

extension RecipeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection _: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width, height: 70)
        } else {
            return CGSize(width: collectionView.frame.width, height: 40)
        }
    }
}
