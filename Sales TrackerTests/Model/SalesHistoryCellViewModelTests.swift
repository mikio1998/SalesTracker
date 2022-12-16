//
//  SalesHistoryCellViewModelTests.swift
//  Sales TrackerTests
//
//  Created by Mikio Nakata on 2022/12/16.
//

import XCTest
@testable import Sales_Tracker

final class SalesHistoryCellViewModelTests: XCTestCase {
    func testSalesHistoryCellViewModel() {
        let item = SoldProductItem.with()
        let salesHistoryViewModel = SalesHistoryCellViewModel(soldProductItem: item)
        XCTAssertEqual(item, salesHistoryViewModel.soldProductItem)
    }

}
