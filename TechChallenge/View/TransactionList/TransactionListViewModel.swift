//
//  TransactionListViewModel.swift
//  TechChallenge
//
//  Created by Dom Bryan on 30/05/2022.
//

import Combine
import SwiftUI

class TransactionListViewModel: ObservableObject {
    @Published var transactions: [TransactionModel] = ModelData.sampleTransactions
    @Published var totalSpend: Double = 0.0
    @Published var selectedFilter: String = "all"
    
    let filterInput: PassthroughSubject<String, Never> = .init()
    
    var subscriber: Cancellable?
    
    @Published var categoryTotals: [TransactionModel.Category: String] = [:]
    var categoryPercentageTotals: [TransactionModel.Category: Double] = [:]
    
    init() {
        let filtered = filterInput
            .flatMap { category -> Published<[TransactionModel]>.Publisher in
                self.filterTransactions(by: category)
                return self.$transactions
            }
        
        subscriber = Publishers.Merge(filtered, $transactions.share())
            .map {
                $0
                    .filter(\.pinned)
                    .filter(\.show)
                    .reduce(0, { partialResult, model in
                        partialResult + model.amount
                    })
            }
            .sink(receiveValue: { total in
                self.totalSpend  = total
                self.calculateCategoryPercentageOfTotal()
            })
    }
    
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
            for (index, transaction) in transactions.enumerated() {
                if transaction.category ==  category {
                    transactions[index].show = true
                } else {
                    transactions[index].show = false
                }
            }
        } else {
            for (index, _) in transactions.enumerated() {
                transactions[index].show = true
            }
        }
        selectedFilter = filter
    }
    
    func pin(with transactionID: Int) {
        var transaction = self.transactions.first(where: { $0.id  == transactionID })
        let index = self.transactions.firstIndex(where: { $0.id ==  transactionID })
        transaction?.pinned.toggle()
        
        if let index = index,
           let transaction = transaction {
            transactions[index] = transaction
        }
    }
    
    private func calculateTotal(for category: TransactionModel.Category) -> Double {
        transactions
            .filter { $0.category == category }
            .filter { $0.pinned == true }
            .reduce(0, { partialResult, model in
                partialResult + model.amount
            })
    }
    
    func calculateCategoryTotal() {
        TransactionModel.Category.allCases.forEach { category in
            categoryTotals[category] = calculateTotal(for: category).formatted()
        }
    }
    
    func calculateCategoryPercentageOfTotal() {
        TransactionModel.Category.allCases.forEach { category in
            var percentage = calculateTotal(for: category) / totalSpend
            categoryPercentageTotals[category] = Double(round(100 * percentage) / 100)
        }
    }
    
    func getOffset(for categoryIndex: Int) -> Double {
        var offset: Double = 100.0
        
        for i in categoryIndex...categoryPercentageTotals.count {
            if let category = TransactionModel.Category[i],
               let ratio = categoryPercentageTotals[category] {
                offset = offset - ratio
            }
        }
        return offset
    }
}
