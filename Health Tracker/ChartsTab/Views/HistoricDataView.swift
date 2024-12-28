//
//  HistoricDataView.swift
//  Health Tracker
//
//  Created by Gordon Lee on 12/26/24.
//

import SwiftUI
import Charts

struct DailyStepModel: Identifiable {
    let id = UUID()
    let date: Date
    let count: Double
    
}

enum ChartOptions: String, CaseIterable {
    case oneWeek = "1W"
    case oneMonth = "1M"
    case threeMonth = "3M"
    case yearToDate = "YTD"
    case oneYear = "1Y"
}

class ChartsViewModel: ObservableObject {
    var mockChartData = [
        
        DailyStepModel(date: Date(), count: 12315),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), count: 9975),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), count: 8094),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(), count: 9975),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(), count: 10275),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(), count: 2222),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date(), count: 11234)
        
    ]
    
    var mockOneMonthData = [
        DailyStepModel(date: Date(), count: 13183),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), count: 13305),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), count: 12630),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(), count: 11527),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(), count: 5824),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(), count: 2469),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date(), count: 10110),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date(), count: 6864),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -8, to: Date()) ?? Date(), count: 2541),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -9, to: Date()) ?? Date(), count: 3537),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -10, to: Date()) ?? Date(), count: 6392),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -11, to: Date()) ?? Date(), count: 4797),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -12, to: Date()) ?? Date(), count: 14840),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -13, to: Date()) ?? Date(), count: 14694),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -14, to: Date()) ?? Date(), count: 11748),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -15, to: Date()) ?? Date(), count: 5046),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -16, to: Date()) ?? Date(), count: 8672),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -17, to: Date()) ?? Date(), count: 12634),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -18, to: Date()) ?? Date(), count: 10864),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -19, to: Date()) ?? Date(), count: 14029),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -20, to: Date()) ?? Date(), count: 10807),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -21, to: Date()) ?? Date(), count: 13008),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -22, to: Date()) ?? Date(), count: 10427),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -23, to: Date()) ?? Date(), count: 9816),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -24, to: Date()) ?? Date(), count: 12111),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -25, to: Date()) ?? Date(), count: 2193),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -26, to: Date()) ?? Date(), count: 6967),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -27, to: Date()) ?? Date(), count: 11809),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -28, to: Date()) ?? Date(), count: 9955),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -29, to: Date()) ?? Date(), count: 14468)
    ]

}

struct HistoricDataView: View {
    @StateObject var viewModel = ChartsViewModel()
    @State var selectedChart: ChartOptions = .oneWeek
    var body: some View {
        VStack {
            Text("Charts")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            ZStack {
                switch selectedChart {
                case .oneWeek:
                    Chart {
                        ForEach(viewModel.mockChartData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.count))
                            
                        }
                    }
                case .oneMonth:
                    Chart {
                        ForEach(viewModel.mockOneMonthData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.count))
                            
                        }
                    }
                case .threeMonth:
                    Chart {
                        ForEach(viewModel.mockChartData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.count))
                            
                        }
                    }
                case .yearToDate:
                    Chart {
                        ForEach(viewModel.mockOneMonthData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.count))
                            
                        }
                    }
                case .oneYear:
                    Chart {
                        ForEach(viewModel.mockChartData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.count))
                        }
                    }
                }
            }
            
            .foregroundColor(.green)
            .frame(maxHeight: 350)
            .padding(.horizontal)
            
            //Buttons
            HStack {
                ForEach(ChartOptions.allCases, id: \.rawValue) { option in
                    Button(option.rawValue) {
                        withAnimation {
                            selectedChart = option
                        }
                        
                    }
                    .padding()
                    .foregroundColor(selectedChart == option ? .white: .green)
                    .background(selectedChart == option ? .green : .white)
                    .cornerRadius(10)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    HistoricDataView()
}
