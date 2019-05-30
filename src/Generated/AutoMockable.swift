// Generated using Sourcery 0.16.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
import UIKit
import RxSwift
import RxCocoa

@testable import GoodMeals

class IngredientsListRouterTypeMock: IngredientsListRouterType {
    //MARK: - navigateToIngredient

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
    //MARK: - getModel

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
        return getModelByClosure.map({ $0(id) }) ?? getModelByReturnValue
    }
    //MARK: - add

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
    //MARK: - remove

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
    //MARK: - update

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
    //MARK: - all

    var allCallsCount = 0
    var allCalled: Bool {
        return allCallsCount > 0
    }
    var allReturnValue: [Ingredient]!
    var allClosure: (() -> [Ingredient])?
    func all() -> [Ingredient] {
        allCallsCount += 1
        return allClosure.map({ $0() }) ?? allReturnValue
    }
    //MARK: - subscribeCollection

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
    //MARK: - clearAll

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
class RecipesListRouterTypeMock: RecipesListRouterType {
    //MARK: - navigateToRecipe

    var navigateToRecipeRecipeIdCallsCount = 0
    var navigateToRecipeRecipeIdCalled: Bool {
        return navigateToRecipeRecipeIdCallsCount > 0
    }
    var navigateToRecipeRecipeIdReceivedRecipeId: String?
    var navigateToRecipeRecipeIdReceivedInvocations: [String?] = []
    var navigateToRecipeRecipeIdClosure: ((String?) -> Void)?
    func navigateToRecipe(recipeId: String?) {
        navigateToRecipeRecipeIdCallsCount += 1
        navigateToRecipeRecipeIdReceivedRecipeId = recipeId
        navigateToRecipeRecipeIdReceivedInvocations.append(recipeId)
        navigateToRecipeRecipeIdClosure?(recipeId)
    }
}
class RecipesServiceTypeMock: RecipesServiceType {
    //MARK: - getModel

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
        return getModelByClosure.map({ $0(id) }) ?? getModelByReturnValue
    }
    //MARK: - add

    var addCallsCount = 0
    var addCalled: Bool {
        return addCallsCount > 0
    }
    var addReceivedRecipe: Recipe?
    var addReceivedInvocations: [Recipe] = []
    var addClosure: ((Recipe) -> Void)?
    func add(_ Recipe: Recipe) {
        addCallsCount += 1
        addReceivedRecipe = Recipe
        addReceivedInvocations.append(Recipe)
        addClosure?(Recipe)
    }
    //MARK: - remove

    var removeCallsCount = 0
    var removeCalled: Bool {
        return removeCallsCount > 0
    }
    var removeReceivedRecipe: Recipe?
    var removeReceivedInvocations: [Recipe] = []
    var removeClosure: ((Recipe) -> Void)?
    func remove(_ Recipe: Recipe) {
        removeCallsCount += 1
        removeReceivedRecipe = Recipe
        removeReceivedInvocations.append(Recipe)
        removeClosure?(Recipe)
    }
    //MARK: - update

    var updateCallsCount = 0
    var updateCalled: Bool {
        return updateCallsCount > 0
    }
    var updateReceivedRecipe: Recipe?
    var updateReceivedInvocations: [Recipe] = []
    var updateClosure: ((Recipe) -> Void)?
    func update(_ Recipe: Recipe) {
        updateCallsCount += 1
        updateReceivedRecipe = Recipe
        updateReceivedInvocations.append(Recipe)
        updateClosure?(Recipe)
    }
    //MARK: - all

    var allCallsCount = 0
    var allCalled: Bool {
        return allCallsCount > 0
    }
    var allReturnValue: [Recipe]!
    var allClosure: (() -> [Recipe])?
    func all() -> [Recipe] {
        allCallsCount += 1
        return allClosure.map({ $0() }) ?? allReturnValue
    }
    //MARK: - subscribeCollection

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
    //MARK: - clearAll

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
