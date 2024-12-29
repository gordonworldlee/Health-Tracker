//
//  MonthlyStepModel.swift
//  Health Tracker
//
//  Created by Gordon Lee on 12/28/24.
//

import Foundation


struct MonthlyStepModel: Identifiable {
    let id = UUID()
    let date: Date
    let count: Int
}
