import UIKit
import RxSwift
import RxCocoa

final class TodayMenuViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.rowHeight = 284
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.allowsSelection = false
        return view
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
        setupTableView()
        bind()
    }
    
    private func setupTableView() {
        tableView.register(TodayMenuCell.self, forCellReuseIdentifier: "TableViewCellId")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
    
    private func bind() {
        viewModel.items
            .bind(to: tableView.rx
                .items(cellIdentifier: "TableViewCellId", cellType: TodayMenuCell.self)) { row, item, cell in
                    //print(item.id)
                    cell.configure(with: item.meals)
            }.disposed(by: disposeBag)
        
        //        viewModel.items
        //            .asObservable()
        //            .map { $0.count }
        //            .bind(to: pageControl.rx.numberOfPages)
        //            .disposed(by: disposeBag)
        
        //        viewModel.items
        //            .asObservable()
        //            .map { plans -> [DailyPlan] in
        //                if let dailyPlans = plans.first?.mealPlan?.dailyPlans {
        //                    return dailyPlans
        //                }
        //                return []
        //            }
        //            .bind(to: collectionView.rx
        //                .items(cellIdentifier: "CellId")) { row, item, cell in
        //                    cell.backgroundColor = .clear
        //                    let imageView = UIImageView(frame: .zero)
        //                    imageView.backgroundColor = .orange
        //                    imageView.contentMode = .scaleAspectFill
        //                    cell.addSubview(imageView)
        //                    imageView.translatesAutoresizingMaskIntoConstraints = false
        //                    NSLayoutConstraint.activate([
        //                        imageView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 30),
        //                        imageView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -30),
        //                        imageView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 30),
        //                        imageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -30)])
        //                    imageView.clipsToBounds = true
        //                    imageView.layer.cornerRadius = 20
        //                    print(item.id)
        //                    if let path = item[.breakfast]?.image {
        //                        imageView.loadImage(from: path)
        //                    }
        //            }.disposed(by: disposeBag)
    }
}

final  class TodayMenuCell: UITableViewCell {
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
    
    private func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
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
        
        let observablePlans = Observable.from(optional: plans)
        
        observablePlans
            .map { $0.count }
            .bind(to: pageControl.rx.numberOfPages)
            .disposed(by: disposeBag)
        
        observablePlans
            .bind(to: collectionView.rx
                .items(cellIdentifier: "CellId")) { row, item, cell in
                    cell.backgroundColor = .clear
                    let imageView = UIImageView(frame: .zero)
                    imageView.backgroundColor = .orange
                    imageView.contentMode = .scaleAspectFill
                    cell.addSubview(imageView)
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        imageView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 16),
                        imageView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -16),
                        imageView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 16),
                        imageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -16)])
                    imageView.clipsToBounds = true
                    imageView.layer.cornerRadius = 15
                    if let path = item.recipe?.image {
                        imageView.loadImage(from: path)
                        //print("\(item.recipe?.name) - \(path)")
                    }
                }.disposed(by: disposeBag)
    }
}

extension TodayMenuCell: UICollectionViewDelegateFlowLayout {
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
