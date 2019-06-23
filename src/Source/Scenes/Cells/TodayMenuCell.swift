import RxSwift
import UIKit

final class TodayMenuCell: UITableViewCell {
    private var disposeBag = DisposeBag()

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

    private func setupCollectionView() {
        collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecipeCollectionViewCell.reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
                                     collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
    }

    private func setupPageControl() {
        contentView.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 4),
                                     pageControl.heightAnchor.constraint(equalToConstant: 16),
                                     pageControl.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
                                     pageControl.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor)])
    }

    func configure(with plans: [Meal]?) {
        pageControl.numberOfPages = plans?.count ?? 0

        Observable.from(optional: plans)
            .bind(to: collectionView.rx.items(cellIdentifier: RecipeCollectionViewCell.reuseIdentifier,
                                              cellType: RecipeCollectionViewCell.self)) { _, plan, cell in
                if let recipe = plan.recipe {
                    cell.configure(with: recipe)
                }
            }.disposed(by: disposeBag)
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
