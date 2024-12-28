//
//  HKWorkoutActivityType+Ext.swift
//  Health Tracker
//
//  Created by Gordon Lee on 12/28/24.
//

import HealthKit
import SwiftUI
extension HKWorkoutActivityType {

    /*
     Simple mapping of available workout types to a human readable name.
     */
    var name: String {
        switch self {
        case .americanFootball:             return "American Football"
        case .archery:                      return "Archery"
        case .australianFootball:           return "Australian Football"
        case .badminton:                    return "Badminton"
        case .baseball:                     return "Baseball"
        case .basketball:                   return "Basketball"
        case .bowling:                      return "Bowling"
        case .boxing:                       return "Boxing"
        case .climbing:                     return "Climbing"
        case .crossTraining:                return "Cross Training"
        case .curling:                      return "Curling"
        case .cycling:                      return "Cycling"
        case .dance:                        return "Dance"
        case .danceInspiredTraining:        return "Dance Inspired Training"
        case .elliptical:                   return "Elliptical"
        case .equestrianSports:             return "Equestrian Sports"
        case .fencing:                      return "Fencing"
        case .fishing:                      return "Fishing"
        case .functionalStrengthTraining:   return "Functional Strength Training"
        case .golf:                         return "Golf"
        case .gymnastics:                   return "Gymnastics"
        case .handball:                     return "Handball"
        case .hiking:                       return "Hiking"
        case .hockey:                       return "Hockey"
        case .hunting:                      return "Hunting"
        case .lacrosse:                     return "Lacrosse"
        case .martialArts:                  return "Martial Arts"
        case .mindAndBody:                  return "Mind and Body"
        case .mixedMetabolicCardioTraining: return "Mixed Metabolic Cardio Training"
        case .paddleSports:                 return "Paddle Sports"
        case .play:                         return "Play"
        case .preparationAndRecovery:       return "Preparation and Recovery"
        case .racquetball:                  return "Racquetball"
        case .rowing:                       return "Rowing"
        case .rugby:                        return "Rugby"
        case .running:                      return "Running"
        case .sailing:                      return "Sailing"
        case .skatingSports:                return "Skating Sports"
        case .snowSports:                   return "Snow Sports"
        case .soccer:                       return "Soccer"
        case .softball:                     return "Softball"
        case .squash:                       return "Squash"
        case .stairClimbing:                return "Stair Climbing"
        case .surfingSports:                return "Surfing Sports"
        case .swimming:                     return "Swimming"
        case .tableTennis:                  return "Table Tennis"
        case .tennis:                       return "Tennis"
        case .trackAndField:                return "Track and Field"
        case .traditionalStrengthTraining:  return "Traditional Strength Training"
        case .volleyball:                   return "Volleyball"
        case .walking:                      return "Walking"
        case .waterFitness:                 return "Water Fitness"
        case .waterPolo:                    return "Water Polo"
        case .waterSports:                  return "Water Sports"
        case .wrestling:                    return "Wrestling"
        case .yoga:                         return "Yoga"

        // iOS 10
        case .barre:                        return "Barre"
        case .coreTraining:                 return "Core Training"
        case .crossCountrySkiing:           return "Cross Country Skiing"
        case .downhillSkiing:               return "Downhill Skiing"
        case .flexibility:                  return "Flexibility"
        case .highIntensityIntervalTraining:    return "High Intensity Interval Training"
        case .jumpRope:                     return "Jump Rope"
        case .kickboxing:                   return "Kickboxing"
        case .pilates:                      return "Pilates"
        case .snowboarding:                 return "Snowboarding"
        case .stairs:                       return "Stairs"
        case .stepTraining:                 return "Step Training"
        case .wheelchairWalkPace:           return "Wheelchair Walk Pace"
        case .wheelchairRunPace:            return "Wheelchair Run Pace"

        // iOS 11
        case .taiChi:                       return "Tai Chi"
        case .mixedCardio:                  return "Mixed Cardio"
        case .handCycling:                  return "Hand Cycling"

        // iOS 13
        case .discSports:                   return "Disc Sports"
        case .fitnessGaming:                return "Fitness Gaming"

        // Catch-all
        default:                            return "Other"
        }
    }
    
    var image: String {
        switch self {
        case .americanFootball:             return "sportscourt"
        case .archery:                      return "target"
        case .australianFootball:           return "sportscourt"
        case .badminton:                    return "sportscourt"
        case .baseball:                     return "figure.baseball"
        case .basketball:                   return "figure.basketball"
        case .bowling:                      return "sportscourt"
        case .boxing:                       return "sportscourt"
        case .climbing:                     return "figure.climbing"
        case .crossTraining:                return "sportscourt"
        case .curling:                      return "sportscourt"
        case .cycling:                      return "bicycle"
        case .dance:                        return "figure.dance"
        case .danceInspiredTraining:        return "figure.dance"
        case .elliptical:                   return "sportscourt"
        case .equestrianSports:             return "sportscourt"
        case .fencing:                      return "sportscourt"
        case .fishing:                      return "sportscourt"
        case .functionalStrengthTraining:   return "dumbbell"
        case .golf:                         return "sportscourt"
        case .gymnastics:                   return "sportscourt"
        case .handball:                     return "sportscourt"
        case .hiking:                       return "figure.hiking"
        case .hockey:                       return "sportscourt"
        case .hunting:                      return "sportscourt"
        case .lacrosse:                     return "sportscourt"
        case .martialArts:                  return "sportscourt"
        case .mindAndBody:                  return "sportscourt"
        case .mixedMetabolicCardioTraining: return "sportscourt"
        case .paddleSports:                 return "sportscourt"
        case .play:                         return "sportscourt"
        case .preparationAndRecovery:       return "sportscourt"
        case .racquetball:                  return "sportscourt"
        case .rowing:                       return "sportscourt"
        case .rugby:                        return "sportscourt"
        case .running:                      return "figure.run"
        case .sailing:                      return "sportscourt"
        case .skatingSports:                return "sportscourt"
        case .snowSports:                   return "sportscourt"
        case .soccer:                       return "sportscourt"
        case .softball:                     return "sportscourt"
        case .squash:                       return "sportscourt"
        case .stairClimbing:                return "sportscourt"
        case .surfingSports:                return "sportscourt"
        case .tableTennis:                  return "sportscourt"
        case .tennis:                       return "sportscourt"
        case .trackAndField:                return "sportscourt"
        case .traditionalStrengthTraining:  return "dumbbell"
        case .volleyball:                   return "sportscourt"
        case .walking:                      return "figure.walk"
        case .waterFitness:                 return "sportscourt"
        case .waterPolo:                    return "sportscourt"
        case .waterSports:                  return "sportscourt"
        case .wrestling:                    return "sportscourt"
        case .yoga:                         return "sportscourt"
        case .swimming:                     return "figure.open.water.swim"
            
            // iOS 10
        case .barre:                        return "sportscourt"
        case .coreTraining:                 return "sportscourt"
        case .crossCountrySkiing:           return "sportscourt"
        case .downhillSkiing:               return "sportscourt"
        case .flexibility:                  return "sportscourt"
        case .highIntensityIntervalTraining:    return "sportscourt"
        case .jumpRope:                     return "sportscourt"
        case .kickboxing:                   return "sportscourt"
        case .pilates:                      return "sportscourt"
        case .snowboarding:                 return "sportscourt"
        case .stairs:                       return "sportscourt"
        case .stepTraining:                 return "sportscourt"
        case .wheelchairWalkPace:           return "sportscourt"
        case .wheelchairRunPace:            return "sportscourt"
            
            // iOS 11
        case .taiChi:                       return "sportscourt"
        case .mixedCardio:                  return "sportscourt"
        case .handCycling:                  return "sportscourt"
            
            // iOS 13
        case .discSports:                   return "sportscourt"
        case .fitnessGaming:                return "sportscourt"
            
        default:                            return "sportscourt"
        }
    }
    
    var color: Color {
            switch self {
            case .running, .trackAndField:              return .red
            case .cycling, .handCycling, .baseball:                return .orange
            case .yoga, .mindAndBody, .flexibility:     return .blue
            case .hiking, .walking:                     return .green
            case .swimming, .waterSports, .waterPolo:   return .cyan
            case .dance, .danceInspiredTraining:        return .pink
            case .functionalStrengthTraining,
                 .traditionalStrengthTraining:          return .black
            case .highIntensityIntervalTraining,
                 .crossTraining:                        return .yellow
            case .pilates, .barre, .basketball:         return .purple
            case .taiChi:                               return .mint
            case .boxing, .martialArts, .kickboxing:    return .brown
            case .climbing, .stairClimbing:             return .indigo
            case .snowSports, .snowboarding,
                 .crossCountrySkiing,
                 .downhillSkiing:                       return .white
            case .surfingSports:                        return .teal
            default:                                    return .green
            }
        }
}
