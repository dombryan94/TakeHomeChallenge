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
                ForEach(viewModel.transactions.indexed(), id: \.1.id) { index, transaction in
                    if transaction.show == true {
                        TransactionView(transaction: $viewModel.transactions[index])
                    }
                }
            }
            .animation(.easeIn)
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Transactions")
            
            SumView()
                .padding(4)
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
