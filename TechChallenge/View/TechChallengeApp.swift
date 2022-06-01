//
//  TechChallengeApp.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

@main
struct TechChallengeApp: App {

    var body: some Scene {
        let viewModel = TransactionListViewModel()
        
        WindowGroup {
            TabView {
                NavigationView {
                    TransactionListView()
                        .environmentObject(viewModel)
                }
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
                
                NavigationView {
                    InsightsView()
                        .environmentObject(viewModel)
                }
                .tabItem {
                    Label("Insights", systemImage: "chart.pie.fill")
                }
            }
        }
    }
}
