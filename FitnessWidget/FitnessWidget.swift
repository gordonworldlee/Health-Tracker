//
//  FitnessWidget.swift
//  FitnessWidget
//
//  Created by Gordon Lee on 12/29/24.
//

import WidgetKit
import SwiftUI


struct Provider: TimelineProvider {
    let data = DataService()
    //let manager = HealthManager.shared
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), calories: 500)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), calories: data.progress())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 1 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, calories: data.progress())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let calories: Int
    
}

struct FitnessWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .stroke(.blue.opacity(0.3), lineWidth: 20)
                
                Circle()
                    .trim(from: 0, to: CGFloat(entry.calories) / CGFloat(20000))
                    .stroke(.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .shadow(radius: 5)
            }
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image(systemName: "flame")
                        .foregroundColor(.orange)
                        .font(.system(size: 14))
                    Text("Calories")
                        .font(.system(size: 14, weight: .medium))
                }
                
                Text("\(Int(entry.calories))")
                    .font(.system(size: 24, weight: .bold))
                
                Text(entry.date, style: .time)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            .padding(8)
            .frame(maxWidth: 120)
        }

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
