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
            if transaction.pinned == true {
                totalSpend += transaction.amount
            }
        }
        
        self.totalSpend = totalSpend
    }
    
    func pin(with transactionID: Int) {
        var transaction = self.transactions.first(where: { $0.id  == transactionID })
        let index = self.transactions.firstIndex(where: { $0.id ==  transactionID })
        transaction?.pinned.toggle()
        
        if let index = index,
           let transaction = transaction {
            transactions[index] = transaction
        }
        
        calculateTotalSpend()
    }
}
