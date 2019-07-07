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

    enum ShoppingList {
        static let tableView = Style<UITableView> {
            $0.rowHeight = 60
            $0.allowsSelection = false
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
        }
    }

    enum GroceryCell {
        static let markButtonMarked = Style<UIButton> {
            $0.setImage(Asset.image.image, tintColor: .green)
            $0.tintColor = UIColor.Common.ghostWhite
        }

        static let deleteButtonMarked = Style<UIButton> {
            $0.setImage(Asset.cancel.image, tintColor: UIColor.Common.deleteItem)
            $0.tintColor = UIColor.Common.ghostWhite
        }

        static let titleLabelMarked = Style<UILabel> {
            $0.textAlignment = .left
            $0.textColor = UIColor.Common.markedText
            $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }

        static let amountLabelMarked = Style<UILabel> {
            $0.textAlignment = .right
            $0.textColor = UIColor.Common.markedText
            $0.font = UIFont.systemFont(ofSize: 12, weight: .light)
        }

        static let markButtonUnmarked = Style<UIButton> {
            $0.setImage(Asset.image.image, tintColor: .green)
            $0.tintColor = UIColor.Common.controlText
        }

        static let deleteButtonUnmarked = Style<UIButton> {
            $0.setImage(Asset.cancel.image, tintColor: UIColor.Common.deleteItem)
            $0.tintColor = UIColor.Common.deleteItem
        }

        static let titleLabelUnmarked = Style<UILabel> {
            $0.textAlignment = .left
            $0.textColor = UIColor.Common.controlBackground
            $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }

        static let amountLabelUnmarked = Style<UILabel> {
            $0.textAlignment = .right
            $0.textColor = UIColor.Common.controlBackground
            $0.font = UIFont.systemFont(ofSize: 12, weight: .light)
        }
    }
}
