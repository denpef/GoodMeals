import UIKit

final class MealPlanCell: UITableViewCell {
    private lazy var titleIMageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageView()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageView() {
        contentView.addSubview(titleIMageView)
        titleIMageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([titleIMageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                                     titleIMageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                                     titleIMageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                                     titleIMageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)])
    }

    func configure(with plans: [DailyPlan]?) {
        if let imagePath = plans?.first?.meals.first?.recipe?.image {
            titleIMageView.loadImage(from: imagePath)
        }
    }
}
