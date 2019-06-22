// Generated using Sourcery 0.16.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
import RxCocoa
import RxSwift
import UIKit

@testable import GoodMeals

class IngredientsListRouterTypeMock: IngredientsListRouterType {
    // MARK: - navigateToIngredient

    var navigateToIngredientIngredientIdCallsCount = 0
    var navigateToIngredientIngredientIdCalled: Bool {
        return navigateToIngredientIngredientIdCallsCount > 0
    }

    var navigateToIngredientIngredientIdReceivedIngredientId: String?
    var navigateToIngredientIngredientIdReceivedInvocations: [String?] = []
    var navigateToIngredientIngredientIdClosure: ((String?) -> Void)?
    func navigateToIngredient(ingredientId: String?) {
        navigateToIngredientIngredientIdCallsCount += 1
        navigateToIngredientIngredientIdReceivedIngredientId = ingredientId
        navigateToIngredientIngredientIdReceivedInvocations.append(ingredientId)
        navigateToIngredientIngredientIdClosure?(ingredientId)
    }
}

class IngredientsServiceTypeMock: IngredientsServiceType {
    // MARK: - getModel

    var getModelByCallsCount = 0
    var getModelByCalled: Bool {
        return getModelByCallsCount > 0
    }

    var getModelByReceivedId: String?
    var getModelByReceivedInvocations: [String] = []
    var getModelByReturnValue: Ingredient?
    var getModelByClosure: ((String) -> Ingredient?)?
    func getModel(by id: String) -> Ingredient? {
        getModelByCallsCount += 1
        getModelByReceivedId = id
        getModelByReceivedInvocations.append(id)
        return getModelByClosure.map { $0(id) } ?? getModelByReturnValue
    }

    // MARK: - add

    var addCallsCount = 0
    var addCalled: Bool {
        return addCallsCount > 0
    }

    var addReceivedIngredient: Ingredient?
    var addReceivedInvocations: [Ingredient] = []
    var addClosure: ((Ingredient) -> Void)?
    func add(_ ingredient: Ingredient) {
        addCallsCount += 1
        addReceivedIngredient = ingredient
        addReceivedInvocations.append(ingredient)
        addClosure?(ingredient)
    }

    // MARK: - remove

    var removeCallsCount = 0
    var removeCalled: Bool {
        return removeCallsCount > 0
    }

    var removeReceivedIngredient: Ingredient?
    var removeReceivedInvocations: [Ingredient] = []
    var removeClosure: ((Ingredient) -> Void)?
    func remove(_ ingredient: Ingredient) {
        removeCallsCount += 1
        removeReceivedIngredient = ingredient
        removeReceivedInvocations.append(ingredient)
        removeClosure?(ingredient)
    }

    // MARK: - update

    var updateCallsCount = 0
    var updateCalled: Bool {
        return updateCallsCount > 0
    }

    var updateReceivedIngredient: Ingredient?
    var updateReceivedInvocations: [Ingredient] = []
    var updateClosure: ((Ingredient) -> Void)?
    func update(_ ingredient: Ingredient) {
        updateCallsCount += 1
        updateReceivedIngredient = ingredient
        updateReceivedInvocations.append(ingredient)
        updateClosure?(ingredient)
    }

    // MARK: - all

    var allCallsCount = 0
    var allCalled: Bool {
        return allCallsCount > 0
    }

    var allReturnValue: [Ingredient]!
    var allClosure: (() -> [Ingredient])?
    func all() -> [Ingredient] {
        allCallsCount += 1
        return allClosure.map { $0() } ?? allReturnValue
    }

    // MARK: - subscribeCollection

    var subscribeCollectionSubscriberCallsCount = 0
    var subscribeCollectionSubscriberCalled: Bool {
        return subscribeCollectionSubscriberCallsCount > 0
    }

    var subscribeCollectionSubscriberReceivedSubscriber: PersistenceNotificationOutput?
    var subscribeCollectionSubscriberReceivedInvocations: [PersistenceNotificationOutput] = []
    var subscribeCollectionSubscriberClosure: ((PersistenceNotificationOutput) -> Void)?
    func subscribeCollection(subscriber: PersistenceNotificationOutput) {
        subscribeCollectionSubscriberCallsCount += 1
        subscribeCollectionSubscriberReceivedSubscriber = subscriber
        subscribeCollectionSubscriberReceivedInvocations.append(subscriber)
        subscribeCollectionSubscriberClosure?(subscriber)
    }

    // MARK: - clearAll

    var clearAllCallsCount = 0
    var clearAllCalled: Bool {
        return clearAllCallsCount > 0
    }

    var clearAllClosure: (() -> Void)?
    func clearAll() {
        clearAllCallsCount += 1
        clearAllClosure?()
    }
}

class MealPlanConfirmationRouterTypeMock: MealPlanConfirmationRouterType {
    // MARK: - dismiss

    var dismissCallsCount = 0
    var dismissCalled: Bool {
        return dismissCallsCount > 0
    }

    var dismissClosure: (() -> Void)?
    func dismiss() {
        dismissCallsCount += 1
        dismissClosure?()
    }
}

class MealPlanRouterTypeMock: MealPlanRouterType {
    // MARK: - navigateToConfirmation

    var navigateToConfirmationMealPlanCallsCount = 0
    var navigateToConfirmationMealPlanCalled: Bool {
        return navigateToConfirmationMealPlanCallsCount > 0
    }

    var navigateToConfirmationMealPlanReceivedMealPlan: MealPlan?
    var navigateToConfirmationMealPlanReceivedInvocations: [MealPlan] = []
    var navigateToConfirmationMealPlanClosure: ((MealPlan) -> Void)?
    func navigateToConfirmation(mealPlan: MealPlan) {
        navigateToConfirmationMealPlanCallsCount += 1
        navigateToConfirmationMealPlanReceivedMealPlan = mealPlan
        navigateToConfirmationMealPlanReceivedInvocations.append(mealPlan)
        navigateToConfirmationMealPlanClosure?(mealPlan)
    }
}

class MealPlanServiceTypeMock: MealPlanServiceType {
    // MARK: - getCurrentMealPlan

    var getCurrentMealPlanCallsCount = 0
    var getCurrentMealPlanCalled: Bool {
        return getCurrentMealPlanCallsCount > 0
    }

    var getCurrentMealPlanReturnValue: SelectedMealPlan?
    var getCurrentMealPlanClosure: (() -> SelectedMealPlan?)?
    func getCurrentMealPlan() -> SelectedMealPlan? {
        getCurrentMealPlanCallsCount += 1
        return getCurrentMealPlanClosure.map { $0() } ?? getCurrentMealPlanReturnValue
    }

    // MARK: - add

    var addCallsCount = 0
    var addCalled: Bool {
        return addCallsCount > 0
    }

    var addReceivedSelectedMealPlan: SelectedMealPlan?
    var addReceivedInvocations: [SelectedMealPlan] = []
    var addClosure: ((SelectedMealPlan) -> Void)?
    func add(_ selectedMealPlan: SelectedMealPlan) {
        addCallsCount += 1
        addReceivedSelectedMealPlan = selectedMealPlan
        addReceivedInvocations.append(selectedMealPlan)
        addClosure?(selectedMealPlan)
    }

    // MARK: - subscribeCollection

    var subscribeCollectionSubscriberCallsCount = 0
    var subscribeCollectionSubscriberCalled: Bool {
        return subscribeCollectionSubscriberCallsCount > 0
    }

    var subscribeCollectionSubscriberReceivedSubscriber: PersistenceNotificationOutput?
    var subscribeCollectionSubscriberReceivedInvocations: [PersistenceNotificationOutput] = []
    var subscribeCollectionSubscriberClosure: ((PersistenceNotificationOutput) -> Void)?
    func subscribeCollection(subscriber: PersistenceNotificationOutput) {
        subscribeCollectionSubscriberCallsCount += 1
        subscribeCollectionSubscriberReceivedSubscriber = subscriber
        subscribeCollectionSubscriberReceivedInvocations.append(subscriber)
        subscribeCollectionSubscriberClosure?(subscriber)
    }
}

class MealPlansListRouterTypeMock: MealPlansListRouterType {
    // MARK: - navigateToMealPlan

    var navigateToMealPlanMealPlanCallsCount = 0
    var navigateToMealPlanMealPlanCalled: Bool {
        return navigateToMealPlanMealPlanCallsCount > 0
    }

    var navigateToMealPlanMealPlanReceivedMealPlan: MealPlan?
    var navigateToMealPlanMealPlanReceivedInvocations: [MealPlan] = []
    var navigateToMealPlanMealPlanClosure: ((MealPlan) -> Void)?
    func navigateToMealPlan(mealPlan: MealPlan) {
        navigateToMealPlanMealPlanCallsCount += 1
        navigateToMealPlanMealPlanReceivedMealPlan = mealPlan
        navigateToMealPlanMealPlanReceivedInvocations.append(mealPlan)
        navigateToMealPlanMealPlanClosure?(mealPlan)
    }
}

class RecipesListRouterTypeMock: RecipesListRouterType {
    // MARK: - navigateToRecipe

    var navigateToRecipeRecipeIdCallsCount = 0
    var navigateToRecipeRecipeIdCalled: Bool {
        return navigateToRecipeRecipeIdCallsCount > 0
    }

    var navigateToRecipeRecipeIdReceivedRecipeId: String?
    var navigateToRecipeRecipeIdReceivedInvocations: [String] = []
    var navigateToRecipeRecipeIdClosure: ((String) -> Void)?
    func navigateToRecipe(recipeId: String) {
        navigateToRecipeRecipeIdCallsCount += 1
        navigateToRecipeRecipeIdReceivedRecipeId = recipeId
        navigateToRecipeRecipeIdReceivedInvocations.append(recipeId)
        navigateToRecipeRecipeIdClosure?(recipeId)
    }
}

class RecipesServiceTypeMock: RecipesServiceType {
    // MARK: - getModel

    var getModelByCallsCount = 0
    var getModelByCalled: Bool {
        return getModelByCallsCount > 0
    }

    var getModelByReceivedId: String?
    var getModelByReceivedInvocations: [String] = []
    var getModelByReturnValue: Recipe?
    var getModelByClosure: ((String) -> Recipe?)?
    func getModel(by id: String) -> Recipe? {
        getModelByCallsCount += 1
        getModelByReceivedId = id
        getModelByReceivedInvocations.append(id)
        return getModelByClosure.map { $0(id) } ?? getModelByReturnValue
    }

    // MARK: - add

    var addCallsCount = 0
    var addCalled: Bool {
        return addCallsCount > 0
    }

    var addReceivedRecipe: Recipe?
    var addReceivedInvocations: [Recipe] = []
    var addClosure: ((Recipe) -> Void)?
    func add(_ recipe: Recipe) {
        addCallsCount += 1
        addReceivedRecipe = recipe
        addReceivedInvocations.append(recipe)
        addClosure?(recipe)
    }

    // MARK: - remove

    var removeCallsCount = 0
    var removeCalled: Bool {
        return removeCallsCount > 0
    }

    var removeReceivedRecipe: Recipe?
    var removeReceivedInvocations: [Recipe] = []
    var removeClosure: ((Recipe) -> Void)?
    func remove(_ recipe: Recipe) {
        removeCallsCount += 1
        removeReceivedRecipe = recipe
        removeReceivedInvocations.append(recipe)
        removeClosure?(recipe)
    }

    // MARK: - update

    var updateCallsCount = 0
    var updateCalled: Bool {
        return updateCallsCount > 0
    }

    var updateReceivedRecipe: Recipe?
    var updateReceivedInvocations: [Recipe] = []
    var updateClosure: ((Recipe) -> Void)?
    func update(_ recipe: Recipe) {
        updateCallsCount += 1
        updateReceivedRecipe = recipe
        updateReceivedInvocations.append(recipe)
        updateClosure?(recipe)
    }

    // MARK: - all

    var allCallsCount = 0
    var allCalled: Bool {
        return allCallsCount > 0
    }

    var allReturnValue: [Recipe]!
    var allClosure: (() -> [Recipe])?
    func all() -> [Recipe] {
        allCallsCount += 1
        return allClosure.map { $0() } ?? allReturnValue
    }

    // MARK: - subscribeCollection

    var subscribeCollectionSubscriberCallsCount = 0
    var subscribeCollectionSubscriberCalled: Bool {
        return subscribeCollectionSubscriberCallsCount > 0
    }

    var subscribeCollectionSubscriberReceivedSubscriber: PersistenceNotificationOutput?
    var subscribeCollectionSubscriberReceivedInvocations: [PersistenceNotificationOutput] = []
    var subscribeCollectionSubscriberClosure: ((PersistenceNotificationOutput) -> Void)?
    func subscribeCollection(subscriber: PersistenceNotificationOutput) {
        subscribeCollectionSubscriberCallsCount += 1
        subscribeCollectionSubscriberReceivedSubscriber = subscriber
        subscribeCollectionSubscriberReceivedInvocations.append(subscriber)
        subscribeCollectionSubscriberClosure?(subscriber)
    }

    // MARK: - clearAll

    var clearAllCallsCount = 0
    var clearAllCalled: Bool {
        return clearAllCallsCount > 0
    }

    var clearAllClosure: (() -> Void)?
    func clearAll() {
        clearAllCallsCount += 1
        clearAllClosure?()
    }
}

class ShoppingListServiceTypeMock: ShoppingListServiceType {
    // MARK: - getModel

    var getModelByCallsCount = 0
    var getModelByCalled: Bool {
        return getModelByCallsCount > 0
    }

    var getModelByReceivedId: String?
    var getModelByReceivedInvocations: [String] = []
    var getModelByReturnValue: GroceryItem?
    var getModelByClosure: ((String) -> GroceryItem?)?
    func getModel(by id: String) -> GroceryItem? {
        getModelByCallsCount += 1
        getModelByReceivedId = id
        getModelByReceivedInvocations.append(id)
        return getModelByClosure.map { $0(id) } ?? getModelByReturnValue
    }

    // MARK: - add

    var addCallsCount = 0
    var addCalled: Bool {
        return addCallsCount > 0
    }

    var addReceivedGroceryItem: GroceryItem?
    var addReceivedInvocations: [GroceryItem] = []
    var addClosure: ((GroceryItem) -> Void)?
    func add(_ groceryItem: GroceryItem) {
        addCallsCount += 1
        addReceivedGroceryItem = groceryItem
        addReceivedInvocations.append(groceryItem)
        addClosure?(groceryItem)
    }

    // MARK: - delete

    var deleteCallsCount = 0
    var deleteCalled: Bool {
        return deleteCallsCount > 0
    }

    var deleteReceivedGroceryItem: GroceryItem?
    var deleteReceivedInvocations: [GroceryItem] = []
    var deleteClosure: ((GroceryItem) -> Void)?
    func delete(_ groceryItem: GroceryItem) {
        deleteCallsCount += 1
        deleteReceivedGroceryItem = groceryItem
        deleteReceivedInvocations.append(groceryItem)
        deleteClosure?(groceryItem)
    }

    // MARK: - update

    var updateCallsCount = 0
    var updateCalled: Bool {
        return updateCallsCount > 0
    }

    var updateReceivedGroceryItem: GroceryItem?
    var updateReceivedInvocations: [GroceryItem] = []
    var updateClosure: ((GroceryItem) -> Void)?
    func update(_ groceryItem: GroceryItem) {
        updateCallsCount += 1
        updateReceivedGroceryItem = groceryItem
        updateReceivedInvocations.append(groceryItem)
        updateClosure?(groceryItem)
    }

    // MARK: - all

    var allCallsCount = 0
    var allCalled: Bool {
        return allCallsCount > 0
    }

    var allReturnValue: [GroceryItem]!
    var allClosure: (() -> [GroceryItem])?
    func all() -> [GroceryItem] {
        allCallsCount += 1
        return allClosure.map { $0() } ?? allReturnValue
    }

    // MARK: - addByRecipe

    var addByRecipeCallsCount = 0
    var addByRecipeCalled: Bool {
        return addByRecipeCallsCount > 0
    }

    var addByRecipeReceivedRecipe: Recipe?
    var addByRecipeReceivedInvocations: [Recipe] = []
    var addByRecipeClosure: ((Recipe) -> Void)?
    func addByRecipe(_ recipe: Recipe) {
        addByRecipeCallsCount += 1
        addByRecipeReceivedRecipe = recipe
        addByRecipeReceivedInvocations.append(recipe)
        addByRecipeClosure?(recipe)
    }

    // MARK: - addByRecipes

    var addByRecipesCallsCount = 0
    var addByRecipesCalled: Bool {
        return addByRecipesCallsCount > 0
    }

    var addByRecipesReceivedRecipes: [Recipe]?
    var addByRecipesReceivedInvocations: [[Recipe]] = []
    var addByRecipesClosure: (([Recipe]) -> Void)?
    func addByRecipes(_ recipes: [Recipe]) {
        addByRecipesCallsCount += 1
        addByRecipesReceivedRecipes = recipes
        addByRecipesReceivedInvocations.append(recipes)
        addByRecipesClosure?(recipes)
    }

    // MARK: - subscribeCollection

    var subscribeCollectionSubscriberCallsCount = 0
    var subscribeCollectionSubscriberCalled: Bool {
        return subscribeCollectionSubscriberCallsCount > 0
    }

    var subscribeCollectionSubscriberReceivedSubscriber: PersistenceNotificationOutput?
    var subscribeCollectionSubscriberReceivedInvocations: [PersistenceNotificationOutput] = []
    var subscribeCollectionSubscriberClosure: ((PersistenceNotificationOutput) -> Void)?
    func subscribeCollection(subscriber: PersistenceNotificationOutput) {
        subscribeCollectionSubscriberCallsCount += 1
        subscribeCollectionSubscriberReceivedSubscriber = subscriber
        subscribeCollectionSubscriberReceivedInvocations.append(subscriber)
        subscribeCollectionSubscriberClosure?(subscriber)
    }

    // MARK: - marked

    var markedCallsCount = 0
    var markedCalled: Bool {
        return markedCallsCount > 0
    }

    var markedReceivedItem: GroceryItem?
    var markedReceivedInvocations: [GroceryItem] = []
    var markedClosure: ((GroceryItem) -> Void)?
    func marked(_ item: GroceryItem) {
        markedCallsCount += 1
        markedReceivedItem = item
        markedReceivedInvocations.append(item)
        markedClosure?(item)
    }

    // MARK: - deleteAllList

    var deleteAllListCallsCount = 0
    var deleteAllListCalled: Bool {
        return deleteAllListCallsCount > 0
    }

    var deleteAllListClosure: (() -> Void)?
    func deleteAllList() {
        deleteAllListCallsCount += 1
        deleteAllListClosure?()
    }
}

class TodayMenuRouterTypeMock: TodayMenuRouterType {
    // MARK: - navigateToMealPlansList

    var navigateToMealPlansListCallsCount = 0
    var navigateToMealPlansListCalled: Bool {
        return navigateToMealPlansListCallsCount > 0
    }

    var navigateToMealPlansListClosure: (() -> Void)?
    func navigateToMealPlansList() {
        navigateToMealPlansListCallsCount += 1
        navigateToMealPlansListClosure?()
    }
}
