//
//  InsightsView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 29/7/21.
//

import SwiftUI

struct InsightsView: View {
    @EnvironmentObject var viewModel: TransactionListViewModel
    
    var body: some View {
        List {
            RingView(transactions: viewModel.transactions)
                .scaledToFit()
            
            ForEach(TransactionModel.Category.allCases) { category in
                HStack {
                    Text(category.rawValue)
                        .font(.headline)
                        .foregroundColor(category.color)
                    Spacer()
                    Text("$\(viewModel.categoryTotals[category] ?? "0.0")")
                        .bold()
                        .secondary()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Insights")
        .onAppear {
            viewModel.calculateCategoryTotal()
        }
    }
}

#if DEBUG
struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView()
            .environmentObject(TransactionListViewModel())
            .previewLayout(.sizeThatFits)
    }
}
#endif
