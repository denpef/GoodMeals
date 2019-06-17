import UIKit

final class GroceryCell: UITableViewCell {
    
    func configure(with item: GroceryItem) {
        if let ingredient = item.ingredient {
            textLabel?.text = "\(ingredient.name) : \(item.amount) \(item.marked)"
        } else {
            textLabel?.text = " ---- : \(item.amount) \(item.marked)"
        }
    }
}
