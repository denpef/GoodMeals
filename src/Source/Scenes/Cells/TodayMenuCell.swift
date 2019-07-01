import RxSwift
import UIKit

final class TodayMenuCell: UITableViewCell {
    private var disposeBag = DisposeBag()
//    private var viewModel: TodayMenuCellViewModel

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Common.controlBackground
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .clear
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = true
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        return view
    }()

    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .magenta
        pageControl.pageIndicatorTintColor = .black
        return pageControl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLabel()
        setupCollectionView()
        setupPageControl()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    private func setupLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }

    private func setupCollectionView() {
        collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecipeCollectionViewCell.reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 38).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }

    private func setupPageControl() {
        contentView.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 6).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 14).isActive = true
        pageControl.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
    }

    func configure(with plans: [Meal]?, dayNumber: Int) {
        switch dayNumber {
        case 1:
            titleLabel.text = "Today menu"
        default:
            titleLabel.text = "Day \(dayNumber) menu"
        }
        pageControl.numberOfPages = plans?.count ?? 0

        Observable.from(optional: plans)
            .bind(to: collectionView.rx.items(cellIdentifier: RecipeCollectionViewCell.reuseIdentifier,
                                              cellType: RecipeCollectionViewCell.self)) { _, plan, cell in
                if let recipe = plan.recipe {
                    cell.configure(with: recipe)
                }
            }.disposed(by: disposeBag)

        // TODO: - navigation to recipe
//        collectionView.rx.modelSelected(Recipe.self)
//            .map{ $0.id }
//            .bind(to: viewModel.recipe)
//            .disposed(by: disposeBag)
    }
}

extension TodayMenuCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return collectionView.frame.size
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }

    func scrollViewWillEndDragging(_: UIScrollView, withVelocity _: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        pageControl.currentPage = Int(targetContentOffset.pointee.x / collectionView.frame.width)
    }
}

// final class TodayMenuCellViewModel {
//    var router: MealPlanRouterType?
//    var recipe = PublishSubject<String>()
//
//    private let disposeBag = DisposeBag()
//
//    // MARK: - Init
//
//    init() {
//        recipe.subscribe(onNext: { [weak self] recipeId in
//            self?.router?.navigateToRecipe(recipeId: recipeId)
//        }).disposed(by: disposeBag)
//    }
// }
