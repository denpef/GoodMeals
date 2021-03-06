import UIKit

final class RecipeCollectionViewCell: UICollectionViewCell {
    var recipe: Recipe?
    private let recipeCellView = RecipeCellView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.Common.mintCream
        addSubview(recipeCellView)
        recipeCellView.translatesAutoresizingMaskIntoConstraints = false
        recipeCellView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        recipeCellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        recipeCellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        recipeCellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with recipe: Recipe?) {
        self.recipe = recipe
        recipeCellView.configure(with: recipe)
    }
}
