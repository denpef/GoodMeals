import Foundation
import RxCocoa
import RxSwift

class IngredientViewModel {
    // MARK: - Input

    let name: BehaviorRelay<String>
    let tap = PublishRelay<Void>()

    var ingredient: Ingredient
    var ingredientId: String?

    // MARK: - Output

    let isSaved = BehaviorRelay<Bool>(value: true)

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private let ingredientsService: IngredientsServiceType

    // MARK: - Init

    init(ingredientsService: IngredientsServiceType, ingredientId: String?) {
        self.ingredientsService = ingredientsService
        self.ingredientId = ingredientId

        if let ingredientId = ingredientId,
            let ingredient = ingredientsService.getModel(by: ingredientId) {
            self.ingredient = ingredient
        } else {
            ingredient = Ingredient(name: "")
            isSaved.accept(false)
        }

        name = BehaviorRelay(value: ingredient.name)
        name.subscribe(onNext: {
            self.ingredient.name = $0
            self.isSaved.accept(false)
        })
            .disposed(by: disposeBag)

        tap.subscribe(onNext: {
            if let _ = self.ingredientId {
                self.ingredientsService.update(self.ingredient)
            } else {
                self.ingredientsService.add(self.ingredient)
                self.ingredientId = self.ingredient.id
            }
            self.isSaved.accept(true)
            // router navigate to pop
        }).disposed(by: disposeBag)
    }
}
