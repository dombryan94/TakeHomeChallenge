//
//  SumView.swift
//  TechChallenge
//
//  Created by Dom Bryan on 31/05/2022.
//

import SwiftUI

struct SumView: View {
    @EnvironmentObject var viewModel: TransactionListViewModel
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text(viewModel.selectedFilter)
                .font(.headline)
                .foregroundColor(viewModel.getColour(for: viewModel.selectedFilter))
            
            HStack {
                Text("Total spent:")
                    .fontWeight(.regular)
                    .secondary()
                Spacer()
                
                Text("$\(viewModel.totalSpend.formatted())")
                    .fontWeight(.bold)
                    .secondary()
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(Color.accentColor, lineWidth: 2.0)
            )
    }
}

struct SumView_Previews: PreviewProvider {
    static var previews: some View {
        SumView()
            .frame(height: 100)
    }
}
