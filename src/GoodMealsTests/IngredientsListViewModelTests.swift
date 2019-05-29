import XCTest
import RxSwift
import RxCocoa

@testable import GoodMeals

class IngredientsListViewModelTests: XCTestCase {

    var sut: IngredientsListViewModel?
    let service = IngredientsServiceTypeMock()
    let router = IngredientsListRouterTypeMock()

    override func setUp() {
        service.subscribeCollectionSubscriberCallsCount = 0
        service.allReturnValue = []
        sut = IngredientsListViewModel(ingredientsService: service)
        sut?.router = router
    }
    
    func testWhenInitialized() {
        XCTAssertNotNil(sut?.items)
        XCTAssertTrue(service.subscribeCollectionSubscriberCalled)
        XCTAssertEqual(service.subscribeCollectionSubscriberCallsCount, 1)
    }
}
