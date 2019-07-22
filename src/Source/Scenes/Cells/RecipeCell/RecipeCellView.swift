import UIKit

final class RecipeCellView: UIView {
    private lazy var categoryLabel = UILabel(style: Stylesheet.RecipeCell.category)
    private lazy var titleLabel = UILabel(style: Stylesheet.RecipeCell.title)
    private lazy var calorificalLabel = UILabel(style: Stylesheet.RecipeCell.calorifical)
    private lazy var timeForPreparingLabel = UILabel(style: Stylesheet.RecipeCell.timeForPreparing)
    private lazy var titleImageView = UIImageView(style: Stylesheet.RecipeCell.titleImage)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupLabels()
        backgroundColor = UIColor.Common.mintCream
        clipsToBounds = false
        layer.masksToBounds = false
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 4
        layer.cornerRadius = 8
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageView() {
        addSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 38).isActive = true
        titleImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -42).isActive = true
        titleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        titleImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }

    private func setupLabels() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true

        addSubview(calorificalLabel)
        calorificalLabel.translatesAutoresizingMaskIntoConstraints = false
        calorificalLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        calorificalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        calorificalLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        calorificalLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true

        addSubview(timeForPreparingLabel)
        timeForPreparingLabel.translatesAutoresizingMaskIntoConstraints = false
        timeForPreparingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        timeForPreparingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        timeForPreparingLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        timeForPreparingLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true

        addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
    }

    func configure(with recipe: Recipe?) {
        if let recipe = recipe {
            titleImageView.loadImage(from: recipe.image)
            calorificalLabel.text = "\(recipe.calorific.description) kcal"
            timeForPreparingLabel.text = "\(recipe.timeForPreparing.description)"
            categoryLabel.text = recipe.category?.name
            titleLabel.text = recipe.name
        }
    }
}
