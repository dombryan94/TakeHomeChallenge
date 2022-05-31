//
//  FilterView.swift
//  TechChallenge
//
//  Created by Dom Bryan on 30/05/2022.
//

import SwiftUI

struct FilterView: View {
    var viewModel: TransactionListViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.filters, id: \.self) { filter in
                    Button {
                        viewModel.filterTransactions(by: filter)
                    } label: {
                        Text(String(filter))
                            .font(.system(.title2))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding(8)
                            .background(viewModel.getColour(for: filter))
                            .clipShape(Capsule())
                    }
                }
            }
            .padding()
        }
        .background(Color.accentColor.opacity(0.8))
        .scaledToFit()
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(viewModel: TransactionListViewModel())
    }
}
