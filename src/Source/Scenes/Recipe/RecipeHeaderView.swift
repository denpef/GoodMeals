import UIKit

final class RecipeHeaderView: UICollectionReusableView {
    private var imageView = UIImageView(style: Stylesheet.RecipeHeader.image)

    func setImage(_ image: String) {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.sd_setImage(with: URL(string: image))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.Common.mintCream
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
