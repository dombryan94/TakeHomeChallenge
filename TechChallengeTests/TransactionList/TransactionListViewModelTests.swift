//
//  TransactionListViewModelTests.swift
//  TechChallengeTests
//
//  Created by Dom Bryan on 31/05/2022.
//

import XCTest
@testable import TechChallenge

class TransactionListViewModelTests: XCTestCase {
    
    var viewModel: TransactionListViewModel? = nil

    override func setUp() {
        super.setUp()
        viewModel = TransactionListViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func test_filterTransactions_food() {
        viewModel?.filterTransactions(by: "food")
        XCTAssertEqual(viewModel?.transactions.count, 5)
        XCTAssertEqual(viewModel?.transactions.first?.category, TransactionModel.Category.food)
    }
    
    func test_filterTransactions_health() {
        viewModel?.filterTransactions(by: "health")
        XCTAssertEqual(viewModel?.transactions.count, 1)
        XCTAssertEqual(viewModel?.transactions.first?.category, TransactionModel.Category.health)
    }
    
    func test_filterTransactions_entertainment() {
        viewModel?.filterTransactions(by: "entertainment")
        XCTAssertEqual(viewModel?.transactions.count, 1)
        XCTAssertEqual(viewModel?.transactions.first?.category, TransactionModel.Category.entertainment)
    }
    
    func test_filterTransactions_shopping() {
        viewModel?.filterTransactions(by: "shopping")
        XCTAssertEqual(viewModel?.transactions.count, 3)
        XCTAssertEqual(viewModel?.transactions.first?.category, TransactionModel.Category.shopping)
    }
    
    func test_filterTransactions_travel() {
        viewModel?.filterTransactions(by: "travel")
        XCTAssertEqual(viewModel?.transactions.count, 3)
        XCTAssertEqual(viewModel?.transactions.first?.category, TransactionModel.Category.travel)
    }
    
    func test_filterTransactions_all() {
        viewModel?.filterTransactions(by: "all")
        XCTAssertEqual(viewModel?.transactions.count, 13)
    }
    
    func test_filterTransactions_food_thenAll() {
        viewModel?.filterTransactions(by: "food")
        XCTAssertEqual(viewModel?.transactions.count, 5)
        XCTAssertEqual(viewModel?.transactions.first?.category, TransactionModel.Category.food)
        
        viewModel?.filterTransactions(by: "all")
        XCTAssertEqual(viewModel?.transactions.count, 13)
    }
}
