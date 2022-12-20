//
//  SalesHistoryViewModelTests.swift
//  Sales TrackerTests
//
//  Created by Mikio Nakata on 2022/12/16.
//

import XCTest
@testable import Sales_Tracker

final class SalesHistoryViewModelTests: XCTestCase {
    var mockFirestoreManager: MockFirestoreManager!
    var sut: SalesHistoryViewModel!

    override func setUp() {
        super.setUp()
        mockFirestoreManager = MockFirestoreManager()
        sut = SalesHistoryViewModel(engine: mockFirestoreManager)
    }

    override func tearDown() {
        mockFirestoreManager = nil
        super.tearDown()
    }

    // Get sold product item
    func test_get_sales_history() {
        // When start fetch
        sut.getSalesHistory()
        // Assert
        XCTAssert(mockFirestoreManager.isGetSoldProductItemsCalled)
    }

    // Get sold product item (failed)
    func test_get_sales_history_fail() {
        // Given
        let error = FirestoreError.getError

        // When
        sut.getSalesHistory()

        mockFirestoreManager.getSoldProductItemsFail(with: error)
        XCTAssertEqual(sut.alert?.msg, error.message)
    }

    // Test title text is correct.
    func test_title_item_count() {
        // Given some sold product items
        goToGetSalesHistoryFinished()
        let count = StubGenerator().stubSoldProductItemsQuantity()
        XCTAssertEqual(sut.titleItemCount, count)
    }

    // Create cell view model
    func test_get_cell_view_model() {
        // Given some sold product item stubs
        goToGetSalesHistoryFinished()
        let indexPath = IndexPath(row: 0, section: 0)
        let testItem = mockFirestoreManager.soldProductItemsComplete[indexPath.row]

        // when
        let cvm = sut.getCellViewModel(at: indexPath)

        // assert
        XCTAssertEqual(cvm.soldProductItem, testItem)
    }
}

// MARK: State control
extension SalesHistoryViewModelTests {
    private func goToGetSalesHistoryFinished() {
        mockFirestoreManager.soldProductItemsComplete = StubGenerator().stubSoldProductItems()
        sut.getSalesHistory()
        mockFirestoreManager.getSoldProductItemsSuccess()
    }
}

class StubGenerator {
    func stubSoldProductItems() -> [SoldProductItem] {
        return [SoldProductItem.mock1(), SoldProductItem.mock2()]
    }
    func stubSoldProductItemsQuantity() -> Int {
        return stubSoldProductItems().reduce(0) { partialResult, item in
            return partialResult + item.quantity
        }
    }
}
