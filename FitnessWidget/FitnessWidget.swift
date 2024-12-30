//
//  FitnessWidget.swift
//  FitnessWidget
//
//  Created by Gordon Lee on 12/29/24.
//

import WidgetKit
import SwiftUI


struct Provider: TimelineProvider {
    //let manager = HealthManager.shared
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), calories: 500)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), calories: 500)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 1 {
            let userDefaults = UserDefaults(suiteName: "group.gordon.Health-Tracker")
            let text = userDefaults?.value(forKey: "text") as? Int ?? 0
            
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, calories: text)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }


}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let calories: Int
    
}

struct FitnessWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            // Background Circle
            Circle()
                .stroke(Color.blue.opacity(0.1), lineWidth: 15)
            
            // Progress Circle
            Circle()
                .trim(from: 0, to: min(CGFloat(entry.calories) / 20000, 1.0))
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .cyan]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(lineWidth: 15, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .shadow(radius: 3)
            
            // Content
            VStack(spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: "flame.fill")
                        .foregroundStyle(.orange)
                        .font(.system(size: 12))
                    Text("Calories")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.secondary)
                }
                
                Text("\(Int(entry.calories))")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primary)
                    .minimumScaleFactor(0.6)
                
                Text(entry.date.formatted(date: .omitted, time: .shortened))
                    .font(.system(size: 10))
                    .foregroundStyle(.secondary)
            }
        }
        .padding(8)
    }
}


struct FitnessWidget: Widget {
    let kind: String = "FitnessWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                FitnessWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                FitnessWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    FitnessWidget()
} timeline: {
    SimpleEntry(date: .now, calories: 5)
    SimpleEntry(date: .now, calories: 6)
}
