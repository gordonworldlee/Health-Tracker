//
//  FitnessTabView.swift
//  Health Tracker
//
//  Created by Gordon Lee on 12/26/24.
//

import SwiftUI

struct FitnessTabView: View {
    @State var selectedTab = "Home"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
        }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    FitnessTabView()
}
