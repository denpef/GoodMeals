import UIKit

final class MealPlanCell: UITableViewCell {
    private lazy var titleImageView = UIImageView(style: Stylesheet.MealPlanCell.titleImage)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.Common.mintCream
        selectionStyle = .none
        setupImageView()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageView() {
        contentView.addSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        titleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        titleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }

    func configure(with image: String) {
        titleImageView.loadImage(from: image)
    }
}
