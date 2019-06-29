import Foundation

// swiftlint:disable all
extension AppDelegate {
    private struct StubIngredientList {
        var ingredients = [Ingredient]()
        subscript(name: String) -> IngredientAmount {
            return IngredientAmount(ingredient: ingredients.first(where: { $0.name == name })!, amount: 300)
        }
    }

    func setupStubTestableVersion(_ serviceContainer: ServiceContainerType) {
        serviceContainer.persistenceService.clearAll()

        createMealPlans(serviceContainer.persistenceService,
                        createIngredients(ingredientService: serviceContainer.ingredientsService,
                                          shoppingListService: serviceContainer.shoppingListService))
    }

    private func createIngredients(ingredientService: IngredientsServiceType,
                                   shoppingListService: ShoppingListServiceType) -> StubIngredientList {
        var list = StubIngredientList()
        list.ingredients.append(Ingredient(name: "Muesli", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Raspberries", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Mixed salad greens", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Cherry tomatoes", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "White beans", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Red-wine vinegar", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Extra-virgin olive oil", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Salt", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Freshly ground pepper", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Dijon-style mustard", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Boneless chicken breast halves", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Balsamic vinegar", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Basil", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Avocado", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Ground pepper", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Garlic powder", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Whole-wheat bread", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Egg", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Sriracha", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Scallion", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Canola oil", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Diced onion", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Garlic", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Fresh ginger", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Curry powder", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Squash", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Tomato", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Water", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Coconut milk", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Lime", calorific: 0, category: nil))
        list.ingredients.append(Ingredient(name: "Cilantro", calorific: 0, category: nil))

        list.ingredients.forEach {
            ingredientService.add($0)
        }

        // ShoppingList

        shoppingListService.add(GroceryItem(ingredient: list["Squash"].ingredient!, amount: 451, marked: false))
        shoppingListService.add(GroceryItem(ingredient: list["Lime"].ingredient!, amount: 150, marked: false))
        shoppingListService.add(GroceryItem(ingredient: list["Egg"].ingredient!, amount: 999, marked: false))
        shoppingListService.add(GroceryItem(ingredient: list["Mixed salad greens"].ingredient!, amount: 1001, marked: false))

        return list
    }

    private func createMealPlans(_ service: PersistenceService, _ ingredientList: StubIngredientList) {
        var recipes = [Recipe]()

        // MARK: - Day: 1

        var muesli = Recipe(name: "Muesli with Raspberries",
                            image: "http://images.media-allrecipes.com/userphotos/960x960/5486559.jpg",
                            timeForPreparing: "30 min",
                            calorific: 287,
                            category: nil)
        muesli.ingredients.append(ingredientList["Muesli"])
        muesli.ingredients.append(ingredientList["Raspberries"])
        recipes.append(muesli)

        var whiteBeans = Recipe(name: "White Bean & Veggie Salad",
                                image: "http://images.media-allrecipes.com/userphotos/960x960/4548021.jpg",
                                timeForPreparing: "20 min",
                                calorific: 360,
                                category: nil)
        whiteBeans.ingredients.append(ingredientList["Mixed salad greens"])
        whiteBeans.ingredients.append(ingredientList["Cherry tomatoes"])
        whiteBeans.ingredients.append(ingredientList["White beans"])
        whiteBeans.ingredients.append(ingredientList["Red-wine vinegar"])
        whiteBeans.ingredients.append(ingredientList["Extra-virgin olive oil"])
        whiteBeans.ingredients.append(ingredientList["Salt"])
        whiteBeans.ingredients.append(ingredientList["Freshly ground pepper"])
        recipes.append(whiteBeans)

        var dijonChicken = Recipe(name: "Balsamic-Dijon Chicken",
                                  image: "http://images.media-allrecipes.com/userphotos/960x960/5180145.jpg",
                                  timeForPreparing: "50 min",
                                  calorific: 161,
                                  category: nil)
        dijonChicken.ingredients.append(ingredientList["Dijon-style mustard"])
        dijonChicken.ingredients.append(ingredientList["Boneless chicken breast halves"])
        dijonChicken.ingredients.append(ingredientList["Balsamic vinegar"])
        dijonChicken.ingredients.append(ingredientList["Basil"])
        recipes.append(dijonChicken)

        // MARK: - Day: 2

        var avocadoToast = Recipe(name: "Avocado-Egg Toast",
                                  image: "http://images.media-allrecipes.com/userphotos/960x960/5631902.jpg",
                                  timeForPreparing: "40 min",
                                  calorific: 271,
                                  category: nil)
        avocadoToast.ingredients.append(ingredientList["Avocado"])
        avocadoToast.ingredients.append(ingredientList["Ground pepper"])
        avocadoToast.ingredients.append(ingredientList["Garlic powder"])
        avocadoToast.ingredients.append(ingredientList["Whole-wheat bread"])
        avocadoToast.ingredients.append(ingredientList["Egg"])
        avocadoToast.ingredients.append(ingredientList["Sriracha"])
        avocadoToast.ingredients.append(ingredientList["Scallion"])
        recipes.append(avocadoToast)

        var redCurry = Recipe(name: "Squash & Red Lentil Curry",
                              image: "http://images.media-allrecipes.com/userphotos/960x960/3759121.jpg",
                              timeForPreparing: "25 min",
                              calorific: 326,
                              category: nil)
        redCurry.ingredients.append(ingredientList["Canola oil"])
        redCurry.ingredients.append(ingredientList["Diced onion"])
        redCurry.ingredients.append(ingredientList["Garlic"])
        redCurry.ingredients.append(ingredientList["Fresh ginger"])
        redCurry.ingredients.append(ingredientList["Curry powder"])
        redCurry.ingredients.append(ingredientList["Squash"])
        redCurry.ingredients.append(ingredientList["Tomato"])
        redCurry.ingredients.append(ingredientList["Salt"])
        redCurry.ingredients.append(ingredientList["Water"])
        redCurry.ingredients.append(ingredientList["Coconut milk"])
        redCurry.ingredients.append(ingredientList["Lime"])
        redCurry.ingredients.append(ingredientList["Cilantro"])
        recipes.append(redCurry)

        recipes.forEach {
            service.add($0, update: true)
        }

        // MARK: - 1st Plans

        var firstBreakfast = Meal(mealtime: .breakfast, recipe: muesli)
        var firstLunch = Meal(mealtime: .lunch, recipe: whiteBeans)
        var firstDinner = Meal(mealtime: .dinner, recipe: dijonChicken)

        service.add(firstBreakfast, update: true)
        service.add(firstLunch, update: true)
        service.add(firstDinner, update: true)

        var firstDayPlan = DailyPlan(dayNumber: 1, meals: [firstBreakfast, firstLunch, firstDinner])

        service.add(firstDayPlan, update: true)

        var secondBreakfast = Meal(mealtime: .breakfast, recipe: avocadoToast)
        var secondLunch = Meal(mealtime: .lunch, recipe: dijonChicken)
        var secondDinner = Meal(mealtime: .dinner, recipe: redCurry)

        service.add(secondBreakfast, update: true)
        service.add(secondLunch, update: true)
        service.add(secondDinner, update: true)

        var secondDayPlan = DailyPlan(dayNumber: 2, meals: [secondBreakfast, secondLunch, secondDinner])

        service.add(secondDayPlan, update: true)

        let plan = MealPlan(name: "Plan #1", dailyPlans: [firstDayPlan, secondDayPlan])
        service.add(plan, update: true)

        // MARK: - 2st Plans

        firstBreakfast = Meal(mealtime: .breakfast, recipe: avocadoToast)
        firstLunch = Meal(mealtime: .lunch, recipe: whiteBeans)
        firstDinner = Meal(mealtime: .dinner, recipe: redCurry)

        service.add(firstBreakfast, update: true)
        service.add(firstLunch, update: true)
        service.add(firstDinner, update: true)

        firstDayPlan = DailyPlan(dayNumber: 1, meals: [firstBreakfast, firstLunch, firstDinner])

        service.add(firstDayPlan, update: true)

        secondBreakfast = Meal(mealtime: .breakfast, recipe: muesli)
        secondLunch = Meal(mealtime: .lunch, recipe: dijonChicken)
        secondDinner = Meal(mealtime: .dinner, recipe: redCurry)

        service.add(secondBreakfast, update: true)
        service.add(secondLunch, update: true)
        service.add(secondDinner, update: true)

        secondDayPlan = DailyPlan(dayNumber: 2, meals: [secondBreakfast, secondLunch, secondDinner])

        service.add(secondDayPlan, update: true)

        let plan2 = MealPlan(name: "Plan #2", dailyPlans: [firstDayPlan, secondDayPlan])
        service.add(plan2, update: true)

        let selectedPlan = SelectedMealPlan(startDate: Date(), mealPlan: plan)
        let selectedPlan2 = SelectedMealPlan(startDate: Date(), mealPlan: plan2)
        service.add(selectedPlan, update: true)
        service.add(selectedPlan2, update: true)
    }
}
