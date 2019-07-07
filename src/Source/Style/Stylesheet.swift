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

    enum RecipeList {
        static let table = Style<UITableView> {
            $0.rowHeight = 320
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
            $0.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.reuseIdentifier)
        }
    }

    enum MealPlansList {
        static let table = Style<UITableView> {
            $0.rowHeight = 186
            $0.backgroundColor = .white
            $0.separatorStyle = .none
        }
    }

    enum MealPlanConfirmation {
        static let infoLabel = Style<UILabel> {
            $0.textColor = UIColor.Common.controlBackground
            $0.text = "Would you like to choose this meal plan starting today?"
            $0.textAlignment = .center
            $0.numberOfLines = 3
        }

        static let planImage = Style<UIImageView> {
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 12
            $0.clipsToBounds = true
        }

        static let acceptButton = Style<UIButton> {
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.textColor = UIColor.Common.controlText
            $0.backgroundColor = UIColor.Common.controlBackground
            $0.setTitle("Yes", for: .normal)
            $0.layer.shadowOpacity = 0.15
            $0.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            $0.layer.shadowRadius = 8
            $0.layer.cornerRadius = 12
            $0.layer.opacity = 0.95
        }
    }

    enum MealPlan {
        static let table = Style<UITableView> {
            $0.rowHeight = 264
            $0.backgroundColor = .white
            $0.separatorStyle = .none
        }

        static let selectButton = Style<UIButton> {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.textColor = UIColor.Common.controlText
            $0.backgroundColor = UIColor.Common.controlBackground
            $0.setTitle("Select plan", for: .normal)
            $0.layer.shadowOpacity = 0.15
            $0.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            $0.layer.shadowRadius = 8
            $0.layer.cornerRadius = 12
            $0.layer.opacity = 0.95
        }
    }

    enum TodayMenu {
        static let table = Style<UITableView> {
            $0.rowHeight = 304
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
            $0.allowsSelection = false
        }
    }

    enum Recipe {
        static let collection = Style<UICollectionView> {
            $0.backgroundColor = .white
            $0.alwaysBounceVertical = true
            $0.alwaysBounceHorizontal = false
            $0.showsHorizontalScrollIndicator = false
        }
    }
}
