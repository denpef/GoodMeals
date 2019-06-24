import Foundation

protocol CellViewModelFactory {
    func makeGroceryCellViewModel(item: GroceryItem) -> GroceryCellViewModel
}
