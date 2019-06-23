import UIKit

final class RecipeCollectionViewCell: UICollectionViewCell {
    private let recipeCellView = RecipeCellView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(recipeCellView)
        recipeCellView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeCellView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            recipeCellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            recipeCellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            recipeCellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with recipe: Recipe?) {
        recipeCellView.configure(with: recipe)
    }
}
