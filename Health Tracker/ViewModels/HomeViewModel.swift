//
//  HomeViewModel.swift
//  Health Tracker
//
//  Created by Gordon Lee on 12/26/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    let healthManager = HealthManager.shared
    @Published var calories: Int = 23
    @Published var active: Int = 8
    @Published var standing: Int = 0
    
    @Published var mockActivities = [
        Activity(id: 0, title: "Today steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "9812"),
        Activity(id: 1, title: "Today steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .red, amount: "812"),
        Activity(id: 2, title: "Today steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .blue, amount: "9812"),
        Activity(id: 3, title: "Today steps", subtitle: "Goal 15,000", image: "figure.run", tintColor: .purple, amount: "104.87")
    ]
    
    @Published var mockWorkouts = [
        Workout(id: 0, title: "Running", image: "figure.run", tintColor: .cyan, duration: "51 mins", date: "Aug 3", calories: "570 kcal"),
        Workout(id: 1, title: "Strength", image: "figure.run", tintColor: .red, duration: "51 mins", date: "Aug 1", calories: "570 kcal"),
        Workout(id: 2, title: "Walking", image: "figure.walk", tintColor: .purple, duration: "51 mins", date: "Aug 2", calories: "570 kcal"),
        Workout(id: 3, title: "Running", image: "figure.run", tintColor: .green, duration: "51 mins", date: "Aug 4", calories: "570 kcal")
    ]
    
    init() {
        Task {
            do {
                try await healthManager.requestHealthKitAccess()
                
                fetchTodayCalories()
                fetchTodayStandHours()
                fetchTodayExerciseTime()
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func fetchTodayCalories() {
        healthManager.fetchTodayCaloriesBurned { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.calories = Int(success)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchTodayExerciseTime() {
        healthManager.fetchTodayExerciseTime { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.active = Int(success)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchTodayStandHours() {
        healthManager.fetchTodayStandHours { result in
            switch result {
            case .success(let HOURS):
                DispatchQueue.main.async {
                    self.standing = HOURS
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }
}
