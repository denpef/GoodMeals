import UIKit

enum Stylesheet {
    enum Bars {
        static let common = Style<UIView> {
            $0.backgroundColor = UIColor.Common.mintCream
            $0.tintColor = UIColor.Common.englishGreen
        }
    }

    enum ServingCell {
        static let info = Style<UILabel> {
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }

        static let plus = Style<UIButton> {
            $0.setImage(Asset.plus.image, tintColor: UIColor.Common.englishGreen)
            $0.contentMode = .scaleAspectFill
        }

        static let minus = Style<UIButton> {
            $0.setImage(Asset.minus.image, tintColor: UIColor.Common.englishGreen)
            $0.contentMode = .scaleAspectFill
        }

        static let addToShoppingList = Style<UIButton> {
            $0.setImage(Asset.shoppingBag.image, tintColor: UIColor.Common.pastelRed)
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

    enum MealPlanCell {
        static let titleImage = Style<UIImageView> {
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 15
            $0.clipsToBounds = true
        }
    }

    enum IngredientCollectionViewCell {
        static let name = Style<UILabel> {
            $0.textAlignment = .left
            $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        }

        static let amount = Style<UILabel> {
            $0.textAlignment = .right
            $0.font = UIFont.systemFont(ofSize: 16, weight: .light)
        }
    }

    enum RecipeCell {
        static let breakfast = Style<UILabel> {
//            $0.textColor = UIColor.Common.englishGreen
            $0.textAlignment = .center
            $0.text = "Breakfast"
            $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }

        static let title = Style<UILabel> {
            $0.textAlignment = .left
//            $0.textColor = UIColor.Common.englishGreen
            $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        }

        static let calorifical = Style<UILabel> {
            $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            $0.textColor = UIColor.Common.mintCream
            $0.backgroundColor = UIColor.Common.englishGreenLight
            $0.textAlignment = .center
            $0.layer.cornerRadius = 13
            $0.clipsToBounds = true
        }

        static let timeForPreparing = Style<UILabel> {
            $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            $0.textColor = UIColor.Common.mintCream
            $0.backgroundColor = UIColor.Common.englishGreenLight
            $0.textAlignment = .center
            $0.layer.cornerRadius = 13
            $0.clipsToBounds = true
        }

        static let titleImage = Style<UIImageView> {
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 12
            $0.clipsToBounds = true
        }
    }

    enum TodayMenuCell {
        static let title = Style<UILabel> {
            $0.textColor = UIColor.Common.mintCream
            $0.backgroundColor = UIColor.Common.pictonBlue
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 16
        }

        static let collection = Style<UICollectionView> {
            $0.backgroundColor = UIColor.Common.mintCream
            $0.alwaysBounceVertical = false
            $0.alwaysBounceHorizontal = true
            $0.showsHorizontalScrollIndicator = false
            $0.isPagingEnabled = true
        }

        static let pageControl = Style<UIPageControl> {
            $0.currentPage = 0
            $0.currentPageIndicatorTintColor = UIColor.Common.englishGreen
            $0.pageIndicatorTintColor = UIColor.Common.englishGreenLight
        }
    }

    enum ShoppingList {
        static let tableView = Style<UITableView> {
            $0.rowHeight = 60
            $0.allowsSelection = false
            $0.backgroundColor = UIColor.Common.mintCream
            $0.separatorStyle = .none
        }
    }

    enum GroceryCell {
        static let markButtonMarked = Style<UIButton> {
            $0.setImage(Asset.image.image, tintColor: UIColor.Common.pictonBlueLight)
        }

        static let deleteButtonMarked = Style<UIButton> {
            $0.setImage(Asset.cancel.image, tintColor: UIColor.Common.pastelRedLight)
        }

        static let titleLabelMarked = Style<UILabel> {
            $0.textAlignment = .left
            $0.textColor = UIColor.Common.englishGreenLight
            $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }

        static let amountLabelMarked = Style<UILabel> {
            $0.textAlignment = .right
            $0.textColor = UIColor.Common.englishGreenLight
            $0.font = UIFont.systemFont(ofSize: 12, weight: .light)
        }

        static let markButtonUnmarked = Style<UIButton> {
            $0.setImage(Asset.image.image, tintColor: UIColor.Common.pictonBlue)
        }

        static let deleteButtonUnmarked = Style<UIButton> {
            $0.setImage(Asset.cancel.image, tintColor: UIColor.Common.pastelRed)
        }

        static let titleLabelUnmarked = Style<UILabel> {
            $0.textAlignment = .left
            $0.textColor = UIColor.Common.englishGreen
            $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }

        static let amountLabelUnmarked = Style<UILabel> {
            $0.textAlignment = .right
            $0.textColor = UIColor.Common.englishGreen
            $0.font = UIFont.systemFont(ofSize: 12, weight: .light)
        }
    }

    enum RecipeList {
        static let table = Style<UITableView> {
            $0.rowHeight = 340
            $0.separatorStyle = .none
            $0.backgroundColor = UIColor.Common.mintCream
        }
    }

    enum MealPlansList {
        static let table = Style<UITableView> {
            $0.rowHeight = 186
            $0.separatorStyle = .none
            $0.backgroundColor = UIColor.Common.mintCream
        }
    }

    enum MealPlanConfirmation {
        static let infoLabel = Style<UILabel> {
            $0.textColor = UIColor.Common.englishGreen
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
            $0.titleLabel?.textColor = UIColor.Common.mintCream
            $0.backgroundColor = UIColor.Common.englishGreen
            $0.setTitle("Yes", for: .normal)
            $0.layer.shadowOpacity = 0.15
            $0.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            $0.layer.shadowRadius = 8
            $0.layer.cornerRadius = 12
            $0.layer.opacity = 0.95
        }
    }

    enum MealPlan {
        static let headerLabel = Style<UILabel> {
            $0.clipsToBounds = true
            $0.backgroundColor = UIColor.Common.pictonBlue
            $0.textAlignment = .center
            $0.textColor = UIColor.Common.mintCream
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        }

        static let table = Style<UITableView> {
            $0.rowHeight = 340
            $0.backgroundColor = UIColor.Common.mintCream
            $0.separatorStyle = .none
        }

        static let selectButton = Style<UIButton> {
            $0.setTitleColor(UIColor.Common.mintCream, for: .normal)
            $0.titleLabel?.textAlignment = .center
            $0.backgroundColor = UIColor.Common.englishGreen
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
            $0.rowHeight = 384
            $0.backgroundColor = UIColor.Common.mintCream
            $0.separatorStyle = .none
            $0.allowsSelection = false
        }
    }

    enum Recipe {
        static let collection = Style<UICollectionView> {
            $0.backgroundColor = UIColor.Common.mintCream
            $0.alwaysBounceVertical = true
            $0.alwaysBounceHorizontal = false
            $0.showsHorizontalScrollIndicator = false
        }
    }
}
