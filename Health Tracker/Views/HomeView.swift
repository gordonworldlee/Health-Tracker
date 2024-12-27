//
//  HomeView.swift
//  Health Tracker
//
//  Created by Gordon Lee on 12/26/24.
//

import SwiftUI

struct HomeView: View {
    @State var calories: Int = 123
    @State var active: Int = 8
    @State var standing: Int = 50
    
    
    var mockActivities = [
        Activity(id: 0, title: "Today steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "9812"),
        Activity(id: 1, title: "Today steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .red, amount: "812"),
        Activity(id: 2, title: "Today steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .blue, amount: "9812"),
        Activity(id: 3, title: "Today steps", subtitle: "Goal 15,000", image: "figure.run", tintColor: .purple, amount: "104.87")
    ]
    
    var mockWorkouts = [
        Workout(id: 0, title: "Running", image: "figure.run", tintColor: .cyan, duration: "51 mins", date: "Aug 3", calories: "570 kcal"),
        Workout(id: 1, title: "Strength", image: "figure.run", tintColor: .red, duration: "51 mins", date: "Aug 1", calories: "570 kcal"),
        Workout(id: 2, title: "Walking", image: "figure.walk", tintColor: .purple, duration: "51 mins", date: "Aug 2", calories: "570 kcal"),
        Workout(id: 3, title: "Running", image: "figure.run", tintColor: .green, duration: "51 mins", date: "Aug 4", calories: "570 kcal")
    ]
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Welcome")
                        .font(.custom("Lobster-Regular", size: 34))
                        .padding()
                    
                    //Activity Rings and information
                    HStack {
                        Spacer()
                        VStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Calories")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.red)
                                
                                Text("123 kcal")
                                    .bold()
                            }
                            .padding(.bottom)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Active")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.green)
                                
                                Text("52 mins")
                                    .bold()
                            }
                            .padding(.bottom)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Stand")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.blue)
                                
                                Text("8 hours")
                                    .bold()
                            }
                            
                        }
                        
                        Spacer()
                        
                        ZStack {
                            ProgressCircleView(progress: $calories, color: .red, goal: 600)
                            ProgressCircleView(progress: $active, color: .green, goal: 60)
                                .padding(.all, 20)
                            ProgressCircleView(progress: $standing, color: .blue, goal: 100)
                                .padding(.all, 40)
                        }
                        .padding(.horizontal)
                        Spacer()
                    }
                    .padding()
                    
                    //FItness activity button
                    HStack {
                        Text("Fitness Activity")
                            .font(.title2)
                        
                        Spacer()
                        
                        Button {
                            print("show more")
                        } label: {
                            Text("Show more")
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal)
                    
                    //Activities
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                        ForEach(mockActivities, id: \.id) { activity in
                            ActivityCard(activity:activity)
                        }
                    }
                    .padding(.horizontal)
                    
                    //Recent workouts
                    HStack {
                        Text("Recent workouts")
                            .font(.title2)
                        Spacer()
                        NavigationLink {
                            EmptyView()
                        } label: {
                            Text("Show more")
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    //
                    LazyVStack {
                        ForEach(mockWorkouts, id: \.id) { workout in
                            WorkOutCard(workout:workout)
                        }
                    }
                    .padding(.bottom)
                    
                }
            }
        }
        
        
    }
}

#Preview {
    HomeView()
}
