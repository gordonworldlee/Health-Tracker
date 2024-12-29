//
//  ActivityCard.swift
//  Health Tracker
//
//  Created by Gordon Lee on 12/26/24.
//

import SwiftUI


struct ActivityCard: View {
    @State var activity: Activity
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(activity.title)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        
                        Text(activity.subtitle)
                            .font(.caption)
                    }
                    Spacer()
                    Image(systemName: activity.image)
                        .foregroundColor(activity.tintColor)
                }
                
                Text(activity.amount)
                    .font(.title)
                    .bold()
                    .padding()
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .padding()
        }
    }
}

#Preview {
    ActivityCard(activity: Activity(title: "Today steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "9812 steps"))
}