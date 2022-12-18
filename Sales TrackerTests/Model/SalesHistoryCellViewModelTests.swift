//
//  SalesHistoryCellViewModelTests.swift
//  Sales TrackerTests
//
//  Created by Mikio Nakata on 2022/12/16.
//

import XCTest
@testable import Sales_Tracker

final class SalesHistoryCellViewModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_sales_history_cell_view_model() {
        let item = SoldProductItem.mock1()
        let salesHistoryViewModel = SalesHistoryCellViewModel(soldProductItem: item)
        XCTAssertEqual(item, salesHistoryViewModel.soldProductItem)
    }
}
