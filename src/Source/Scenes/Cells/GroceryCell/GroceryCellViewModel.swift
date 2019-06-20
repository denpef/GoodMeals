import RxCocoa

final class GroceryCellViewModel {
    
    var markedChange = PublishRelay<Void>()
    var item: GroceryItem
    
    init(with item: GroceryItem) {
        self.item = item
    }
}
