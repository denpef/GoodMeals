import RxCocoa
import RxSwift

final class GroceryCellViewModel {
    // MARK: - Input

    /// Handle marked control action
    let markedAction = PublishRelay<Void>()

    /// Handle delete control action
    let deleteAction = PublishRelay<Void>()

    /// Observable initial item value
    let shoppingItem = PublishRelay<GroceryItem>()

    // MARK: - Output

    /// Item did marked/unmarked action binding target
    let itemMarked: Observable<GroceryItem>

    /// Item did delete action  binding target
    let itemDeleted: Observable<GroceryItem>

    /// Title of cell
    let title: Driver<String>

    /// Amount information
    let amount: Driver<String>

    /// Signal that item's marked value did change
    let marked: Driver<Bool>

    init() {
        title = shoppingItem
            .map { $0.ingredient?.name ?? "" }
            .asDriver(onErrorJustReturn: "")

        amount = shoppingItem
            .map { $0.amount.formattedMass }
            .asDriver(onErrorJustReturn: "")

        marked = shoppingItem
            .map { $0.marked }
            .asDriver(onErrorJustReturn: false)

        itemMarked = markedAction.withLatestFrom(shoppingItem)
            .flatMapLatest { Observable.from(optional: $0) }

        itemDeleted = deleteAction.withLatestFrom(shoppingItem)
            .flatMapLatest { Observable.from(optional: $0) }
    }
}
