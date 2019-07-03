import UIKit

enum Stylesheet {
    enum ServingCell {
        static let info = Style<UILabel> {
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }

        static let plus = Style<UIButton> {
            $0.setImage(Asset.plus.image, tintColor: UIColor.Common.controlBackground)
            $0.contentMode = .scaleAspectFill
        }

        static let minus = Style<UIButton> {
            $0.setImage(Asset.minus.image, tintColor: UIColor.Common.controlBackground)
            $0.contentMode = .scaleAspectFill
        }

        static let addToShoppingList = Style<UIButton> {
            $0.setImage(Asset.shoppingBag.image, tintColor: UIColor.Common.controlText)
            $0.contentMode = .scaleAspectFill
        }

        static let verticalStack = Style<UIStackView> {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fillEqually
            $0.contentMode = .scaleAspectFit
            $0.spacing = 6
        }
    }
}
