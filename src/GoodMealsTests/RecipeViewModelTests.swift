import RxBlocking
import RxCocoa
import RxSwift
import RxTest
import XCTest

@testable import GoodMeals

// swiftlint:disable implicitly_unwrapped_optional
class RecipeViewModelTests: XCTestCase {
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var recipeService: RecipesServiceTypeMock!
    var shoppingListService: ShoppingListServiceTypeMock!

    let expectedRecipe = Recipe(name: "Test recipe", image: "image", timeForPreparing: "timeForPreparing")

    var sut: RecipeViewModel!

    // MARK: - Override test methods

    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()

        recipeService = RecipesServiceTypeMock()
        recipeService.getModelByReturnValue = expectedRecipe

        shoppingListService = ShoppingListServiceTypeMock()

        sut = RecipeViewModel(recipesService: recipeService,
                              shoppingListService: shoppingListService,
                              recipeId: "")
    }

    override func tearDown() {
        sut = nil
        shoppingListService = nil
        recipeService = nil
        scheduler = nil
        disposeBag = nil
        super.tearDown()
    }

    func testInitialRecipeValues() {
        XCTAssertEqual(try sut.image.toBlocking().first(), expectedRecipe.image)
        XCTAssertEqual(try sut.title.toBlocking().first(), expectedRecipe.name)
        XCTAssertEqual(try sut.serving.toBlocking().first(), 2)
    }
    
    
    func testImage() {
        let persistenceService = RealmPersistenceService(inMemoryIdentifier: "testFetchRecipe")
        
        persistenceService.add(expectedRecipe)
        
//        let expect = expectation(description: "Image Configure")
        
        sut = RecipeViewModel(recipesService: recipeService,
                              shoppingListService: shoppingListService,
                              recipeId: expectedRecipe.id)
        
        
        
//        XCTAssert(sut.image == "no", "Wrong image")
//        expect.fulfill()
        
//        waitForExpectations(timeout: 5) { error in
//            XCTAssertNil(error)
//        }
        
//        recipeService.getModelByReturnValue =
    }
}

//    func testAddToShoppingList() {
//        let item = RecipeItem.servingItem(calorific: 600, timeForPreparing: "20 min")
//        let expectedSections = RecipeSection(items: [item])
//
////        service.allReturnValue = expectedItems
//
//        // create scheduler
//        let items = scheduler.createObserver([RecipeSection].self)
//
//        // bind the result
//        sut.items
//            .drive(items)
//            .disposed(by: disposeBag)
//
//        // mock a reload
//        scheduler.createColdObservable([.next(15, expectedSections),
//                                        .next(20, expectedSections),
//                                        .next(30, expectedSections),
//                                        .next(40, expectedSections),
//                                        .next(50, expectedSections)])
//            .bind(to: sut.items)
//            .disposed(by: disposeBag)
//
//        scheduler.start()
//
//        XCTAssertEqual(items.events, [.next(15, expectedSections),
//                                      .next(20, expectedSections),
//                                      .next(30, expectedSections),
//                                      .next(40, expectedSections),
//                                      .next(50, expectedSections)])
//    }

//    let image: Observable<String>
//    let title: Driver<String>
//    let items: Driver<[RecipeSection]>
//
//    let serving = BehaviorRelay<Int>(value: 2)
//    let addToShoppingList = PublishRelay<Void>()

//    func testImage() {
//        let action = scheduler.createObserver(String.self)
//
//        sut.image
//            .bind(to: action)
//            .disposed(by: disposeBag)
//
//        scheduler.createColdObservable([.next(10, "image one"),
//                                        .next(20, "image two"),
//                                        .next(30, "image three")])
//            .bind(to: sut.image)
//            .disposed(by: disposeBag)
//
//        scheduler.start()
//
//        XCTAssertEqual(action.events, [.next(10, "image one"),
//                                       .next(20, "image two"),
//                                       .next(30, "image three")])
//    }

//    func testTitle() {
//        let action = scheduler.createObserver(String.self)
//
//        sut.title
//            .drive(action)
//            .disposed(by: disposeBag)
//
//        scheduler.createHotObservable([.next(10, "title one"),
//                                       .next(20, "title two"),
//                                       .next(30, "title three")])
//            .drive(to: sut.title)
//            .disposed(by: disposeBag)
//
//        scheduler.start()
//
//        XCTAssertEqual(action.events, [.next(10, "title one"),
//                                       .next(20, "title two"),
//                                       .next(30, "title three")])
//    }

//    func testItems() {}
//
//    func testServing() {}
// }
