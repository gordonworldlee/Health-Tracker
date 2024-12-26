//
//  ActivityCard.swift
//  Health Tracker
//
//  Created by Gordon Lee on 12/26/24.
//

import SwiftUI

struct ActivityCard: View {
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Today Steps")
                        
                        Text("Goal 10,000")
                            .font(.caption)
                    }
                    Spacer()
                    Image(systemName: "figure.walk")
                        .foregroundColor(.green)
                }
                
                Text("6,123")
                    .font(.title)
                    .bold()
                    .padding()
            }
            .padding()
        }
    }
}

#Preview {
    ActivityCard()
}
