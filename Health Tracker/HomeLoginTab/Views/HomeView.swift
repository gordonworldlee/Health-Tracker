//
//  HomeView.swift
//  Health Tracker
//
//  Created by Gordon Lee on 12/26/24.
//

import SwiftUI
import WidgetKit

struct HomeView: View {

    
    @StateObject var viewModel = HomeViewModel() 
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
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Calories")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.red)
                                
                                Text("\(viewModel.calories)")
                                    .bold()
                                
                            }
                            .padding(.bottom)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Active Hours")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.green)
                                
                                Text("\(viewModel.active)")
                                    .bold()
                                
                            }
                            .padding(.bottom)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Steps")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.blue)
                                
                                Text("\(viewModel.steps)")
                                    .bold()
                            }
                            
                        }
                        
                        Spacer()
                        
                        ZStack {
                            ProgressCircleView(progress: $viewModel.calories, color: .red, goal: 2000)
                            ProgressCircleView(progress: $viewModel.active, color: .green, goal: 60)
                                .padding(.all, 20)
                            ProgressCircleView(progress: $viewModel.steps, color: .blue, goal: 10000)
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
                    
                    
                    if !viewModel.activities.isEmpty {
                        //Activities
                        LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                            ForEach(viewModel.activities, id: \.title) { activity in
                                ActivityCard(activity:activity)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
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
                    
                    //Workout 
                    LazyVStack {
                        ForEach(viewModel.workouts, id: \.title) { workout in
                            WorkOutCard(workout:workout)
                        }
                    }
                    .padding(.bottom)
                    
                }
            }
        }
        .onAppear {
            let userDefaults = UserDefaults(suiteName: "group.gordon.Health-Tracker")
            userDefaults?.setValue(viewModel.calories, forKey: "text")
            WidgetCenter.shared.reloadTimelines(ofKind: "FitnessWidget")
        }
        
        
    }
}

#Preview {
    HomeView()
}
