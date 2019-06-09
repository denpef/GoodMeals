import UIKit
import RxSwift
import RxCocoa

final class TodayMenuViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
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
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .magenta
        pageControl.pageIndicatorTintColor = .black
        return pageControl
    }()
    
    private var viewModel: TodayMenuViewModel
    
    init(viewModel: TodayMenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Today menu"
        
        setupCollectionView()
        setupPageControl()
        bind()
    }
    
    private func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
                                     collectionView.heightAnchor.constraint(equalToConstant: 250),
                                     collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)])
    }
    
    private func setupPageControl() {
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
                                     pageControl.heightAnchor.constraint(equalToConstant: 30),
                                     pageControl.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
                                     pageControl.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor)])
    }
    
    private func bind() {
        viewModel.items
            .bind(to: collectionView.rx
                .items(cellIdentifier: "CellId")) { row, item, cell in
                    cell.backgroundColor = .clear
                    let image = UIImageView(frame: .zero)
                    cell.addSubview(image)
                    switch item {
                    case "1":
                        image.backgroundColor = UIColor.Common.controlBackground
                    case "2":
                        image.backgroundColor = UIColor.yellow
                    default:
                        image.backgroundColor = UIColor.green
                    }
                    image.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        image.topAnchor.constraint(equalTo: cell.topAnchor, constant: 30),
                        image.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -30),
                        image.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 30),
                        image.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -30)])
                    image.clipsToBounds = true
                    image.layer.cornerRadius = 20
            }.disposed(by: disposeBag)
    }
}

extension TodayMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        pageControl.currentPage = Int(targetContentOffset.pointee.x / collectionView.frame.width)
    }
}
