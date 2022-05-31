//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionListView: View {
    @EnvironmentObject var viewModel: TransactionListViewModel
    
    var body: some View {
        VStack {
            FilterView(viewModel: viewModel)
            
            List {
                ForEach(viewModel.transactions) { transaction in
                    TransactionView(transaction: transaction)
                }
            }
            .animation(.easeIn)
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Transactions")
            
            SumView()
                .padding(4)
        }
        .onAppear {
            viewModel.calculateTotalSpend()
        }
    }
}

#if DEBUG
struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
    }
}
#endif
