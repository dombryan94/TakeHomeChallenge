//
//  TransactionListViewModel.swift
//  TechChallenge
//
//  Created by Dom Bryan on 30/05/2022.
//

import SwiftUI

class TransactionListViewModel: ObservableObject {
    @Published var transactions: [TransactionModel] = ModelData.sampleTransactions
    @Published var totalSpend: Double = 0.0
    @Published var selectedFilter: String = "all"
    
    var filters: [String] {
        var filters = ["all"]
        TransactionModel.Category.allCases.forEach { category in
            filters.append(category.rawValue)
        }
        return filters
    }
    
    private func getCategory(for filter: String) -> TransactionModel.Category? {
        TransactionModel.Category(rawValue: filter)
    }
    
    func getColour(for filter: String) -> Color {
        if let category = getCategory(for: filter) {
            return category.color
        } else {
            return .black
        }
    }
    
    func filterTransactions(by filter: String) {
        if let category = getCategory(for: filter) {
            transactions = ModelData.sampleTransactions.filter { $0.category == category }
        } else {
            transactions = ModelData.sampleTransactions
        }
        selectedFilter = filter
        calculateTotalSpend()
    }
    
    func calculateTotalSpend() {
        var totalSpend = 0.0
        transactions.forEach { transaction in
            totalSpend += transaction.amount
        }
        
        self.totalSpend = totalSpend
    }
}
