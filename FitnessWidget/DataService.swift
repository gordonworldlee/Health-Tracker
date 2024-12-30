//
//  DataService.swift
//  FitnessWidgetExtension
//
//  Created by Gordon Lee on 12/29/24.
//

import Foundation

import SwiftUI

class DataService {
    @AppStorage("calories", store: UserDefaults(suiteName: "group.gordon.Health-Tracker")) private var kcal = 0
    
    func update(amount: Int) {
        kcal = amount
    }
    init() {
        
    }
    func progress() -> Int {
        return kcal
    }
}
