//
//  HealthManager.swift
//  Health Tracker
//
//  Created by Gordon Lee on 12/27/24.
//

import Foundation
import HealthKit


extension Date {
    
    static var startOfDay: Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: Date())
    }

    static var startOfWeek: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        components.weekday = 2
        return calendar.date(from: components) ?? Date()
    }
    
    func fetchMontStartAndENdDate() -> (Date, Date) {
        let calendar = Calendar.current
        let startDateComponent = calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: self))
        
        let startDate = calendar.date(from: startDateComponent) ?? self
        let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate) ?? self
        
        return (startDate, endDate)
    }
    
    func formatWorkoutDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: self)
    }
}

extension Double {
    func formattedNumberString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        return formatter.string(from: NSNumber(value:self)) ?? "0"
    }
}

class HealthManager {
    
    static let shared = HealthManager()
    let healthStore = HKHealthStore()
    
    private init() {
    }
    
    func requestHealthKitAccess() async throws {
        let calories = HKQuantityType(.activeEnergyBurned)
        let exercise = HKQuantityType(.appleExerciseTime)
        let stand = HKCategoryType(.appleStandHour)
        let steps = HKQuantityType(.stepCount)
        let workout = HKSampleType.workoutType()
        let healthTypes: Set = [calories, exercise, stand, steps, workout]
        
        
        
        try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
    }
    
    func fetchTodayCaloriesBurned(completion: @escaping(Result<Double, Error>) -> Void) {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            
            let calorieCount = quantity.doubleValue(for: .kilocalorie())
            completion(.success(calorieCount))
        }
        healthStore.execute(query)
    }
    
    func fetchTodaySteps(completion: @escaping(Result<Double, Error>) -> Void) {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            
            let stepCount = quantity.doubleValue(for: .count())
            completion(.success(stepCount))
        }
        healthStore.execute(query)
    }
    
    func fetchTodayExerciseTime(completion: @escaping(Result<Double, Error>) -> Void) {
        let exercise = HKQuantityType(.appleExerciseTime)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        
        let query = HKStatisticsQuery(quantityType: exercise, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            
            let exerciseTime = quantity.doubleValue(for: .minute())
            completion(.success(exerciseTime))
        }
        healthStore.execute(query)
    }
    
    func fetchTodayStandHours(completion: @escaping(Result<Int, Error>) -> Void) {
        let stand = HKCategoryType(.appleStandHour)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        
        let query = HKSampleQuery(sampleType: stand, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) {_, results, error in
            
            guard let samples = results as? [HKCategorySample], error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            
            let standCount = samples.filter({$0.value == 0}).count
            
            completion(.success(standCount))
            
        }
        
        healthStore.execute(query)
    }
    
    func fetchCurrentWorkoutStats(completion: @escaping(Result<[Activity], Error>) -> Void) {
        let workout = HKSampleType.workoutType()
        let predicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        let query = HKSampleQuery(sampleType: workout, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { [weak self] _, results, error in
            guard let samples = results as? [HKWorkout], let self = self, error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }

            
            var runningCount: Int = 0
            var strengthCount: Int = 0
            var soccerCount: Int = 0
            var basketballCount: Int = 0
            var stairsCount: Int = 0
            var kickboxingCount: Int = 0
            
            for work in samples {
                let duration = Int(work.duration) / 60
                if work.workoutActivityType == .running {
                    runningCount += duration
                } else if work.workoutActivityType == .traditionalStrengthTraining {
                    strengthCount += duration
                } else if work.workoutActivityType == .soccer {
                    soccerCount += duration
                } else if work.workoutActivityType == .basketball {
                    basketballCount += duration
                } else if work.workoutActivityType == .stairClimbing {
                    stairsCount += duration
                } else if work.workoutActivityType == .kickboxing {
                    kickboxingCount += duration
                }
            }
            completion(.success(self.generateAcitivitiesFromDuerations(running: runningCount, strength: strengthCount, soccer: soccerCount, basketball: basketballCount, stairs: stairsCount, kickboxing: kickboxingCount)))
        }
        healthStore.execute(query)
    }
      
    func generateAcitivitiesFromDuerations(running: Int, strength: Int, soccer: Int, basketball: Int, stairs: Int, kickboxing: Int) -> [Activity] {
        return [
            Activity(title: "Running", subtitle: "This week", image: "figure.run", tintColor: .green, amount: "\(running) mins"),
            Activity(title: "Strength Training", subtitle: "This week", image: "dumbbell", tintColor: .blue, amount: "\(strength) mins"),
            Activity(title: "Soccer", subtitle: "This week", image: "figure.soccer", tintColor: .indigo, amount: "\(soccer) mins"),
            Activity(title: "Basketball", subtitle: "This week", image: "figure.basketball", tintColor: .red, amount: "\(basketball) mins"),
            Activity(title: "Stair Master", subtitle: "This week", image: "figure.stairs", tintColor: .black, amount: "\(stairs) mins"),
            Activity(title: "Kickboxing", subtitle: "This week", image: "figure.kickboxing", tintColor: .green, amount: "\(kickboxing) mins")
        ]
    }
    
    // MARK: Recent workouts
    
    func fetchWkorkoutsForMonth(month: Date, completion: @escaping(Result<[Workout], Error>) -> Void) {
        let workout = HKSampleType.workoutType()
        let (startDate, endDate) = month.fetchMontStartAndENdDate()
        let predicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: workout, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor])
        { _, results, error in
            guard let workouts = results as? [HKWorkout], error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            
            let workoutsArray = workouts.map({
                
                Workout(title: $0.workoutActivityType.name, image: $0.workoutActivityType.image, tintColor: $0.workoutActivityType.color, duration: "\(Int($0.duration)/60) mins", date: $0.startDate.formatWorkoutDate(), calories: ($0.totalEnergyBurned?.doubleValue(for: .kilocalorie()).formattedNumberString() ?? "-")  + " kcal")
                
            })
            completion(.success(workoutsArray))
                
        }
        healthStore.execute(query)
    }
    
    


}

// MARK: ChartsViewData
extension HealthManager {
    
    struct YearChartDataResult {
        let ytd: [MonthlyStepModel]
        let oneYear: [MonthlyStepModel]
    }
    
    func fetchYTDAndOneYearChartData(completion: @escaping (Result<YearChartDataResult, Error>) -> Void) {
        let steps = HKQuantityType(.stepCount)
        let calendar = Calendar.current
        
        var oneYearMonths = [MonthlyStepModel]()
        var ytdMonths = [MonthlyStepModel]()
        for i in 0...11 {
            let month = calendar.date(byAdding: .month, value: -i, to: Date()) ?? Date()
            let (startOfMonth, endOfMonth) = month.fetchMontStartAndENdDate()
            let predicate = HKQuery.predicateForSamples(withStart: startOfMonth, end: endOfMonth)
            
            
            let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, results, error in
                guard let steps = results?.sumQuantity()?.doubleValue(for: .count()), error == nil else {
                    completion(.failure(URLError(.badURL)))
                    return
                }
                
                if i == 0 {
                    oneYearMonths.append(MonthlyStepModel(date: month, count: Int(steps)))
                    ytdMonths.append(MonthlyStepModel(date: month, count: Int(steps)))
                } else {
                    oneYearMonths.append(MonthlyStepModel(date: month, count: Int(steps)))
                    if calendar.component(.year, from: Date()) == calendar.component(.year, from: month) {
                        ytdMonths.append(MonthlyStepModel(date: month, count: Int(steps)))
                    }
                }
                
                if i == 11 {
                    completion(.success(YearChartDataResult(ytd: ytdMonths, oneYear: oneYearMonths)))
                }
            }
            healthStore.execute(query)
        }
    }
    
    func fetchOneMonthChartData(completion: @escaping (Result<[DailyStepModel], Error>) -> Void) {
        let steps = HKQuantityType(.stepCount)
        let calendar = Calendar.current
        
        var dailySteps = [DailyStepModel]()
        let daysInMonth = calendar.range(of: .day, in: .month, for: Date())?.count ?? 30
        
        for i in 0..<daysInMonth {
            let day = calendar.date(byAdding: .day, value: -i, to: Date()) ?? Date()
            let startOfDay = calendar.startOfDay(for: day)
            let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) ?? day
            
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay)
            
            let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, results, error in
                guard let steps = results?.sumQuantity()?.doubleValue(for: .count()), error == nil else {
                    completion(.failure(URLError(.badURL)))
                    return
                }
                
                dailySteps.append(DailyStepModel(date: day, count: Int(steps)))
                
                if i == daysInMonth - 1 {
                    let sortedSteps = dailySteps.sorted { $0.date < $1.date }
                    completion(.success(sortedSteps))
                }
            }
            healthStore.execute(query)
        }
    }
    
    func fetchOneWeekChartData(completion: @escaping (Result<[DailyStepModel], Error>) -> Void) {
        let steps = HKQuantityType(.stepCount)
        let calendar = Calendar.current
        
        var dailySteps = [DailyStepModel]()
        
        for i in 0..<7 {
            let day = calendar.date(byAdding: .day, value: -i, to: Date()) ?? Date()
            let startOfDay = calendar.startOfDay(for: day)
            let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) ?? day
            
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay)
            
            let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, results, error in
                guard let steps = results?.sumQuantity()?.doubleValue(for: .count()), error == nil else {
                    completion(.failure(URLError(.badURL)))
                    return
                }
                
                dailySteps.append(DailyStepModel(date: day, count: Int(steps)))
                
                if i == 6 {
                    let sortedSteps = dailySteps.sorted { $0.date < $1.date }
                    completion(.success(sortedSteps))
                }
            }
            healthStore.execute(query)
        }
    }

    
    func fetchThreeMonthChartData(completion: @escaping (Result<[MonthlyStepModel], Error>) -> Void) {
        let steps = HKQuantityType(.stepCount)
        let calendar = Calendar.current
        
        var monthlySteps = [MonthlyStepModel]()
        let totalMonths = 3
        
        for i in 0..<totalMonths {
            let month = calendar.date(byAdding: .month, value: -i, to: Date()) ?? Date()
            let (startOfMonth, endOfMonth) = month.fetchMontStartAndENdDate()
            let predicate = HKQuery.predicateForSamples(withStart: startOfMonth, end: endOfMonth)
            
            let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, results, error in
                guard let steps = results?.sumQuantity()?.doubleValue(for: .count()), error == nil else {
                    completion(.failure(URLError(.badURL)))
                    return
                }
                
                monthlySteps.append(MonthlyStepModel(date: month, count: Int(steps)))
                
                if i == totalMonths - 1 {
                    let sortedSteps = monthlySteps.sorted { $0.date < $1.date }
                    completion(.success(sortedSteps))
                }
            }
            healthStore.execute(query)
        }
    }



}
