//
//  Health_TrackerApp.swift
//  Health Tracker
//
//  Created by Gordon Lee on 12/24/24.
//

import SwiftUI
import FirebaseCore
@main
struct Health_TrackerApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            FitnessTabView()
        }
    }
}
