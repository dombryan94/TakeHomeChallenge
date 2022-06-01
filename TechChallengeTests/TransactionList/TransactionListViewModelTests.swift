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
    
    // MARK: - Filter Tests
    func test_filterTransactions_food() {
        viewModel?.filterInput.send("food")
        var numberOfFilterTransactions = 0
        viewModel?.transactions.forEach {
            if $0.show == true { numberOfFilterTransactions += 1}
        }
        XCTAssertEqual(numberOfFilterTransactions, 5)
    }
    
    func test_filterTransactions_health() {
        viewModel?.filterInput.send("health")
        var numberOfFilterTransactions = 0
        viewModel?.transactions.forEach {
            if $0.show == true { numberOfFilterTransactions += 1}
        }
        XCTAssertEqual(numberOfFilterTransactions, 1)
    }
    
    func test_filterTransactions_entertainment() {
        viewModel?.filterInput.send("entertainment")
        var numberOfFilterTransactions = 0
        viewModel?.transactions.forEach {
            if $0.show == true { numberOfFilterTransactions += 1}
        }
        XCTAssertEqual(numberOfFilterTransactions, 1)
    }
    
    func test_filterTransactions_shopping() {
        viewModel?.filterInput.send("shopping")
        var numberOfFilterTransactions = 0
        viewModel?.transactions.forEach {
            if $0.show == true { numberOfFilterTransactions += 1}
        }
        XCTAssertEqual(numberOfFilterTransactions, 3)
    }
    
    func test_filterTransactions_travel() {
        viewModel?.filterInput.send("travel")
        var numberOfFilterTransactions = 0
        viewModel?.transactions.forEach {
            if $0.show == true { numberOfFilterTransactions += 1}
        }
        XCTAssertEqual(numberOfFilterTransactions, 3)
    }
    
    func test_filterTransactions_all() {
        viewModel?.filterInput.send("all")
        var numberOfFilterTransactions = 0
        viewModel?.transactions.forEach {
            if $0.show == true { numberOfFilterTransactions += 1}
        }
        XCTAssertEqual(numberOfFilterTransactions, 13)
    }
    
    func test_filterTransactions_food_thenAll() {
        var numberOfFilterTransactions = 0
        
        viewModel?.filterInput.send("food")
        viewModel?.transactions.forEach {
            if $0.show == true { numberOfFilterTransactions += 1}
        }
        XCTAssertEqual(numberOfFilterTransactions, 5)
        
        numberOfFilterTransactions = 0
        viewModel?.filterInput.send("all")
        viewModel?.transactions.forEach {
            if $0.show == true { numberOfFilterTransactions += 1}
        }
        XCTAssertEqual(numberOfFilterTransactions, 13)
    }
    
    // MARK: - Sum of Transactions Tests
    func test_sumOfTransaction_food() {
        viewModel?.filterTransactions(by: "food")
        XCTAssertEqual(viewModel?.totalSpend, 74.28)
    }
    
    func test_sumOfTransaction_food_thenAll_formatted() {
        viewModel?.filterTransactions(by: "food")
        XCTAssertEqual(viewModel?.totalSpend, 74.28)
        
        viewModel?.filterTransactions(by: "all")
        XCTAssertEqual(viewModel?.totalSpend.formatted(), "472.08")
    }
}
