//
//  FitnessTabView.swift
//  Health Tracker
//
//  Created by Gordon Lee on 12/26/24.
//

import SwiftUI

struct FitnessTabView: View {
    @State var selectedTab = "Home"
    @StateObject var viewModel = MainViewViewModel()
    init () {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.selected.iconColor = .purple
        appearance.stackedLayoutAppearance.selected.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.purple]
        
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag("Home")
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                HistoricDataView()
                    .tag("Historic")
                    .tabItem {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                        
                        Text("Charts")
                    }
            }
        } else {
            LoginView()
        }
        
    }
}

#Preview {
    FitnessTabView()
}
