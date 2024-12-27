//
//  WorkOutCard.swift
//  Health Tracker
//
//  Created by Gordon Lee on 12/26/24.
//

import SwiftUI


struct WorkOutCard: View {
    @State var workout: Workout
    var body: some View {
        HStack {
            Image(systemName: workout.image)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .foregroundColor(workout.tintColor)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(20)
            
            VStack(spacing: 16) {
                HStack {
                    Text(workout.title)
                        .font(.title3)
                        .bold()
                    Spacer()
                    Text(workout.duration)
                }
                
                HStack {
                    Text(workout.date)
                    Spacer()
                    Text(workout.calories)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    WorkOutCard(workout: Workout(id: 0, title: "Running", image: "figure.run", tintColor: .cyan, duration: "51 mins", date: "Aug 3", calories: "570 kcal"))
}
